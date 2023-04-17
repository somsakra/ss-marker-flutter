import 'package:flutter/material.dart';

class Theme {
  const Theme();

  static const Color gradientStart = Color(0xFF2C3333); //0xFFbdc3c7
  static const Color gradientEnd = Color(0xFF2C3333); //0xFF2c3e50

  static const Color primaryColorDark = Color(0xFF2C3333);
  static const Color primaryColor = Color(0xFF2E4F4F);
  static const Color primaryColorLight = Color(0xFF0E8388);
  static const Color primaryColorWhite = Color(0xFFCBE4DE);

  static const gradient = LinearGradient(
      colors: [gradientStart, gradientEnd],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.0, 1.0]);
}
