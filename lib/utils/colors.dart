import 'package:flutter/material.dart';

class AppColors {
  // Primary Indian Colors
  static const Color saffron = Color(0xFFFF9933);
  static const Color deepGreen = Color(0xFF138808);
  static const Color maroon = Color(0xFF800020);
  static const Color cream = Color(0xFFF5F5DC);
  static const Color gold = Color(0xFFFFD700);
  
  // Secondary Colors
  static const Color darkSaffron = Color(0xFFE6841A);
  static const Color lightSaffron = Color(0xFFFFB366);
  static const Color royalBlue = Color(0xFF000080);
  static const Color terracotta = Color(0xFFE2725B);
  
  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color darkGrey = Color(0xFF424242);
  
  // Gradient Colors
  static const LinearGradient saffronGradient = LinearGradient(
    colors: [saffron, darkSaffron],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient greenGradient = LinearGradient(
    colors: [deepGreen, Color(0xFF0F6B04)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient maroonGradient = LinearGradient(
    colors: [maroon, Color(0xFF5D0015)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}