import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../screens/pokemon_detail_screen.dart';
import '../../screens/pokemon_list_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String pokemonDetail = '/pokemon/:id';

  static GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(
        path: home,
        name: 'home',
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const PokemonListScreen()),
      ),
      GoRoute(
        path: pokemonDetail,
        name: 'pokemonDetail',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return MaterialPage(
            key: state.pageKey,
            child: PokemonDetailScreen(id: id),
          );
        },
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Page not found: ${state.uri}'))),
  );
}
