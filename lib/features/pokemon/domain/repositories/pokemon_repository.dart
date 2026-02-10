import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/pokemon_entity.dart';

/// Repository interface for Pokemon data operations
/// This defines the contract that the data layer must implement
abstract class PokemonRepository {
  /// Fetches a list of Pokemon
  /// Returns `Either<Failure, List<PokemonListItemEntity>>`
  Future<Either<Failure, List<PokemonListItemEntity>>> getPokemonList({
    int limit = 151,
    int offset = 0,
  });

  /// Fetches detailed information for a specific Pokemon by ID
  /// Returns `Either<Failure, PokemonEntity>`
  Future<Either<Failure, PokemonEntity>> getPokemonDetail(int id);

  /// Fetches detailed information for a specific Pokemon by name
  /// Returns `Either<Failure, PokemonEntity>`
  Future<Either<Failure, PokemonEntity>> getPokemonByName(String name);
}
