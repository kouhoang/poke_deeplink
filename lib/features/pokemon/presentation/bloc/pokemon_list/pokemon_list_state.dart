import 'package:equatable/equatable.dart';
import '../../../domain/entities/pokemon_entity.dart';

/// Base state for Pokemon list
abstract class PokemonListState extends Equatable {
  const PokemonListState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class PokemonListInitial extends PokemonListState {
  const PokemonListInitial();
}

/// Loading state
class PokemonListLoading extends PokemonListState {
  const PokemonListLoading();
}

/// Loading more items (pagination)
class PokemonListLoadingMore extends PokemonListState {
  final List<PokemonListItemEntity> currentPokemons;

  const PokemonListLoadingMore({required this.currentPokemons});

  @override
  List<Object?> get props => [currentPokemons];
}

/// Loaded state with data
class PokemonListLoaded extends PokemonListState {
  final List<PokemonListItemEntity> pokemons;
  final int currentPage;
  final int totalPages;
  final bool hasMore;

  const PokemonListLoaded({
    required this.pokemons,
    required this.currentPage,
    required this.totalPages,
    this.hasMore = false,
  });

  @override
  List<Object?> get props => [pokemons, currentPage, totalPages, hasMore];

  PokemonListLoaded copyWith({
    List<PokemonListItemEntity>? pokemons,
    int? currentPage,
    int? totalPages,
    bool? hasMore,
  }) {
    return PokemonListLoaded(
      pokemons: pokemons ?? this.pokemons,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

/// Error state
class PokemonListError extends PokemonListState {
  final String message;

  const PokemonListError({required this.message});

  @override
  List<Object?> get props => [message];
}
