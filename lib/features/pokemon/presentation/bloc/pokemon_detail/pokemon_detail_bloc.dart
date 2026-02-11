import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_pokemon_by_name.dart';
import '../../../domain/usecases/get_pokemon_detail.dart';
import 'pokemon_detail_event.dart';
import 'pokemon_detail_state.dart';

/// BLoC for Pokemon detail management
class PokemonDetailBloc extends Bloc<PokemonDetailEvent, PokemonDetailState> {
  final GetPokemonDetail getPokemonDetail;
  final GetPokemonByName getPokemonByName;

  PokemonDetailBloc({
    required this.getPokemonDetail,
    required this.getPokemonByName,
  }) : super(const PokemonDetailInitial()) {
    on<LoadPokemonDetail>(_onLoadPokemonDetail);
    on<LoadPokemonByName>(_onLoadPokemonByName);
    on<RefreshPokemonDetail>(_onRefreshPokemonDetail);
  }

  /// Handles loading Pokemon detail by ID
  Future<void> _onLoadPokemonDetail(
    LoadPokemonDetail event,
    Emitter<PokemonDetailState> emit,
  ) async {
    emit(const PokemonDetailLoading());

    final result = await getPokemonDetail(GetPokemonDetailParams(id: event.id));

    result.fold(
      (failure) => emit(PokemonDetailError(message: failure.message)),
      (pokemon) => emit(PokemonDetailLoaded(pokemon: pokemon)),
    );
  }

  /// Handles loading Pokemon by name
  Future<void> _onLoadPokemonByName(
    LoadPokemonByName event,
    Emitter<PokemonDetailState> emit,
  ) async {
    emit(const PokemonDetailLoading());

    final result = await getPokemonByName(
      GetPokemonByNameParams(name: event.name),
    );

    result.fold(
      (failure) => emit(PokemonDetailError(message: failure.message)),
      (pokemon) => emit(PokemonDetailLoaded(pokemon: pokemon)),
    );
  }

  /// Handles refreshing Pokemon detail
  Future<void> _onRefreshPokemonDetail(
    RefreshPokemonDetail event,
    Emitter<PokemonDetailState> emit,
  ) async {
    // Refresh without showing loading state
    final result = await getPokemonDetail(GetPokemonDetailParams(id: event.id));

    result.fold(
      (failure) => emit(PokemonDetailError(message: failure.message)),
      (pokemon) => emit(PokemonDetailLoaded(pokemon: pokemon)),
    );
  }
}
