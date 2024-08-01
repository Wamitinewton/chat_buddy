import 'package:athena_ai/core/config/assets_constants.dart';
import 'package:athena_ai/core/extension/context.dart';
import 'package:athena_ai/feature/home/widgets/background_curves_painter.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8),
        child: Stack(
          children: [
            Positioned(
                left: -300,
                right: -00,
                child: Container(
                  height: 500,
                  width: 600,
                  decoration: BoxDecoration(
                      gradient: RadialGradient(colors: [
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                    Theme.of(context).colorScheme.surface.withOpacity(0.5)
                  ])),
                )),
            CustomPaint(
              painter: BackgroundCurvesPainter(),
              size: Size.infinite,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
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
                            'Newton AI Buddy',
                            style: TextStyle(
                                color: context.colorScheme.surface,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Image.asset(
                            "assets/images/ai_star_logo.png",
                            scale: 23,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
