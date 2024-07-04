import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeApp {
  static const Color primaryColor = Color.fromRGBO(6, 17, 111, 1);
  static const Color secondColor = Color.fromRGBO(241, 243, 246, 1);
  static const Color thirdColor = Color.fromRGBO(0, 0, 0, 0.54);

  // Common
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color red = Colors.red;
  static const Color blue = Colors.blue;
  static const Color grey = Colors.grey;
  
  static final TextTheme textTheme = GoogleFonts.openSansTextTheme().copyWith(
    titleLarge: GoogleFonts.openSans(fontSize: 24.0, fontWeight: FontWeight.w400),
    
    bodyLarge: GoogleFonts.openSans(fontSize: 16.0, fontWeight: FontWeight.w400),
    bodyMedium: GoogleFonts.openSans(fontSize: 14.0, fontWeight: FontWeight.w400),
    bodySmall: GoogleFonts.openSans(fontSize: 12.0, fontWeight: FontWeight.w400),
  );

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: primaryColor,
    textTheme: textTheme,
    scaffoldBackgroundColor: white,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: primaryColor
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: white,
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
      contentTextStyle: TextStyle(color: Colors.black, fontSize: 16),
    ),
  );
}
