import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../datasources/pokemon_remote_data_source.dart';

/// Implementation of Pokemon repository
/// Handles data operations and converts exceptions to failures
class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remoteDataSource;

  PokemonRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<PokemonListItemEntity>>> getPokemonList({
    int limit = 151,
    int offset = 0,
  }) async {
    try {
      final result = await remoteDataSource.getPokemonList(
        limit: limit,
        offset: offset,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on ParsingException catch (e) {
      return Left(
        UnexpectedFailure(message: 'Data parsing error: ${e.message}'),
      );
    } catch (e) {
      return Left(UnexpectedFailure(message: 'Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, PokemonEntity>> getPokemonDetail(int id) async {
    try {
      final result = await remoteDataSource.getPokemonDetail(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on ParsingException catch (e) {
      return Left(
        UnexpectedFailure(message: 'Data parsing error: ${e.message}'),
      );
    } catch (e) {
      return Left(UnexpectedFailure(message: 'Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, PokemonEntity>> getPokemonByName(String name) async {
    try {
      final result = await remoteDataSource.getPokemonByName(name);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on ParsingException catch (e) {
      return Left(
        UnexpectedFailure(message: 'Data parsing error: ${e.message}'),
      );
    } catch (e) {
      return Left(UnexpectedFailure(message: 'Unexpected error: $e'));
    }
  }
}
