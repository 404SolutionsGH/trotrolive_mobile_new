import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trotrolive_mobile_new/trotro_app_blocs.dart';
import 'trotro_app_observer.dart';

void main() {
  Bloc.observer = const TrotroObserver();
  runApp(const TrotroAppBlocs());
}
