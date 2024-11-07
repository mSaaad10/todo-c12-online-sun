import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app_c12_online_sun/core/utils/colors_manager.dart';

class AppLightStyles {
  static TextStyle? appBarTextStyle = GoogleFonts.poppins(
      fontSize: 22, fontWeight: FontWeight.w700, color: ColorsManager.white);
  static TextStyle? bottomSheetTitle = GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: ColorsManager.blackAccent);
  static TextStyle? hintStyle = GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.w400, color: ColorsManager.grey);
  static TextStyle? dateLabel = GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: ColorsManager.blackAccent);
  static TextStyle? dateStyle = GoogleFonts.inter(
      fontSize: 16, fontWeight: FontWeight.w400, color: ColorsManager.grey);
  static TextStyle? tasksTitle = GoogleFonts.poppins(
      fontSize: 18, fontWeight: FontWeight.w700, color: ColorsManager.blue);
  static TextStyle? taskDesc = GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: ColorsManager.blackAccent);
  static TextStyle? taskDate = GoogleFonts.roboto(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: ColorsManager.blackAccent);
  static TextStyle? calenderSelectedItem = GoogleFonts.roboto(
      fontSize: 15, fontWeight: FontWeight.w400, color: ColorsManager.blue);
  static TextStyle? calenderUnSelectedItem = GoogleFonts.roboto(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: ColorsManager.blackAccent);
  static TextStyle? title = GoogleFonts.poppins(
      fontSize: 16, fontWeight: FontWeight.w500, color: ColorsManager.white);
  static TextStyle? hint = GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      color: ColorsManager.black.withOpacity(0.7));
  static TextStyle? buttonTitle = GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.w600, color: Colors.blue.shade900);
}
