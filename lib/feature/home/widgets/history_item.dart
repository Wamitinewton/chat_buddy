import 'package:athena_ai/core/extension/context.dart';
import 'package:athena_ai/core/navigation/route.dart';
import 'package:athena_ai/feature/chat/provider/message_provider.dart';
import 'package:athena_ai/feature/hive/model/chat_bot/chat_bot.dart';
import 'package:athena_ai/feature/home/provider/chat_bot_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryItem extends ConsumerWidget {
  const HistoryItem(
      {super.key,
      required this.label,
      required this.imagePath,
      required this.color,
      required this.chatBot});

  final String label;
  final String imagePath;
  final Color color;
  final ChatBot chatBot;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ElevatedButton(
        onPressed: () {
          ref.read(messageListProvider.notifier).updateChatBot(chatBot);
          AppRoute.chat.push(context);
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: context.colorScheme.surface,
            foregroundColor: color,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side:
                    BorderSide(color: context.colorScheme.outline, width: 0.5)),
            padding: const EdgeInsets.all(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: color,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(imagePath),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
                child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onPrimary
                      .withOpacity(0.95)),
            )),
            IconButton(
              onPressed: () {
                ref.read(chatBotListProvider.notifier).deleteChatBot(chatBot);
              },
              icon: Icon(
                Icons.delete,
                color: context.colorScheme.onSurface,
              ),
            )
          ],
        ),
      ),
    );
  }
}
