import 'package:flutter/material.dart';
import 'package:poke_deeplink/core/constants/app_colors.dart';
import 'package:poke_deeplink/core/l10n/app_strings.dart';
import 'package:poke_deeplink/core/widgets/widgets.dart';

/// Example screen demonstrating all reusable widgets
class WidgetShowcaseScreen extends StatelessWidget {
  const WidgetShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Widget Showcase'),
        backgroundColor: AppColors.surface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: Loading Indicators
            _buildSection(
              'Loading Indicators',
              [
                const LoadingIndicator(
                  message: 'Loading data...',
                  size: 40,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Section: Error Views
            _buildSection(
              'Error Views',
              [
                SizedBox(
                  height: 200,
                  child: ErrorView(
                    message: AppStrings.errorLoadingPokemon,
                    onRetry: () {},
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Section: Gradient Buttons
            _buildSection(
              'Gradient Buttons',
              [
                GradientButton(
                  text: AppStrings.retry,
                  onPressed: () {},
                  icon: Icons.refresh,
                ),
                const SizedBox(height: 12),
                GradientButton(
                  text: 'Custom Colors',
                  onPressed: () {},
                  gradientColors: [AppColors.typeFire, AppColors.typeWater],
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Section: Type Badges
            _buildSection(
              'Type Badges',
              [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    const TypeBadge(type: 'fire', showIcon: true),
                    const TypeBadge(type: 'water', showIcon: true),
                    const TypeBadge(type: 'grass', showIcon: true),
                    const TypeBadge(type: 'electric', showIcon: true),
                  ],
                ),
                const SizedBox(height: 12),
                const Text('Small Badges:', style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    const SmallTypeBadge(type: 'fire'),
                    const SmallTypeBadge(type: 'water'),
                    const SmallTypeBadge(type: 'grass'),
                    const SmallTypeBadge(type: 'electric'),
                    const SmallTypeBadge(type: 'dragon'),
                    const SmallTypeBadge(type: 'fairy'),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Section: Stat Bars
            _buildSection(
              'Stat Bars',
              [
                StatBar(
                  label: AppStrings.hp,
                  value: 100,
                  color: AppColors.statHP,
                  effort: 2,
                ),
                const SizedBox(height: 16),
                StatBar(
                  label: AppStrings.attack,
                  value: 80,
                  color: AppColors.statAttack,
                  animationDelay: 100,
                ),
                const SizedBox(height: 16),
                StatBar(
                  label: AppStrings.defense,
                  value: 120,
                  color: AppColors.statDefense,
                  animationDelay: 200,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Section: Stat Chips
            _buildSection(
              'Stat Chips',
              [
                Row(
                  children: [
                    StatChip(
                      label: AppStrings.hp,
                      value: '100',
                      color: AppColors.statHP,
                    ),
                    StatChip(
                      label: AppStrings.attack,
                      value: '80',
                      color: AppColors.statAttack,
                    ),
                    StatChip(
                      label: AppStrings.defense,
                      value: '120',
                      color: AppColors.statDefense,
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Section: Glass Cards
            _buildSection(
              'Glass Cards',
              [
                GlassCard(
                  child: Column(
                    children: [
                      Text(
                        'Glass Card',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'This is a glassmorphism card',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                GradientCard(
                  gradientColors: [
                    AppColors.withOpacity(AppColors.typeFire, 0.3),
                    AppColors.withOpacity(AppColors.typeWater, 0.3),
                  ],
                  child: Column(
                    children: [
                      Text(
                        'Gradient Card',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'This is a gradient card',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Section: Color Palette
            _buildSection(
              'Color Palette',
              [
                _buildColorRow('Primary', AppColors.primary),
                _buildColorRow('Primary Light', AppColors.primaryLight),
                _buildColorRow('Surface', AppColors.surface),
                _buildColorRow('Error', AppColors.error),
                _buildColorRow('Success', AppColors.success),
                _buildColorRow('Warning', AppColors.warning),
              ],
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildColorRow(String name, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white24),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            name,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
