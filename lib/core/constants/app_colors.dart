import 'package:flutter/material.dart';

/// Centralized color constants for the entire app
class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF4ECDC4);
  static const Color primaryLight = Color(0xFF45B7D1);
  static const Color primaryDark = Color(0xFF3BA89F);

  // Background Colors
  static const Color background = Color(0xFF0F172A);
  static const Color surface = Color(0xFF1E293B);
  static const Color surfaceLight = Color(0xFF334155);
  static const Color cardBackground = Color(0xFF1E293B);
  static const Color cardBorder = Color(0xFF334155);

  // Status Colors
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF6BCF7F);
  static const Color warning = Color(0xFFFFD93D);
  static const Color info = Color(0xFF4ECDC4);

  // Text Colors
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.white70;
  static const Color textTertiary = Colors.white60;
  static const Color textDisabled = Colors.white38;

  // Pokemon Type Colors
  static const Color typeNormal = Color(0xFFA8A878);
  static const Color typeFire = Color(0xFFFF6B6B);
  static const Color typeWater = Color(0xFF4ECDC4);
  static const Color typeElectric = Color(0xFFFFD93D);
  static const Color typeGrass = Color(0xFF6BCF7F);
  static const Color typeIce = Color(0xFF98D8C8);
  static const Color typeFighting = Color(0xFFFF8FAB);
  static const Color typePoison = Color(0xFFB388EB);
  static const Color typeGround = Color(0xFFE0AC69);
  static const Color typeFlying = Color(0xFF8FA7DF);
  static const Color typePsychic = Color(0xFFFF8FAB);
  static const Color typeBug = Color(0xFFA8B820);
  static const Color typeRock = Color(0xFFB8A038);
  static const Color typeGhost = Color(0xFF705898);
  static const Color typeDragon = Color(0xFF7038F8);
  static const Color typeDark = Color(0xFF705848);
  static const Color typeSteel = Color(0xFFB8B8D0);
  static const Color typeFairy = Color(0xFFFFB6B9);

  // Stat Colors
  static const Color statHP = Color(0xFFFF6B6B);
  static const Color statAttack = Color(0xFFFFD93D);
  static const Color statDefense = Color(0xFF4ECDC4);
  static const Color statSpAttack = Color(0xFFB388EB);
  static const Color statSpDefense = Color(0xFF6BCF7F);
  static const Color statSpeed = Color(0xFFFF8FAB);

  // Shiny/Special
  static const Color shiny = Colors.amber;
  static const Color hidden = Color(0xFFB388EB);

  // Opacity helpers
  static Color withOpacity(Color color, double opacity) {
    return color.withValues(alpha: opacity);
  }
}
