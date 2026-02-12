import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

/// Reusable gradient button widget
class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final List<Color>? gradientColors;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double fontSize;
  final FontWeight fontWeight;

  const GradientButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.gradientColors,
    this.borderRadius = 30,
    this.padding = const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    final colors = gradientColors ?? [AppColors.primary, AppColors.primaryLight];

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: onPressed != null
                  ? colors
                  : [Colors.grey.shade700, Colors.grey.shade800],
            ),
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: onPressed != null
                ? [
                    BoxShadow(
                      color: AppColors.withOpacity(colors[0], 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : null,
          ),
          child: Container(
            padding: padding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon, color: AppColors.textPrimary),
                  const SizedBox(width: 8),
                ],
                Text(
                  text,
                  style: GoogleFonts.poppins(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
