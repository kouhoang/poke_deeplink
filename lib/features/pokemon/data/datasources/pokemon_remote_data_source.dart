import 'dart:convert';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/network_client.dart';
import '../models/pokemon_model.dart';

/// Remote data source for Pokemon API
abstract class PokemonRemoteDataSource {
  /// Fetches Pokemon list from API
  /// Throws [ServerException] or [NetworkException] on error
  Future<List<PokemonListItemModel>> getPokemonList({
    int limit = 151,
    int offset = 0,
  });

  /// Fetches Pokemon detail from API
  /// Throws [ServerException] or [NetworkException] on error
  Future<PokemonModel> getPokemonDetail(int id);

  /// Fetches Pokemon by name from API
  /// Throws [ServerException] or [NetworkException] on error
  Future<PokemonModel> getPokemonByName(String name);
}

/// Implementation of Pokemon remote data source
class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final NetworkClient networkClient;

  PokemonRemoteDataSourceImpl({required this.networkClient});

  @override
  Future<List<PokemonListItemModel>> getPokemonList({
    int limit = 151,
    int offset = 0,
  }) async {
    try {
      final url = '${ApiConstants.baseUrl}${ApiConstants.pokemonEndpoint}'
          '?limit=$limit&offset=$offset';

      final response = await networkClient.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final results = data['results'] as List<dynamic>?;

        if (results == null) {
          throw const ParsingException(
            message: 'Invalid response format: missing results',
          );
        }

        return results
            .map((item) => PokemonListItemModel.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(
          message: 'Failed to load Pokemon list',
          statusCode: response.statusCode,
        );
      }
    } on ServerException {
      rethrow;
    } on NetworkException {
      rethrow;
    } on ParsingException {
      rethrow;
    } catch (e) {
      throw ParsingException(
        message: 'Error parsing Pokemon list: $e',
      );
    }
  }

  @override
  Future<PokemonModel> getPokemonDetail(int id) async {
    try {
      final url = '${ApiConstants.baseUrl}${ApiConstants.pokemonEndpoint}/$id';

      final response = await networkClient.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        return PokemonModel.fromJson(data);
      } else {
        throw ServerException(
          message: 'Failed to load Pokemon detail for ID: $id',
          statusCode: response.statusCode,
        );
      }
    } on ServerException {
      rethrow;
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw ParsingException(
        message: 'Error parsing Pokemon detail: $e',
      );
    }
  }

  @override
  Future<PokemonModel> getPokemonByName(String name) async {
    try {
      final url = '${ApiConstants.baseUrl}${ApiConstants.pokemonEndpoint}/${name.toLowerCase()}';

      final response = await networkClient.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        return PokemonModel.fromJson(data);
      } else if (response.statusCode == 404) {
        throw ServerException(
          message: 'Pokemon not found: $name',
          statusCode: 404,
        );
      } else {
        throw ServerException(
          message: 'Failed to load Pokemon: $name',
          statusCode: response.statusCode,
        );
      }
    } on ServerException {
      rethrow;
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw ParsingException(
        message: 'Error parsing Pokemon data: $e',
      );
    }
  }
}
