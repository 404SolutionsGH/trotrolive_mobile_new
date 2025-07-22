// lib/theme/bloc/theme_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'theme_event.dart';
import 'theme_state.dart';
import '../theme_data.dart'; // we'll create this next

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  bool isDark = false;

  ThemeBloc() : super(LightThemeState(lightTheme)) {
    on<ToggleThemeEvent>((event, emit) {
      isDark = !isDark;
      emit(isDark ? DarkThemeState(darkTheme) : LightThemeState(lightTheme));
    });
  }
}
