import 'package:card_tikimon_collection/common/share_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShareStyles {
  static TextStyle boldStyle = GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
  );

  static TextStyle normalStyle = GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 14,
    ),
  );

  static TextStyle w300 = GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 14,
    ),
  );

  static TextStyle w500 = GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14,
    ),
  );

  ///
  static const OutlineInputBorder defaultOutlineBorder = OutlineInputBorder(
    borderSide: BorderSide(
      width: 0.5,
      color: Colors.white,
    ),
  );
  static OutlineInputBorder colorOutlineBorder = OutlineInputBorder(
    borderSide: BorderSide(
      width: 0.5,
      color: ShareColors.kPrimaryColor,
    ),
  );
}
