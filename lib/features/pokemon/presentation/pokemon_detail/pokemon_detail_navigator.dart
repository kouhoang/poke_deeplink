import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Navigator for Pokemon Detail screen
class PokemonDetailNavigator {
  const PokemonDetailNavigator();

  /// Navigate back to list
  void navigateToList(BuildContext context) {
    context.go('/');
  }

  /// Go back
  void goBack(BuildContext context) {
    context.pop();
  }

  /// Share deep link
  Future<void> shareDeepLink(BuildContext context, int pokemonId) async {
    final deepLink = 'https://poke-deeplink.vercel.app/pokemon/$pokemonId';
    await Clipboard.setData(ClipboardData(text: deepLink));
    
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Deep link copied to clipboard!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
