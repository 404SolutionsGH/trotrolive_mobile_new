import 'package:flutter/material.dart';
import 'package:trotrolive_mobile_new/presentation/intro/splash%20screen/pages/splash_screen.dart';
import 'helpers/widgets/generate_route.dart';
import 'utils/constants/color constants/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trotrolive Mobile',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
      },
      onGenerateRoute: generateRoute,
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
      ),
    );
  }
}
