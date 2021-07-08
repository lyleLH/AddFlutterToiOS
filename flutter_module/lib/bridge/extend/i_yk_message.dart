///发送的业务消息需实现该抽象类
abstract class IYkMessage<T> {
  ///把json转换成map
  Map<String, dynamic> toJsonMap();

  ///把map转成T对象
  T toObject(Map<String, dynamic> map);
}
