import 'package:equatable/equatable.dart';
import '../../../domain/entities/pokemon_entity.dart';

/// Base state for Pokemon detail
abstract class PokemonDetailState extends Equatable {
  const PokemonDetailState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class PokemonDetailInitial extends PokemonDetailState {
  const PokemonDetailInitial();
}

/// Loading state
class PokemonDetailLoading extends PokemonDetailState {
  const PokemonDetailLoading();
}

/// Loaded state with Pokemon data
class PokemonDetailLoaded extends PokemonDetailState {
  final PokemonEntity pokemon;

  const PokemonDetailLoaded({required this.pokemon});

  @override
  List<Object?> get props => [pokemon];
}

/// Error state
class PokemonDetailError extends PokemonDetailState {
  final String message;

  const PokemonDetailError({required this.message});

  @override
  List<Object?> get props => [message];
}
