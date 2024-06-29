import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vox_box/core/theme_data/colour_scheme.dart';

var textTheme = TextTheme(
  headlineLarge: GoogleFonts.lobster(
    fontSize: 48,
    fontWeight: FontWeight.w500,
    color: secondarybackground,
  ),
  titleLarge: GoogleFonts.roboto(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: primaryText,
  ),
  labelLarge: GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: const Color(0xff888888),
  ),
  labelMedium: GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: secondaryText,
  ),
  bodyLarge: GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: secondarybackground,
  ),
  bodyMedium: GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: const Color(0xff888888),
  ),
  bodySmall: const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ),
);
