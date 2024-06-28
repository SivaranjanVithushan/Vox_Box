import 'package:flutter/material.dart';
import 'package:vox_box/core/theme_data/colour_scheme.dart';
import 'package:google_fonts/google_fonts.dart';

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

    //Figma - (no Name) , 15px , w300
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
      fontSize: 17,
      fontWeight: FontWeight.w700,
      color: secondarybackground,
    ),
    bodyMedium: GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xff888888),
    ),
    bodySmall: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    )

    // //Figma - Subtitle
    // titleMedium: TextStyle(
    //   fontSize: 15,
    //   fontWeight: FontWeight.w400,
    //   color: titleColor,
    // ),

    // //HEADLINE
    // //headline large

    // //LABEL

    // //Figma - Display lg/Medium
    // labelLarge: TextStyle(
    //   fontSize: 48,
    //   fontWeight: FontWeight.w500,
    //   color: secondaryText,
    // ),

    // //Figma - Text md/Regular
    // labelSmall: TextStyle(
    //   fontSize: 16,
    //   fontWeight: FontWeight.w400,
    //   color: secondaryText,
    // ),

    // //DISPLAY
    // //Figma - Text md/Medium
    // displayMedium: TextStyle(
    //   fontSize: 16,
    //   fontWeight: FontWeight.w500,
    //   color: titleColor,
    // ),

    // //Figma - (no Name)
    // displaySmall: TextStyle(
    //   fontSize: 15,
    //   fontWeight: FontWeight.w500,
    //   color: secondaryText,
    // ),

    //Typography - No names in figma provided
    );
