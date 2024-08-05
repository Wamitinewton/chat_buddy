import 'package:athena_ai/core/app/style.dart';
import 'package:athena_ai/core/navigation/router.dart';
import 'package:flutter/material.dart';

class NewtonAIBuddy extends StatelessWidget {
  const NewtonAIBuddy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Newton AI Buddy',
      theme: darkTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
