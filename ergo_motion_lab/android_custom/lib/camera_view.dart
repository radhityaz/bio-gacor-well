import 'dart:async';
import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

// Android manifest permission:
// <uses-permission android:name="android.permission.CAMERA"/>

class CameraView extends StatefulWidget {
  const CameraView({Key? key}) : super(key: key);

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late CameraController _controller;
  final _channel = const MethodChannel('camera_stream');
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final cameras = await availableCameras();
    _controller = CameraController(
      cameras.first,
      ResolutionPreset.medium,
      enableAudio: false,
    );
    await _controller.initialize();
    await _controller.startImageStream(_processImage);
    setState(() => _initialized = true);
  }

  Future<void> _processImage(CameraImage image) async {
    final img.Image i = img.Image.fromBytes(
      width: image.width,
      height: image.height,
      bytes: image.planes[0].bytes,
      order: img.ChannelOrder.bgra,
    );
    final bytes = img.encodeJpg(i);
    final data = base64Encode(bytes);
    await _channel.invokeMethod('newFrame', data);
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const SizedBox();
    }
    return CameraPreview(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
