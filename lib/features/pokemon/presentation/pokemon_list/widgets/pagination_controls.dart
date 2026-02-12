import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';

/// Pagination Controls Widget
class PaginationControls extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;

  const PaginationControls({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        border: Border(
          top: BorderSide(
            color: AppColors.cardBorder,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // First Page Button
            _buildIconButton(
              icon: Icons.first_page,
              onPressed: currentPage > 0
                  ? () => onPageChanged(0)
                  : null,
              tooltip: 'First Page',
            ),
            const SizedBox(width: 8),

            // Previous Page Button
            _buildIconButton(
              icon: Icons.chevron_left,
              onPressed: currentPage > 0
                  ? () => onPageChanged(currentPage - 1)
                  : null,
              tooltip: 'Previous Page',
            ),
            const SizedBox(width: 16),

            // Page Indicator
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Text(
                '${currentPage + 1} / $totalPages',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Next Page Button
            _buildIconButton(
              icon: Icons.chevron_right,
              onPressed: currentPage < totalPages - 1
                  ? () => onPageChanged(currentPage + 1)
                  : null,
              tooltip: 'Next Page',
            ),
            const SizedBox(width: 8),

            // Last Page Button
            _buildIconButton(
              icon: Icons.last_page,
              onPressed: currentPage < totalPages - 1
                  ? () => onPageChanged(totalPages - 1)
                  : null,
              tooltip: 'Last Page',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required String tooltip,
  }) {
    final isEnabled = onPressed != null;

    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isEnabled
                  ? AppColors.primary.withValues(alpha: 0.1)
                  : Colors.grey.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isEnabled
                    ? AppColors.primary.withValues(alpha: 0.3)
                    : Colors.grey.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Icon(
              icon,
              size: 24,
              color: isEnabled
                  ? AppColors.primary
                  : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
