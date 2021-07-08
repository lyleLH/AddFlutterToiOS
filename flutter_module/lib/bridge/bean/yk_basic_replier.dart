import 'package:yeahka_basic_channel/bean/yk_basic_bean.dart';

///消息回复者
class YkBasicReplier extends YkBasic {
  //消息回执的状态，是否执行成功
  bool status = false;
  //回执消息的消息体
  String? reply;

  YkBasicReplier(int sequence, bool status, String? reply, int timestamp,
      String fromPlatform, String toPlatform) {
    super.sequence = sequence;
    this.status = status;
    this.reply = reply;
    super.timestamp = timestamp;
    super.fromPlatform = fromPlatform;
    super.toPlatform = toPlatform;
  }

  Map<String, dynamic> toJson() {
    return {
      "sequence": sequence,
      "status": status,
      "reply": reply,
      "timestamp": timestamp,
      "fromPlatform": fromPlatform,
      "toPlatform": toPlatform
    };
  }

  YkBasicReplier.formJson(Map<String, dynamic> json) {
    sequence = json["sequence"];
    status = json["status"];
    reply = json["reply"];
    timestamp = json["timestamp"];
    fromPlatform = json["fromPlatform"];
    toPlatform = json["toPlatform"];
  }
}
