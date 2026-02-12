import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../l10n/app_strings.dart';

/// Reusable loading indicator widget
class LoadingIndicator extends StatelessWidget {
  final String? message;
  final double size;
  final double strokeWidth;
  final Color? color;

  const LoadingIndicator({
    super.key,
    this.message,
    this.size = 60,
    this.strokeWidth = 5,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              strokeWidth: strokeWidth,
              valueColor: AlwaysStoppedAnimation<Color>(
                color ?? AppColors.primary,
              ),
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 24),
            Text(
              message!,
              style: GoogleFonts.poppins(
                color: AppColors.textSecondary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Full screen loading indicator
class FullScreenLoading extends StatelessWidget {
  final String? message;

  const FullScreenLoading({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: LoadingIndicator(
        message: message ?? AppStrings.loading,
      ),
    );
  }
}
