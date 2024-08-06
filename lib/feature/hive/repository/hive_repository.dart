import 'package:athena_ai/feature/hive/model/chat_bot/chat_bot.dart';
import 'package:athena_ai/feature/hive/repository/base_hive_repository.dart';
import 'package:hive/hive.dart';

class HiveRepository extends BaseHiveRepository {
  HiveRepository();
  final Box<ChatBot> _chatBot = Hive.box<ChatBot>('chatbots');
  @override
  Future<void> deleteChatBot({required ChatBot chatBot}) async {
    await _chatBot.put(chatBot.id, chatBot);
  }

  @override
  Future<List<ChatBot>> getChatBots() async {
    final chatBotBox = await Hive.openBox<ChatBot>('chatbots');
    final List<ChatBot> chatBotList = chatBotBox.values.toList();
    return chatBotList;
  }

  @override
  Future<void> saveChatBot({required ChatBot chatBot}) async {
    await _chatBot.delete(chatBot.id);
  }
}
