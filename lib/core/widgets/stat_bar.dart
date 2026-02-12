import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/app_colors.dart';

/// Reusable stat bar widget for displaying Pokemon stats
class StatBar extends StatelessWidget {
  final String label;
  final int value;
  final int maxValue;
  final Color color;
  final int? effort;
  final int animationDelay;
  final bool showValue;

  const StatBar({
    super.key,
    required this.label,
    required this.value,
    this.maxValue = 255,
    required this.color,
    this.effort,
    this.animationDelay = 0,
    this.showValue = true,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = value / maxValue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 80,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.withOpacity(color, 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    label,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
                if (effort != null && effort! > 0)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.withOpacity(AppColors.warning, 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '+$effort EV',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.warning,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            if (showValue)
              Text(
                value.toString(),
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 12,
              decoration: BoxDecoration(
                color: AppColors.withOpacity(AppColors.textPrimary, 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            FractionallySizedBox(
              widthFactor: percentage,
              child: Container(
                height: 12,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, AppColors.withOpacity(color, 0.7)],
                  ),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.withOpacity(color, 0.5),
                      blurRadius: 8,
                    ),
                  ],
                ),
              )
                  .animate()
                  .scaleX(
                    duration: const Duration(milliseconds: 800),
                    delay: Duration(milliseconds: animationDelay),
                    begin: 0,
                    end: 1,
                    curve: Curves.easeOutCubic,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Compact stat chip for grid displays
class StatChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const StatChip({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: AppColors.withOpacity(color, 0.2),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 8,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
