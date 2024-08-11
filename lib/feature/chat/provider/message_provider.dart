import 'package:athena_ai/core/config/type_of_message.dart';
import 'package:athena_ai/feature/gemini/repository/gemini_repository.dart';
import 'package:athena_ai/feature/hive/model/chat_bot/chat_bot.dart';
import 'package:athena_ai/feature/hive/model/chat_message/chat_message.dart';
import 'package:athena_ai/feature/hive/repository/hive_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

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

  Future<void> handleSendPressed({
    required String text,
    String? imageFilePath
  }) async {
    final messageId = uuid.v4();
    final ChatMessage message = ChatMessage(
      id: messageId, 
      text: text, 
      createdAt: DateTime.now(), 
      typeOfMessage: TypeOfMessage.user, 
      chatBotId: state.id
      );
      await updateChatBotWithMessage(message);
      // call the get response by gemini in here ............................pendinggggggg
  }

  Future<void> getGeminiResponse({})

  Future<void> updateChatBot(ChatBot newChatBot) async {
    state = newChatBot;
    await HiveRepository().saveChatBot(chatBot: state);
  }
}
