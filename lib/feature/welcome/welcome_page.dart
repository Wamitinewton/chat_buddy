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
                )
          ],
        ),
      )),
    );
  }
}
