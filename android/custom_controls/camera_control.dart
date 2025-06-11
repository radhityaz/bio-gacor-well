import 'dart:async';
import 'package:flutter/services.dart';

class CustomCameraControl {
  static const MethodChannel _channel = MethodChannel('ergomotion/camera');

  static Stream<dynamic> get frameStream =>
      _eventChannel.receiveBroadcastStream();

  static const EventChannel _eventChannel =
      EventChannel('ergomotion/camera_stream');

  static Future<void> start() async {
    await _channel.invokeMethod('start');
  }

  static Future<void> stop() async {
    await _channel.invokeMethod('stop');
  }
}
