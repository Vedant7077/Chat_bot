// ignore_for_file: avoid_print
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gemini_api/models/chat_message_model.dart';

class SpaceRepo {
  static Future<void> chatTextGenerationRepo(List<ChatMessageModel> previousMessages) async {
    try {
      Dio dio = Dio();
      final response = await dio.post(
        "https://generativelanguage.googleapis.com/upload/v1beta/files?key=${dotenv.env["API_KEY"]}",
        data: {
          "contents": previousMessages.map((e) => e.toMap()).toList(),
          "generationConfig": {
            "temperature": 1,
            "topK": 40,
            "topP": 0.95,
            "maxOutputTokens": 8192,
            "responseMimeType": "text/plain",
          }
        },
      );
      print(response.data.toString());
    } catch (e) {
      print(e.toString());
    }
  }
}
