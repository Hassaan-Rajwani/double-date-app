import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle interFont({
  FontWeight fontWeight = FontWeight.normal,
  double fontSize = 14.0,
  Color color = Colors.white,
  TextDecoration decoration = TextDecoration.none,
  Color decorationColor = Colors.white,
}) {
  return GoogleFonts.inter(
    textStyle: TextStyle(
      fontWeight: fontWeight,
      color: color,
      fontSize: fontSize,
      decoration: decoration,
      decorationColor: decorationColor,
    ),
  );
}
