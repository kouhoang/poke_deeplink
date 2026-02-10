import 'package:equatable/equatable.dart';

/// Base event for Pokemon detail
abstract class PokemonDetailEvent extends Equatable {
  const PokemonDetailEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load Pokemon detail by ID
class LoadPokemonDetail extends PokemonDetailEvent {
  final int id;

  const LoadPokemonDetail({required this.id});

  @override
  List<Object?> get props => [id];
}

/// Event to load Pokemon by name
class LoadPokemonByName extends PokemonDetailEvent {
  final String name;

  const LoadPokemonByName({required this.name});

  @override
  List<Object?> get props => [name];
}

/// Event to refresh Pokemon detail
class RefreshPokemonDetail extends PokemonDetailEvent {
  final int id;

  const RefreshPokemonDetail({required this.id});

  @override
  List<Object?> get props => [id];
}
