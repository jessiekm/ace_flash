import 'package:ace_flash/theme/pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Pallete.backgroundColor,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Pallete.blueColor,
    ), // Set the default text color to black
    textTheme: ThemeData.light().textTheme.copyWith(
          bodyLarge: const TextStyle(
            color: Colors.black, // Set the default text color to black
          ),
          bodyMedium: const TextStyle(
            color: Colors.black, // Set the default text color to black
          ),
          // You can set other text styles as needed
        ),
  );
}
