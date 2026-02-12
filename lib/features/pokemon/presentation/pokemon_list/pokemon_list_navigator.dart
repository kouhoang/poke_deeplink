import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

/// Navigator for Pokemon List screen
class PokemonListNavigator {
  const PokemonListNavigator();

  /// Navigate to Pokemon detail screen
  void navigateToDetail(BuildContext context, int pokemonId) {
    context.go('/pokemon/$pokemonId');
  }

  /// Navigate to Pokemon detail screen (push)
  void pushToDetail(BuildContext context, int pokemonId) {
    context.push('/pokemon/$pokemonId');
  }

  /// Go back
  void goBack(BuildContext context) {
    context.pop();
  }
}
