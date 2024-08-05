import 'package:athena_ai/core/extension/context.dart';
import 'package:athena_ai/core/navigation/route.dart';
import 'package:athena_ai/core/util/securestorage.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final Securestorage secureStorage = Securestorage();

  @override
  void initState() {
    super.initState();
    _navigateToNextPage();
  }

  Future<void> _navigateToNextPage() async {
    final String? apiKey = await secureStorage.getApiKey();
    if (apiKey == null || apiKey.isEmpty) {
      AppRoute.welcome.go(context);
    } else {
      AppRoute.home.go(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Newton AI Buddy',
          textAlign: TextAlign.center,
          style: context.textTheme.headlineLarge,
        ),
      ),
    );
  }
}
