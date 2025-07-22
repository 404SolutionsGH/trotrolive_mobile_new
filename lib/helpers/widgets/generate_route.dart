import 'package:flutter/material.dart';
import 'package:trotrolive_mobile_new/presentation/trips/components/trips_page_arguments.dart';
import 'package:trotrolive_mobile_new/presentation/trips/pages/trips_main_screen.dart';
import 'package:trotrolive_mobile_new/presentation/trips/pages/trips_screen.dart';
import '../../presentation/home/pages/home.dart';
import '../../presentation/home/pages/main_home.dart';
import '../../presentation/intro/onboarding screen/onboarding_screen.dart';
import '../../presentation/intro/splash screen/pages/splash_screen.dart';
import '../../presentation/intro/welcome screen/welcome_screen.dart';
import '../../test_file.dart';
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

    case '/events':
      return slideFromRight(EventsPage());

    case '/trips':
      final args = settings.arguments as TripsPageArguments;
      return slideFromRight(
        TripsPage(
          startLocation: args.startLocation,
          destination: args.destination,
        ),
      );

    case '/tripsInfo':
      return slideFromRight(TripsMainPage());

    default:
      return MaterialPageRoute(
        builder: (_) => const SplashScreen(),
      );
  }
}
