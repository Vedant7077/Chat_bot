// ignore_for_file: avoid_print
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gemini_api/models/chat_message_model.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class SpaceRepo {
  static Future<String> chatTextGenerationRepo(
      List<ChatMessageModel> previousMessages) async {
    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: dotenv.env['API_KEY'] ?? "",
      );
      final previousMessagesLength = previousMessages.length;
      final prompt = previousMessagesLength > 3
          ? previousMessages.sublist(previousMessagesLength - 3)
          : previousMessages;
          print(prompt);
      final promptText = prompt.map((e) => e.toMap()).toList();
      print(promptText);
      final content = [Content.text(promptText.toString())];
      final response = await model.generateContent(content);
      print(previousMessages.length);
      print(response.text);
      return response.text??"";
    } catch (e) {
      return "";
      print(e.toString());
    }
  }
}
