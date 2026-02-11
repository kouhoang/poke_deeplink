import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/api_constants.dart';
import '../../../domain/usecases/get_pokemon_list.dart';
import 'pokemon_list_state.dart';

/// Cubit for Pokemon list management
class PokemonListCubit extends Cubit<PokemonListState> {
  final GetPokemonList getPokemonList;

  PokemonListCubit({required this.getPokemonList})
    : super(const PokemonListInitial());

  /// Load Pokemon list
  Future<void> loadPokemonList({
    int limit = ApiConstants.defaultLimit,
    int offset = 0,
  }) async {
    emit(const PokemonListLoading());

    final result = await getPokemonList(
      GetPokemonListParams(limit: limit, offset: offset),
    );

    result.fold((failure) => emit(PokemonListError(message: failure.message)), (
      pokemons,
    ) {
      final totalPages = (pokemons.length / ApiConstants.itemsPerPage).ceil();
      emit(
        PokemonListLoaded(
          pokemons: pokemons,
          currentPage: 1,
          totalPages: totalPages,
          hasMore: pokemons.length >= limit,
        ),
      );
    });
  }

  /// Load a specific page
  Future<void> loadPokemonPage(int page) async {
    final currentState = state;

    if (currentState is PokemonListLoaded) {
      emit(const PokemonListLoading());

      final result = await getPokemonList(
        const GetPokemonListParams(limit: ApiConstants.defaultLimit, offset: 0),
      );

      result.fold(
        (failure) => emit(PokemonListError(message: failure.message)),
        (pokemons) {
          final totalPages = (pokemons.length / ApiConstants.itemsPerPage)
              .ceil();
          emit(
            PokemonListLoaded(
              pokemons: pokemons,
              currentPage: page,
              totalPages: totalPages,
            ),
          );
        },
      );
    }
  }

  /// Refresh the list
  Future<void> refreshPokemonList() async {
    // Refresh without showing loading state
    final result = await getPokemonList(
      const GetPokemonListParams(limit: ApiConstants.defaultLimit, offset: 0),
    );

    result.fold((failure) => emit(PokemonListError(message: failure.message)), (
      pokemons,
    ) {
      final totalPages = (pokemons.length / ApiConstants.itemsPerPage).ceil();
      emit(
        PokemonListLoaded(
          pokemons: pokemons,
          currentPage: 1,
          totalPages: totalPages,
        ),
      );
    });
  }

  /// Load more items (pagination)
  Future<void> loadMorePokemons() async {
    final currentState = state;

    if (currentState is PokemonListLoaded && currentState.hasMore) {
      emit(PokemonListLoadingMore(currentPokemons: currentState.pokemons));

      final newOffset = currentState.pokemons.length;

      final result = await getPokemonList(
        GetPokemonListParams(
          limit: ApiConstants.itemsPerPage,
          offset: newOffset,
        ),
      );

      result.fold(
        (failure) => emit(PokemonListError(message: failure.message)),
        (newPokemons) {
          final allPokemons = [...currentState.pokemons, ...newPokemons];
          final totalPages = (allPokemons.length / ApiConstants.itemsPerPage)
              .ceil();

          emit(
            PokemonListLoaded(
              pokemons: allPokemons,
              currentPage: currentState.currentPage,
              totalPages: totalPages,
              hasMore: newPokemons.length >= ApiConstants.itemsPerPage,
            ),
          );
        },
      );
    }
  }
}
