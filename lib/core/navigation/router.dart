import 'package:athena_ai/core/navigation/route.dart';
import 'package:athena_ai/feature/home/home_page.dart';
import 'package:athena_ai/feature/welcome/welcome_page.dart';
import 'package:athena_ai/splash_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes:[
    GoRoute(
      path: AppRoute.splash.path,
      builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoute.home.path,
        builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: AppRoute.welcome.path,
          builder: (context, state) => const WelcomePage()
          )
  ]
  );