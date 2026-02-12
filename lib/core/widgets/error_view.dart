import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../l10n/app_strings.dart';

/// Reusable error view widget
class ErrorView extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;
  final IconData icon;
  final double iconSize;

  const ErrorView({
    super.key,
    this.message,
    this.onRetry,
    this.icon = Icons.error_outline,
    this.iconSize = 64,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: AppColors.error,
          ),
          const SizedBox(height: 16),
          Text(
            message ?? AppStrings.error,
            style: GoogleFonts.poppins(
              fontSize: 18,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(AppStrings.retry),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textPrimary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Full screen error view
class FullScreenError extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;

  const FullScreenError({
    super.key,
    this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: ErrorView(
        message: message,
        onRetry: onRetry,
      ),
    );
  }
}
