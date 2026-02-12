import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Reusable glassmorphism card widget
class GlassCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double blur;
  final double opacity;
  final Border? border;
  final List<BoxShadow>? boxShadow;

  const GlassCard({
    super.key,
    required this.child,
    this.color,
    this.borderRadius = 20,
    this.padding = const EdgeInsets.all(20),
    this.blur = 10,
    this.opacity = 0.2,
    this.border,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.withOpacity(color ?? AppColors.surface, opacity),
            AppColors.withOpacity(color ?? AppColors.surface, opacity * 0.5),
          ],
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        border: border ??
            Border.all(
              color: AppColors.withOpacity(
                color ?? AppColors.textPrimary,
                0.2,
              ),
              width: 1.5,
            ),
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}

/// Gradient card with custom colors
class GradientCard extends StatelessWidget {
  final Widget child;
  final List<Color> gradientColors;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Border? border;
  final List<BoxShadow>? boxShadow;

  const GradientCard({
    super.key,
    required this.child,
    required this.gradientColors,
    this.borderRadius = 20,
    this.padding = const EdgeInsets.all(20),
    this.border,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        border: border,
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}
