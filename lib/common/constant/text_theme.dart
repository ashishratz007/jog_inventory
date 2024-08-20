import 'package:flutter/material.dart';

var appTextTheme = TextTheme(

  bodyLarge: TextStyle(
      fontSize: 24, fontWeight: FontWeight.bold, fontFamily: "Montserrat", color: Colors.black),
  bodyMedium: TextStyle(
      fontSize: 16, fontWeight: FontWeight.w500, fontFamily: "Montserrat", color: Colors.black),
  bodySmall: TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, fontFamily: "Montserrat", color: Colors.black),
  displaySmall: TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, fontFamily: "Montserrat", color: Colors.black),

  headlineLarge: TextStyle(
      fontSize: 18, fontWeight: FontWeight.w500, fontFamily: "Montserrat", color: Colors.black),

  headlineMedium: TextStyle(
      fontSize: 16, fontWeight: FontWeight.w500, fontFamily: "Montserrat", color: Colors.black),

  headlineSmall: TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, fontFamily: "Montserrat", color: Colors.black),

  /// app title
  titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 18,
      fontFamily: "Montserrat"),
  titleMedium: TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.black,
      fontSize: 16,
      fontFamily: "Montserrat"),
  titleSmall: TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.black,
      fontSize: 14,
      fontFamily: "Montserrat"),

  ///
  labelLarge: TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w700,
      fontFamily: "Montserrat"),
  labelMedium: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: "Montserrat"),
  labelSmall: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: "Montserrat"),

  /// for small size of title
  displayLarge: TextStyle(
      color: Colors.black54,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily: "Montserrat"),
  displayMedium: TextStyle(
      color: Colors.grey,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: "Montserrat"),
);


class _TextThemeCustom {
  TextStyle appTitleLarge = TextStyle(
      color: Colors.black54,
      fontSize: 18,
      fontWeight: FontWeight.w500,
      fontFamily: "Montserrat");
  TextStyle appTitleMedium = TextStyle(
      color: Colors.black87,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: "Montserrat");

  final TextStyle appTitleSmall = TextStyle(
      color: Colors.black87,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: "Montserrat");
  final TextStyle appTitleExtraSmall = TextStyle(
      color: Colors.black87,
      fontSize: 12,
      fontWeight: FontWeight.w300,
      fontFamily: "Montserrat");

  final TextStyle titleExtraSmall = TextStyle(
      color: Colors.black,
      fontSize: 12,
      fontWeight: FontWeight.w800,
      fontFamily: "Montserrat");

  final TextStyle appTitleSmallDark = TextStyle(
      color: Colors.black87,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: "Montserrat");
  final TextStyle appTitleMediumBold = TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily: "Montserrat");
  final TextStyle hintTextStyle = TextStyle(
      color: Colors.black54,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: "Montserrat");

  final TextStyle hintTextSmall = TextStyle(
      color: Colors.grey.shade400,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      fontFamily: "Montserrat");

  final titleSmall = TextStyle(
      fontWeight: FontWeight.w700,
      color: Colors.black,
      fontSize: 14,
      fontFamily: "Montserrat");

  //body
  final bodyLarge = TextStyle(
      color: Colors.grey.shade500,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: "Montserrat");
  final bodyMedium = TextStyle(
      color: Colors.grey.shade500,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: "Montserrat");
  final bodySmall = TextStyle(
      color: Colors.grey.shade500,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      fontFamily: "Montserrat");

  final labelLarge = TextStyle(
      color: Colors.grey.shade500,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      fontFamily: "Montserrat");
  final labelMedium = TextStyle(
      color: Colors.grey.shade500,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: "Montserrat");
  final labelSmall = TextStyle(
      color: Colors.grey.shade500,
      fontSize: 10,
      fontWeight: FontWeight.w300,
      fontFamily: "Montserrat");
}

var textTheme = _TextThemeCustom();