import 'package:flutter/material.dart';

//color: 60b5ff

class AppColors {
  //Light Theme Colors
  static Color background = _color('ffffff'); // Background
  static Color primary = _color('eff8ff'); // AppBar & Highlights
  static Color buttonBackground = _color('eff8ff'); // Button Background
  static Color inActiveTab = _color('3a6d99');
  static Color accent = _color('d1d5db'); // Icons & Borders
  static Color textPrimary = _color('264866'); // Main Text
  static Color iconPrimary = _color('264866'); // Icon Color
  static Color buttonText = _color('264866'); // Button Text
  static Color activeTab = _color('264866'); // Active Tab Color

  //Dark Theme Colors
  static Color darkBackground = _color('000000'); // Background
  static Color darkPrimary = _color('04070a'); // AppBar & Highlights
  static Color darkButtonBackground = _color('04070a'); // Button Background
  static Color darkInActiveTab = _color('516d85');
  static Color darkAccent = _color('132433'); // Icons & Borders
  static Color darkTextPrimary = _color('d4dae0'); // Main Text
  static Color darkIconPrimary = _color('d4dae0'); // Icon Color
  static Color darkButtonText = _color('d4dae0'); // Button Text
  static Color darkActiveTab = _color('d4dae0'); // Active Tab Color

  static Color _color(String hex) {
    return Color(int.parse('0xff$hex')); // Helper function to add 0xff prefix
  }
}
