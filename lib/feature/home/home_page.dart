import 'package:athena_ai/core/config/assets_constants.dart';
import 'package:athena_ai/core/extension/context.dart';
import 'package:athena_ai/core/util/securestorage.dart';
import 'package:athena_ai/feature/home/widgets/background_curves_painter.dart';
import 'package:athena_ai/feature/welcome/widgets/api_key_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool _isBuildingChatBot = false;
  String currentState = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Positioned(
              left: -300,
              top: -00,
              child: Container(
                height: 500,
                width: 600,
                decoration: BoxDecoration(
                    gradient: RadialGradient(colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  Theme.of(context).colorScheme.surface.withOpacity(0.5)
                ])),
              )),
          CustomPaint(
            painter: BackgroundCurvesPainter(),
            size: Size.infinite,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 60,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                          color: context.colorScheme.onSurface,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.white.withOpacity(0.25),
                                offset: const Offset(4, 4),
                                blurRadius: 8)
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Personal AI Buddy',
                            style: TextStyle(
                                color: context.colorScheme.surface,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Image.asset(
                            AssetConstants.aiStarLogo,
                            scale: 23,
                          )
                        ],
                      ),
                    ),
                    CircleAvatar(
                      maxRadius: 16,
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.2),
                      child: IconButton(
                        icon: const Icon(
                          CupertinoIcons.settings,
                          size: 18,
                        ),
                        style: IconButton.styleFrom(
                          padding: EdgeInsets.zero
                        ),
                        onPressed: () async {
                          final apiKey = await Securestorage().getApiKey();
                          final TextEditingController apiKeyController =
                              TextEditingController(text: apiKey);
                          await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20))),
                              builder: (context) {
                                return ApiKeyBottomSheet(
                                    apiKeyController: apiKeyController,
                                    isCalledFromHomePage: true);
                              });
                        },
                      ),
                    )
                  ],
                ),
               const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'How may I help\nyou today?',
                      style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 32),
                    ),
                  ),
                ),
                const SizedBox(height: 32,)
              ],
            ),
          )
        ],
      )),
    );
  }
}
