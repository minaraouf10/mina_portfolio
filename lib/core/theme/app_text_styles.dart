import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle heroName(Color color) => GoogleFonts.sora(
        fontSize: 56,
        fontWeight: FontWeight.w800,
        color: color,
        height: 1.1,
      );

  static TextStyle heroTitle(Color color) => GoogleFonts.sora(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle sectionHeader(Color color) => GoogleFonts.sora(
        fontSize: 36,
        fontWeight: FontWeight.w800,
        color: color,
        letterSpacing: -0.5,
      );

  static TextStyle cardTitle(Color color) => GoogleFonts.sora(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle body(Color color) => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.6,
      );

  static TextStyle label(Color color) => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle caption(Color color) => GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: color,
      );
}
