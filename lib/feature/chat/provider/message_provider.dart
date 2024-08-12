import 'dart:io';
import 'dart:typed_data';

import 'package:athena_ai/core/config/type_of_bot.dart';
import 'package:athena_ai/core/config/type_of_message.dart';
import 'package:athena_ai/core/logger/logger.dart';
import 'package:athena_ai/feature/gemini/models/candidates/candidates.dart';
import 'package:athena_ai/feature/gemini/models/content/content.dart';
import 'package:athena_ai/feature/gemini/models/parts/parts.dart';
import 'package:athena_ai/feature/gemini/repository/gemini_repository.dart';
import 'package:athena_ai/feature/hive/model/chat_bot/chat_bot.dart';
import 'package:athena_ai/feature/hive/model/chat_message/chat_message.dart';
import 'package:athena_ai/feature/hive/repository/hive_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final messageListProvider = StateNotifierProvider<MessageListNotifier, ChatBot>(
    (ref) => MessageListNotifier());

class MessageListNotifier extends StateNotifier<ChatBot> {
  MessageListNotifier()
      : super(ChatBot(messagesList: [], id: '', title: '', typeOfBot: ''));

  final uuid = const Uuid();
  final geminiRepository = GeminiRepository();

  Future<void> updateChatBotWithMessage(ChatMessage message) async {
    final newMessageList = [...state.messagesList, message.toJson()];
    await updateChatBot(ChatBot(
        messagesList: newMessageList,
        id: state.id,
        title: state.title.isEmpty ? message.text : state.title,
        typeOfBot: state.typeOfBot,
        attachmentPath: state.attachmentPath,
        embeddings: state.embeddings));
  }

  Future<void> handleSendPressed(
      {required String text, String? imageFilePath}) async {
    final messageId = uuid.v4();
    final ChatMessage message = ChatMessage(
        id: messageId,
        text: text,
        createdAt: DateTime.now(),
        typeOfMessage: TypeOfMessage.user,
        chatBotId: state.id);
    await updateChatBotWithMessage(message);
    // call the get response by gemini in here ............................pendinggggggg
    await getGeminiResponse(prompt: text, imageFilePath: imageFilePath);
  }

  Future<void> getGeminiResponse({
    required String prompt,
    String? imageFilePath,
  }) async {
    final List<Parts> chatParts = state.messagesList.map((msg) {
      return Parts(text: msg['text'] as String);
    }).toList();

    if (state.typeOfBot == TypeOfBot.pdf) {
      final embeddingForPrompt = await geminiRepository.promptForEmbedding(
          userPrompt: prompt, embeddings: state.embeddings);
      chatParts.add(Parts(text: embeddingForPrompt));
    } else {
      chatParts.add(Parts(text: prompt));
    }
    final content = Content(parts: chatParts);
    Stream<Candidates> responseStream;
    ChatMessage placeholderMessage;
    if (imageFilePath != null && state.typeOfBot == TypeOfBot.image) {
      final Uint8List imageBytes = File(imageFilePath).readAsBytesSync();
      responseStream =
          geminiRepository.streamContent(content: content, image: imageBytes);
    } else {
      responseStream = geminiRepository.streamContent(content: content);
    }
    final String modelMessageId = uuid.v4();
    placeholderMessage = ChatMessage(
        id: modelMessageId,
        text: 'waiting for response.....',
        createdAt: DateTime.now(),
        typeOfMessage: TypeOfMessage.bot,
        chatBotId: state.id);

    await updateChatBotWithMessage(placeholderMessage);

    final StringBuffer fullResponseText = StringBuffer();

    responseStream.listen((response) async {
      if (response.content!.parts!.isNotEmpty) {
        fullResponseText.write(response.content!.parts!.first.text);
        final int messageIndex =
            state.messagesList.indexWhere((msg) => msg['id'] == modelMessageId);
        if (messageIndex != -1) {
          final newMessageList =
              List<Map<String, dynamic>>.from(state.messagesList);
          newMessageList[messageIndex]['text'] = fullResponseText.toString();
          final newState = ChatBot(
              messagesList: newMessageList,
              id: state.id,
              title: state.title,
              typeOfBot: state.typeOfBot,
              attachmentPath: state.attachmentPath,
              embeddings: state.embeddings);
          await updateChatBot(newState);
        }
      }
    }).onError((error) {
      logError('Error in response stream $error');
    });
  }

  Future<void> updateChatBot(ChatBot newChatBot) async {
    state = newChatBot;
    await HiveRepository().saveChatBot(chatBot: state);
  }
}
