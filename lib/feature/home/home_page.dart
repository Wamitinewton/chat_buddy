import 'package:athena_ai/core/config/assets_constants.dart';
import 'package:athena_ai/core/extension/context.dart';
import 'package:athena_ai/core/util/securestorage.dart';
import 'package:athena_ai/feature/home/widgets/background_curves_painter.dart';
import 'package:athena_ai/feature/home/widgets/card_button.dart';
import 'package:athena_ai/feature/home/widgets/history_item.dart';
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
                        style: IconButton.styleFrom(padding: EdgeInsets.zero),
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
                const SizedBox(
                  height: 32,
                ),
                Row(
                  children: [
                    Expanded(
                        child: CardButton(
                      title: 'Chat\nwith PDF',
                      color: context.colorScheme.primary,
                      imagePath: AssetConstants.pdfLogo,
                      isMainButton: true,
                      onPressed: () {},
                    )),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        CardButton(
                          title: 'Chat with AI',
                          color: context.colorScheme.secondary,
                          imagePath: AssetConstants.textLogo,
                          isMainButton: false,
                          onPressed: () {},
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CardButton(
                          title: 'Ask Image',
                          color: context.colorScheme.tertiary,
                          imagePath: AssetConstants.imageLogo,
                          isMainButton: false,
                          onPressed: () {},
                        )
                      ],
                    ))
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'History',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary
                                        .withOpacity(0.95)),
                          ),
                          TextButton(
                            onPressed: (){}, 
                            child: Text(
                              'see all',
                              style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.8)
                              ),
                            )
                            )
                        ],
                      ),
                    ),
                    const SizedBox(height: 8,),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index){
                        return HistoryItem(
                          label: 'I love you my generative AI',
                          imagePath: AssetConstants.textLogo,
                          color: context.colorScheme.secondary,
                        );
                      }, 
                      separatorBuilder: (_, __) =>
                      const SizedBox(height: 4,), 
                      )
                  ],
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
