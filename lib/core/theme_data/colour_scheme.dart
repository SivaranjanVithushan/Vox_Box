// Theme Colors Used
import 'package:flutter/material.dart';

Color primarybackground = const Color(0xff34A853);
Color secondarybackground = Colors.white;
Color primaryText = const Color(0xff34A853);
Color secondaryText = const Color(0xff000000);

// Custom Colors
Color darkGreen = const Color.fromARGB(255, 7, 148, 85);
Color lightGreen = const Color.fromARGB(255, 219, 250, 230);
Color inputBorderColor = const Color.fromARGB(255, 208, 213, 221);
Color errorBorderColor = const Color.fromARGB(255, 253, 162, 155);
Color inputTextColor = const Color.fromARGB(255, 16, 24, 40);
Color suffixIconColor = const Color.fromARGB(255, 152, 162, 179);
Color errorColor2 = const Color.fromARGB(255, 217, 45, 32);

// Light theme data
final ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: primarybackground,
  onPrimary: Colors.white,
  secondary: primarybackground,
  onSecondary: primaryText,
  error: Colors.red,
  onError: Colors.white,
  surface: secondarybackground,
  onSurface: primaryText,
  background: secondarybackground,
  onBackground: primaryText,
);

// Dark theme data
final ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Colors.blue,
  onPrimary: Colors.white,
  secondary: Colors.blue.shade800,
  onSecondary: Colors.white,
  error: Colors.red,
  onError: Colors.white,
  surface: Colors.purple.shade100,
  onSurface: Colors.white,
  background: Colors.black,
  onBackground: Colors.white,
);
