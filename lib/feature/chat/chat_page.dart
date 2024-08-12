import 'dart:io';

import 'package:athena_ai/core/config/assets_constants.dart';
import 'package:athena_ai/core/config/type_of_bot.dart';
import 'package:athena_ai/core/extension/context.dart';
import 'package:athena_ai/feature/chat/provider/message_provider.dart';
import 'package:athena_ai/feature/chat/widgets/chat_interface.dart';
import 'package:athena_ai/feature/home/provider/chat_bot_provider.dart';
import 'package:athena_ai/feature/home/widgets/background_curves_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:go_router/go_router.dart';

class ChatPage extends ConsumerWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatBot = ref.watch(messageListProvider);
    final color = chatBot.typeOfBot == TypeOfBot.pdf
        ? context.colorScheme.primary
        : chatBot.typeOfBot == TypeOfBot.text
            ? context.colorScheme.secondary
            : context.colorScheme.tertiary;

    final imagPath = chatBot.typeOfBot == TypeOfBot.pdf
        ? AssetConstants.pdfLogo
        : chatBot.typeOfBot == TypeOfBot.image
            ? AssetConstants.imageLogo
            : AssetConstants.textLogo;

    final title = chatBot.typeOfBot == TypeOfBot.pdf
        ? 'PDF'
        : chatBot.typeOfBot == TypeOfBot.image
            ? 'Image'
            : 'Text';

    final List<types.Message> messages = chatBot.messagesList.map((msg) {
      return types.TextMessage(
          author: types.User(id: msg['typeOfMessage'] as String),
          createdAt:
              DateTime.parse(msg['createdAt'] as String).millisecondsSinceEpoch,
          id: msg['id'] as String,
          text: msg['text'] as String);
    }).toList()
      ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    return PopScope(
        canPop: false,
        child: Scaffold(
          body: SafeArea(
              child: Stack(
            children: [
              Positioned(
                  height: -300,
                  width: -00,
                  child: Container(
                    height: 500,
                    width: 600,
                    decoration: BoxDecoration(
                        gradient: RadialGradient(colors: [
                      color.withOpacity(0.5),
                      // ignore: deprecated_member_use
                      context.colorScheme.background.withOpacity(0.5)
                    ])),
                  )),
              CustomPaint(
                painter: BackgroundCurvesPainter(),
                size: Size.infinite,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: context.colorScheme.onSurface,
                          ),
                          onPressed: () {
                            ref
                                .read(chatBotListProvider.notifier)
                                .updateChatBotOnHomeScreen(chatBot);
                            context.pop();
                          },
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  offset: const Offset(4, 4),
                                  blurRadius: 8,
                                ),
                              ]),
                          child: Center(
                            child: Text(
                              '$title buddy',
                              style: TextStyle(
                                  color: context.colorScheme.surface,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        if (chatBot.typeOfBot == TypeOfBot.image)
                          CircleAvatar(
                            maxRadius: 21,
                            backgroundImage: FileImage(
                              File(chatBot.attachmentPath!),
                            ),
                            child: TextButton(
                              onPressed: () {
                                showDialog<AlertDialog>(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: SingleChildScrollView(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            child: Image.file(
                                              File(chatBot.attachmentPath!),
                                            ),
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Close'))
                                        ],
                                      );
                                    });
                              },
                              child: const SizedBox.shrink(),
                            ),
                          )
                        else
                          const SizedBox(
                            width: 42,
                          )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Expanded(
                        child: ChatInterfaceWidget(
                            messages: messages,
                            chatbot: chatBot,
                            color: color,
                            imagePath: imagPath))
                  ],
                ),
              )
            ],
          )),
        ));
  }
}
