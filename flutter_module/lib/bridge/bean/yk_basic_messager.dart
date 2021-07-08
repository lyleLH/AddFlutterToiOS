import 'package:flutter_module/bridge/bean/yk_basic_bean.dart';

///消息发送者
class YkBasicMessager extends YkBasic {
  ///发送消息的标签
  String msgTag = "";

  ///发送消息的消息体
  String? msgBody;

  ///是否需要回执消息
  bool needReply = false;

  YkBasicMessager(int sequence, String msgTag, String? msgBody, bool needReply,
      int timestamp, String fromPlatform, String toPlatform) {
    super.sequence = sequence;
    this.msgTag = msgTag;
    this.msgBody = msgBody;
    this.needReply = needReply;
    super.timestamp = timestamp;
    super.fromPlatform = fromPlatform;
    super.toPlatform = toPlatform;
  }

  Map<String, dynamic> toJson() {
    return {
      "sequence": sequence,
      "msgTag": msgTag,
      "msgBody": msgBody,
      "needReply": needReply,
      "timestamp": timestamp,
      "fromPlatform": fromPlatform,
      "toPlatform": toPlatform
    };
  }

  YkBasicMessager.formJson(Map<String, dynamic> json) {
    sequence = json["sequence"];
    msgTag = json["msgTag"];
    msgBody = json["msgBody"];
    needReply = json["needReply"];
    timestamp = json["timestamp"];
    fromPlatform = json["fromPlatform"];
    toPlatform = json["toPlatform"];
  }
}
