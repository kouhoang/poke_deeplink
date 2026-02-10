import 'package:equatable/equatable.dart';

/// Base event for Pokemon list
abstract class PokemonListEvent extends Equatable {
  const PokemonListEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load Pokemon list
class LoadPokemonList extends PokemonListEvent {
  final int limit;
  final int offset;

  const LoadPokemonList({
    this.limit = 151,
    this.offset = 0,
  });

  @override
  List<Object?> get props => [limit, offset];
}

/// Event to load a specific page
class LoadPokemonPage extends PokemonListEvent {
  final int page;

  const LoadPokemonPage({required this.page});

  @override
  List<Object?> get props => [page];
}

/// Event to refresh the list
class RefreshPokemonList extends PokemonListEvent {
  const RefreshPokemonList();
}

/// Event to load more items (infinite scroll)
class LoadMorePokemons extends PokemonListEvent {
  const LoadMorePokemons();
}
