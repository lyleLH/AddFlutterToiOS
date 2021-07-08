
import 'dart:async';

import 'package:flutter/services.dart';

class YeahkaBasicChannel {
  static const MethodChannel _channel =
      const MethodChannel('yeahka_basic_channel');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
