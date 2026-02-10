import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/pokemon_entity.dart';
import '../repositories/pokemon_repository.dart';

/// Use case for fetching Pokemon detail by ID
class GetPokemonDetail implements UseCase<PokemonEntity, GetPokemonDetailParams> {
  final PokemonRepository repository;

  GetPokemonDetail(this.repository);

  @override
  Future<Either<Failure, PokemonEntity>> call(
    GetPokemonDetailParams params,
  ) async {
    return await repository.getPokemonDetail(params.id);
  }
}

class GetPokemonDetailParams extends Equatable {
  final int id;

  const GetPokemonDetailParams({required this.id});

  @override
  List<Object?> get props => [id];
}
