import 'package:flutter/services.dart';

class AudioHelper {
  static const MethodChannel _channel = MethodChannel('audio_helper');

  static Future<bool> isAudioOutputAvailable(int type) async {
    final bool available = await _channel.invokeMethod('audioOutputAvailable', {"type": type});
    return available;
  }
}
