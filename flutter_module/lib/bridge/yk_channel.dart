import 'dart:collection';
import 'dart:convert';

import 'package:flutter/services.dart';

import 'bean/yk_basic_messager.dart';
import 'bean/yk_basic_replier.dart';
import 'extend/i_yk_message.dart';

typedef OnReceived = Future<Object?> Function(Map<String, dynamic> message);

class YkChannel {
  static final _channelName = "com.yeahka.common.channel";

  //单例模式
  static YkChannel? _instance;

  YkChannel._internal() {
    _initChannel();
  }

  factory YkChannel.getInstance() => _getInstance();

  //移卡通用BasicMessageChannel
  static BasicMessageChannel<Object?>? _ykMessageChannel;

  static _getInstance() {
    // 只能有一个实例
    if (_instance == null) {
      _instance = YkChannel._internal();
    }
    return _instance;
  }

  //消息序列
  int _sequence = 0;

  Map<String, _ChannelRegister> observers = HashMap();

  //初始化BasicMessageChannel和消息监听
  _initChannel() {
    _ykMessageChannel =
        BasicMessageChannel<Object?>(_channelName, JSONMessageCodec());

    _ykMessageChannel?.setMessageHandler((Object? message) async {
      if (message != null) {
        Map<String, dynamic> map = jsonDecode(message.toString());
        var messager = YkBasicMessager.formJson(map);

        var tag = messager.msgTag;
        var register = observers[tag];
        if (register != null) {
          register.doExecute(messager);
        } else {
          print("No message listener named $tag is registered.");
        }
      } else {
        print("Received message is null? It's not possible.");
      }
    });
  }

  /// message 待发送的消息
  /// tag 消息发送的标签，native解析使用，如果不传则为消息对象的类名
  /// needReply 是否需要native对消息进行回复，默认不需要
  Future<Map<String, dynamic>?> sendMessage(IYkMessage message,
      {String? tag, bool needReply = true}) async {
    var runtimeType = message.runtimeType.toString();
    print("runtimeType = $runtimeType");
    if (null == tag) {
      tag = runtimeType;
    }

    var ykBasicMessage = YkBasicMessager(_sequence, tag, jsonEncode(message),
        needReply, DateTime.now().millisecondsSinceEpoch, "flutter", "native");
    var messageJson = jsonEncode(ykBasicMessage);
    print("messageJson = $messageJson");

    var result = await _ykMessageChannel?.send(messageJson);
    if (result != null) {
      print("result = $result");
      print("resultType = ${result.runtimeType}");
      Map<String, dynamic> resultMap = json.decode(result.toString());
      var replyString = resultMap["reply"];
      print("replyString = $replyString");
      var replier = YkBasicReplier.formJson(resultMap);
      var reply = replier.reply;
      if (reply != null) {
        return jsonDecode(reply);
      }
    }
    return null;
  }

  ///注册消息监听
  void register<T extends IYkMessage<T>>(String tag, OnReceived onReceived) {
    var register = _ChannelRegister(tag, onReceived);

    observers[tag] = register;
  }
}

class _ChannelRegister {
  String tag;

  OnReceived onReceived;

  _ChannelRegister(this.tag, this.onReceived);

  Future<Object?> doExecute(YkBasicMessager messager) async {
    var body = messager.msgBody;
    if (body != null) {
      var bodyMap = jsonDecode(body);
      print("bodyMap = $bodyMap");

      onReceived(bodyMap);
    } else {
      print("Message body must not be null!");
    }
  }
}
