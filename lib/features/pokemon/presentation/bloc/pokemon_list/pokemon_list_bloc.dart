import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/api_constants.dart';
import '../../../domain/usecases/get_pokemon_list.dart';
import 'pokemon_list_event.dart';
import 'pokemon_list_state.dart';

/// BLoC for Pokemon list management
class PokemonListBloc extends Bloc<PokemonListEvent, PokemonListState> {
  final GetPokemonList getPokemonList;

  PokemonListBloc({required this.getPokemonList})
    : super(const PokemonListInitial()) {
    on<LoadPokemonList>(_onLoadPokemonList);
    on<LoadPokemonPage>(_onLoadPokemonPage);
    on<RefreshPokemonList>(_onRefreshPokemonList);
    on<LoadMorePokemons>(_onLoadMorePokemons);
  }

  /// Handles loading Pokemon list
  Future<void> _onLoadPokemonList(
    LoadPokemonList event,
    Emitter<PokemonListState> emit,
  ) async {
    emit(const PokemonListLoading());

    final result = await getPokemonList(
      GetPokemonListParams(limit: event.limit, offset: event.offset),
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
          hasMore: pokemons.length >= event.limit,
        ),
      );
    });
  }

  /// Handles loading a specific page
  Future<void> _onLoadPokemonPage(
    LoadPokemonPage event,
    Emitter<PokemonListState> emit,
  ) async {
    final currentState = state;

    if (currentState is PokemonListLoaded) {
      emit(const PokemonListLoading());

      final result = await getPokemonList(
        GetPokemonListParams(limit: ApiConstants.defaultLimit, offset: 0),
      );

      result.fold(
        (failure) => emit(PokemonListError(message: failure.message)),
        (pokemons) {
          final totalPages = (pokemons.length / ApiConstants.itemsPerPage)
              .ceil();
          emit(
            PokemonListLoaded(
              pokemons: pokemons,
              currentPage: event.page,
              totalPages: totalPages,
            ),
          );
        },
      );
    }
  }

  /// Handles refreshing the list
  Future<void> _onRefreshPokemonList(
    RefreshPokemonList event,
    Emitter<PokemonListState> emit,
  ) async {
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

  /// Handles loading more items (pagination)
  Future<void> _onLoadMorePokemons(
    LoadMorePokemons event,
    Emitter<PokemonListState> emit,
  ) async {
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
