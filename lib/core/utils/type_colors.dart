import 'package:flutter/material.dart';

class TypeColors {
  TypeColors._();

  static Color getTypeColor(String type) {
    final typeColors = {
      'normal': const Color(0xFFA8A878),
      'fire': const Color(0xFFFF6B6B),
      'water': const Color(0xFF4ECDC4),
      'electric': const Color(0xFFFFD93D),
      'grass': const Color(0xFF6BCF7F),
      'ice': const Color(0xFF98D8C8),
      'fighting': const Color(0xFFFF8FAB),
      'poison': const Color(0xFFB388EB),
      'ground': const Color(0xFFE0AC69),
      'flying': const Color(0xFF8FA7DF),
      'psychic': const Color(0xFFFF8FAB),
      'bug': const Color(0xFFA8B820),
      'rock': const Color(0xFFB8A038),
      'ghost': const Color(0xFF705898),
      'dragon': const Color(0xFF7038F8),
      'dark': const Color(0xFF705848),
      'steel': const Color(0xFFB8B8D0),
      'fairy': const Color(0xFFFFB6B9),
    };
    return typeColors[type] ?? const Color(0xFFA8A878);
  }
}
