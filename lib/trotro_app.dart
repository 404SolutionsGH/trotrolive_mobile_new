import 'package:flutter/material.dart';
import 'helpers/widgets/generate_route.dart';
import 'presentation/intro/splash screen/pages/splash_screen.dart';
import 'utils/constants/color constants/colors.dart';

class TrotroApp extends StatelessWidget {
  const TrotroApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<ThemeBloc, ThemeState>(
    //   builder: (BuildContext context, state) {
    //     final themeData =
    //         state is DarkThemeState ? state.themeData : lightTheme;

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
