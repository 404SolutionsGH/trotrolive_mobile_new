import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trotrolive_mobile_new/trotro_app_blocs.dart';
import 'data/dio/dio_helper.dart';
import 'firebase_options.dart';
import 'trotro_app_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();

  Bloc.observer = const TrotroObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  debugPrint("Firebase Connected Succesfuly");

  runApp(const TrotroAppBlocs());
}
