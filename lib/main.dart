import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'audio_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AudioScreen(),
    );
  }
}

class AudioScreen extends StatefulWidget {
  @override
  _AudioScreenState createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isSpeakerAvailable = false;
  bool _isBluetoothAvailable = false;

  @override
  void initState() {
    super.initState();
    checkAudioDevices();
  }

  Future<void> checkAudioDevices() async {
    bool speaker = await AudioHelper.isAudioOutputAvailable(2); // Speaker
    bool bluetooth = await AudioHelper.isAudioOutputAvailable(8); // Bluetooth

    setState(() {
      _isSpeakerAvailable = speaker;
      _isBluetoothAvailable = bluetooth;
    });
  }

  void playAudio() async {
    await _audioPlayer.play('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3');
  }

  void openBluetoothSettings() {
    const platform = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Wear OS Assistente")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Speaker disponível: $_isSpeakerAvailable"),
            Text("Bluetooth disponível: $_isBluetoothAvailable"),
            ElevatedButton(
              onPressed: playAudio,
              child: Text("Reproduzir Áudio"),
            ),
            ElevatedButton(
              onPressed: openBluetoothSettings,
              child: Text("Abrir Configurações Bluetooth"),
            ),
          ],
        ),
      ),
    );
  }
}
