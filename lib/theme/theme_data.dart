import 'package:flutter/material.dart';
import '../utils/constants/color constants/colors.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: secondaryBg,
  primaryColor: primaryColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: whiteColor,
    foregroundColor: blackColor,
  ),
  fontFamily: 'Poppins',
  useMaterial3: true,
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: blackColor),
  ),
  colorScheme: const ColorScheme.light(
    primary: primaryColor,
    secondary: secondaryColor,
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: backgroundColor,
  primaryColor: Colors.grey,
  fontFamily: 'Poppins',
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    backgroundColor: blackColor,
    foregroundColor: whiteColor,
    iconTheme: IconThemeData(color: whiteColor),
    titleTextStyle:
        TextStyle(color: whiteColor, fontSize: 18, fontWeight: FontWeight.w600),
  ),
  iconTheme: const IconThemeData(color: whiteColor),
  listTileTheme: const ListTileThemeData(
    iconColor: whiteColor,
    textColor: whiteColor,
  ),
  cardColor: blackColorShade,
  dividerColor: Colors.grey[800],
  hintColor: Colors.grey[400],
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: whiteColor),
    bodyMedium: TextStyle(color: whiteColor),
    titleMedium: TextStyle(color: whiteColor),
    labelLarge: TextStyle(color: secondaryColor3),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[900],
    hintStyle: TextStyle(color: Colors.grey[500]),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: outlineGrey.withOpacity(0.3)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: outlineGrey.withOpacity(0.3)),
    ),
  ),
  dialogBackgroundColor: Colors.grey[900],
  colorScheme: const ColorScheme.dark(
    primary: primaryColor,
    secondary: secondaryColor,
    background: blackColor,
    surface: blackColorShade,
  ),
  bottomAppBarTheme: BottomAppBarTheme(color: blackColor),
);
