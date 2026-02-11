import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/pokemon_entity.dart';
import '../repositories/pokemon_repository.dart';

/// Use case for fetching Pokemon by name
class GetPokemonByName
    implements UseCase<PokemonEntity, GetPokemonByNameParams> {
  final PokemonRepository repository;

  GetPokemonByName(this.repository);

  @override
  Future<Either<Failure, PokemonEntity>> call(
    GetPokemonByNameParams params,
  ) async {
    return await repository.getPokemonByName(params.name);
  }
}

class GetPokemonByNameParams extends Equatable {
  final String name;

  const GetPokemonByNameParams({required this.name});

  @override
  List<Object?> get props => [name];
}
