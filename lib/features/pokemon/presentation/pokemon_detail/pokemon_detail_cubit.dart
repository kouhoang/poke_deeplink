import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_pokemon_detail.dart';
import '../../domain/usecases/get_pokemon_by_name.dart';
import 'pokemon_detail_state.dart';

/// Cubit for Pokemon detail management
class PokemonDetailCubit extends Cubit<PokemonDetailState> {
  final GetPokemonDetail getPokemonDetail;
  final GetPokemonByName getPokemonByName;

  PokemonDetailCubit({
    required this.getPokemonDetail,
    required this.getPokemonByName,
  }) : super(const PokemonDetailInitial());

  /// Load Pokemon detail by ID
  Future<void> loadPokemonDetail(int id) async {
    emit(const PokemonDetailLoading());

    final result = await getPokemonDetail(GetPokemonDetailParams(id: id));

    result.fold(
      (failure) => emit(PokemonDetailError(message: failure.message)),
      (pokemon) => emit(PokemonDetailLoaded(pokemon: pokemon)),
    );
  }

  /// Load Pokemon by name
  Future<void> loadPokemonByName(String name) async {
    emit(const PokemonDetailLoading());

    final result = await getPokemonByName(GetPokemonByNameParams(name: name));

    result.fold(
      (failure) => emit(PokemonDetailError(message: failure.message)),
      (pokemon) => emit(PokemonDetailLoaded(pokemon: pokemon)),
    );
  }

  /// Refresh Pokemon detail
  Future<void> refreshPokemonDetail(int id) async {
    // Refresh without showing loading state
    final result = await getPokemonDetail(GetPokemonDetailParams(id: id));

    result.fold(
      (failure) => emit(PokemonDetailError(message: failure.message)),
      (pokemon) => emit(PokemonDetailLoaded(pokemon: pokemon)),
    );
  }
}
