import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../domain/entities/pokemon_entity.dart';

/// Pokemon Grid Card Widget
class PokemonGridCard extends StatelessWidget {
  final PokemonListItemEntity pokemon;
  final int index;
  final VoidCallback onTap;

  const PokemonGridCard({
    super.key,
    required this.pokemon,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final pokemonId = pokemon.id;
    final imageUrl = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokemonId.png';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.cardBackground,
              AppColors.cardBackground.withValues(alpha: 0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.cardBorder,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Pokemon Image
            Expanded(
              flex: 3,
              child: Hero(
                tag: 'pokemon-$pokemonId',
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.catching_pokemon,
                    size: 64,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),

            // Pokemon Info
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Pokemon ID
                    Text(
                      '#${pokemonId.toString().padLeft(3, '0')}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    // Pokemon Name
                    Text(
                      pokemon.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms, delay: (index * 50).ms).scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1.0, 1.0),
          duration: 300.ms,
          delay: (index * 50).ms,
        );
  }
}
