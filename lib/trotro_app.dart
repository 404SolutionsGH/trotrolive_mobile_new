import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import 'helpers/widgets/generate_route.dart';
import 'presentation/intro/splash screen/pages/splash_screen.dart';
import 'presentation/location/bloc/location_bloc.dart';
import 'presentation/stations/bloc/stations_bloc.dart';
import 'utils/constants/color constants/colors.dart';

class TrotroApp extends StatelessWidget {
  const TrotroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationBloc, LocationState>(
        listener: (BuildContext context, state) {
      if (state is LocationSucces) {
        context.read<LocationBloc>()..add(LoadLocationEvent());
      }
    }, builder: (BuildContext context, state) {
      return ToastificationWrapper(
        child: MaterialApp(
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
        ),
      );
    });
  }
}
