import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechConverter {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> convertTextToSpeech(String text) async {
    await flutterTts
        .setLanguage("en-US"); // Set the language (adjust as needed)
    await flutterTts.setPitch(1.0); // Set the pitch (adjust as needed)
    await flutterTts
        .setSpeechRate(0.5); // Set the speech rate (adjust as needed)

    await flutterTts.speak(text);
  }
}