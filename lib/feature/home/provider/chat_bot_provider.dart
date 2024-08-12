import 'dart:io';

import 'package:athena_ai/feature/gemini/repository/gemini_repository.dart';
import 'package:athena_ai/feature/hive/repository/hive_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../hive/model/chat_bot/chat_bot.dart';

final chatBotListProvider =
    StateNotifierProvider<ChatBotListNotifier, List<ChatBot>>(
        (ref) => ChatBotListNotifier());

class ChatBotListNotifier extends StateNotifier<List<ChatBot>> {
  ChatBotListNotifier() : super([]) {
    hiveRepository = HiveRepository();
    dio = Dio();
    geminiRepository = GeminiRepository();
  }
  late final HiveRepository hiveRepository;
  late final Dio dio;
  late final GeminiRepository geminiRepository;

  Future<String?>? attachImageFile() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    return pickedFile?.path;
  }

  Future<void> fetchChatBots() async {
    final chatBotList = await hiveRepository.getChatBots();
    state = chatBotList;
  }

  Future<void> saveChatBot(ChatBot chatBot) async {
    await hiveRepository.saveChatBot(chatBot: chatBot);
    // ... is called spread notifier
    state = [chatBot, ...state];
  }

  Future<void> updateChatBotOnHomeScreen(ChatBot chatBot) async {
    final index = state.indexWhere((element) => element.id == chatBot.id);
    if (index != -1) {
      state[index] = chatBot;
      state = List.from(state);
    }
  }

  Future<void> deleteChatBotWithEmptyTitle() async {
    final chatBotswithNonEmptyTitle =
        state.where((chatbot) => chatbot.title.isNotEmpty).toList();
    for (final chatBot in state.where((chatbot) => chatbot.title.isEmpty)) {
      await hiveRepository.deleteChatBot(chatBot: chatBot);
    }
    state = chatBotswithNonEmptyTitle;
  }

  Future<void> deleteChatBot(ChatBot chatBot) async {
    await hiveRepository.deleteChatBot(chatBot: chatBot);
    state = state.where((item) => item.id != chatBot.id).toList();
  }

  Future<Map<String, List<num>>> batchEmbedChunks(
    List<String> textChuks,
  ) async {
    final response = geminiRepository.batchEmbedeChunks(textChunks: textChuks);
    return response;
  }

  Future<List<String>> getChunksFromPDF(String filePath) async {
    final List<String> pageTextChunks = [];

    final PdfDocument document = PdfDocument(
      inputBytes: await File(filePath).readAsBytes(),
    );

    final PdfTextExtractor extractor = PdfTextExtractor(document);

    for (int pageIndex = 0; pageIndex < document.pages.count; pageIndex++) {
      final List<TextLine> textLines =
          extractor.extractTextLines(startPageIndex: pageIndex);
      final int halfLineIndex = (textLines.length / 2).floor();
      final StringBuffer firstHalfText = StringBuffer();
      final StringBuffer secondHalfText = StringBuffer();

      for (int lineIndex = 0; lineIndex < textLines.length; lineIndex++) {
        if (lineIndex < halfLineIndex) {
          firstHalfText.writeln(textLines[lineIndex].text);
        } else {
          secondHalfText.writeln(textLines[lineIndex].text);
        }
      }
      if (firstHalfText.isNotEmpty) {
        pageTextChunks.add(firstHalfText.toString());
      }
      if (secondHalfText.isNotEmpty) {
        pageTextChunks.add(secondHalfText.toString());
      }
    }
    return pageTextChunks;
  }
}
