class YkBasic {
  static const String PLATFORM_FLUTTER = "flutter";
  static const String PLATFORM_NATIVE = "native";

  ///消息序列号
  int sequence = 0;

  ///消息的时间戳
  int timestamp = 0;

  ///发送方
  String fromPlatform = "";

  ///接收方
  String toPlatform = "";
}
