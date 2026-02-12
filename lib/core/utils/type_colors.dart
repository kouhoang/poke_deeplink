import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class TypeColors {
  TypeColors._();

  static Color getTypeColor(String type) {
    final typeColors = {
      'normal': AppColors.typeNormal,
      'fire': AppColors.typeFire,
      'water': AppColors.typeWater,
      'electric': AppColors.typeElectric,
      'grass': AppColors.typeGrass,
      'ice': AppColors.typeIce,
      'fighting': AppColors.typeFighting,
      'poison': AppColors.typePoison,
      'ground': AppColors.typeGround,
      'flying': AppColors.typeFlying,
      'psychic': AppColors.typePsychic,
      'bug': AppColors.typeBug,
      'rock': AppColors.typeRock,
      'ghost': AppColors.typeGhost,
      'dragon': AppColors.typeDragon,
      'dark': AppColors.typeDark,
      'steel': AppColors.typeSteel,
      'fairy': AppColors.typeFairy,
    };
    return typeColors[type.toLowerCase()] ?? AppColors.typeNormal;
  }
}
