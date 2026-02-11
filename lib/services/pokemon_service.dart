import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class PokemonService {
  static const String baseUrl = 'https://pokeapi.co/api/v2';

  Future<List<PokemonListItem>> getPokemonList({int limit = 151}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/pokemon?limit=$limit'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;
        return results.map((item) => PokemonListItem.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load Pokemon list');
      }
    } catch (e) {
      throw Exception('Error fetching Pokemon list: $e');
    }
  }

  Future<Pokemon> getPokemonDetail(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/pokemon/$id'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Pokemon.fromJson(data);
      } else {
        throw Exception('Failed to load Pokemon detail');
      }
    } catch (e) {
      throw Exception('Error fetching Pokemon detail: $e');
    }
  }

  Future<Pokemon> getPokemonByName(String name) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/pokemon/${name.toLowerCase()}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Pokemon.fromJson(data);
      } else {
        throw Exception('Failed to load Pokemon');
      }
    } catch (e) {
      throw Exception('Error fetching Pokemon: $e');
    }
  }
}
