import 'package:flutter_tts/flutter_tts.dart';

FlutterTts _flutterTts = FlutterTts();
Future<void> fetchAndSpeak(String res) async {
  String TTS_INPUT = res;
  await _flutterTts.speak(TTS_INPUT);
}

Future<void> stopSpeaking() async {
  await _flutterTts.stop();
}