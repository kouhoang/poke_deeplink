import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../utils/type_colors.dart';
import '../l10n/app_strings.dart';

/// Reusable Pokemon type badge widget
class TypeBadge extends StatelessWidget {
  final String type;
  final double fontSize;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final bool showIcon;
  final double? iconSize;

  const TypeBadge({
    super.key,
    required this.type,
    this.fontSize = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    this.borderRadius = 20,
    this.showIcon = false,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final color = TypeColors.getTypeColor(type);
    final typeName = AppStrings.getTypeName(type);

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, AppColors.withOpacity(color, 0.7)],
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.withOpacity(color, 0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            Icon(
              _getTypeIcon(type),
              color: AppColors.textPrimary,
              size: iconSize ?? fontSize + 4,
            ),
            const SizedBox(width: 6),
          ],
          Text(
            typeName,
            style: GoogleFonts.poppins(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getTypeIcon(String type) {
    final iconMap = {
      'fire': Icons.local_fire_department,
      'water': Icons.water_drop,
      'grass': Icons.eco,
      'electric': Icons.flash_on,
      'ice': Icons.ac_unit,
      'fighting': Icons.sports_martial_arts,
      'poison': Icons.science,
      'ground': Icons.terrain,
      'flying': Icons.air,
      'psychic': Icons.psychology,
      'bug': Icons.bug_report,
      'rock': Icons.landscape,
      'ghost': Icons.visibility_off,
      'dragon': Icons.pets,
      'dark': Icons.dark_mode,
      'steel': Icons.shield,
      'fairy': Icons.auto_awesome,
    };
    return iconMap[type.toLowerCase()] ?? Icons.catching_pokemon;
  }
}

/// Small type badge for compact displays
class SmallTypeBadge extends StatelessWidget {
  final String type;

  const SmallTypeBadge({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final color = TypeColors.getTypeColor(type);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.withOpacity(color, 0.3),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: AppColors.withOpacity(color, 0.6),
          width: 1,
        ),
      ),
      child: Text(
        AppStrings.getTypeName(type),
        style: GoogleFonts.poppins(
          fontSize: 8,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
