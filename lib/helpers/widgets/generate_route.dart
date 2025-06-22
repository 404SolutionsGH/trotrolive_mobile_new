import 'package:flutter/material.dart';
import '../../presentation/home/pages/home.dart';
import '../../presentation/home/pages/main_home.dart';
import '../../presentation/intro/onboarding screen/onboarding_screen.dart';
import '../../presentation/intro/splash screen/pages/splash_screen.dart';
import '../../presentation/intro/welcome screen/welcome_screen.dart';
import 'route_transition.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/welcome':
      return slideFromRight(const WelcomeScreen());

    case '/onboarding':
      return slideFromRight(const OnboardingScreen());
    case '/home':
      return slideFromRight(MyHomePage());

    case '/mainhome':
      return slideFromRight(MainHomePage());

    default:
      return MaterialPageRoute(
        builder: (_) => const SplashScreen(),
      );
  }
}
