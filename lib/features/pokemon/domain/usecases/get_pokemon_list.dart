import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/pokemon_entity.dart';
import '../repositories/pokemon_repository.dart';

/// Use case for fetching Pokemon list
class GetPokemonList
    implements UseCase<List<PokemonListItemEntity>, GetPokemonListParams> {
  final PokemonRepository repository;

  GetPokemonList(this.repository);

  @override
  Future<Either<Failure, List<PokemonListItemEntity>>> call(
    GetPokemonListParams params,
  ) async {
    return await repository.getPokemonList(
      limit: params.limit,
      offset: params.offset,
    );
  }
}

class GetPokemonListParams extends Equatable {
  final int limit;
  final int offset;

  const GetPokemonListParams({this.limit = 151, this.offset = 0});

  @override
  List<Object?> get props => [limit, offset];
}
