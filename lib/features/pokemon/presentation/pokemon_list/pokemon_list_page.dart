import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Core imports
import '../../../../core/constants/app_colors.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../../core/widgets/widgets.dart';

// Feature imports
import '../../domain/entities/pokemon_entity.dart';
import 'pokemon_list_cubit.dart';
import 'pokemon_list_state.dart';
import 'pokemon_list_navigator.dart';
import 'widgets/pokemon_grid_card.dart';
import 'widgets/pokemon_list_app_bar.dart';
import 'widgets/pagination_controls.dart';

/// Pokemon List Page
class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  final PokemonListNavigator _navigator = const PokemonListNavigator();
  final PageController _pageController = PageController();
  
  int _currentPage = 0;
  static const int _pokemonPerPage = 50;

  @override
  void initState() {
    super.initState();
    // Load Pokemon list on init
    context.read<PokemonListCubit>().loadPokemonList();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int page) {
    setState(() => _currentPage = page);
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  int _getTotalPages(int totalPokemons) {
    return (totalPokemons / _pokemonPerPage).ceil();
  }

  int _getColumnCount(double width) {
    if (width > 1400) return 8;
    if (width > 1200) return 6;
    if (width > 900) return 5;
    if (width > 600) return 4;
    if (width > 400) return 3;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<PokemonListCubit, PokemonListState>(
        builder: (context, state) {
          if (state is PokemonListLoading) {
            return FullScreenLoading(
              message: AppStrings.loadingPokedex,
            );
          }

          if (state is PokemonListError) {
            return FullScreenError(
              message: state.message,
              onRetry: () => context.read<PokemonListCubit>().loadPokemonList(),
            );
          }

          if (state is PokemonListLoaded) {
            final totalPages = _getTotalPages(state.pokemons.length);

            return LayoutBuilder(
              builder: (context, constraints) {
                final columnCount = _getColumnCount(constraints.maxWidth);

                return Column(
                  children: [
                    // App Bar
                    PokemonListAppBar(
                      totalPokemons: state.pokemons.length,
                      currentPage: _currentPage + 1,
                      totalPages: totalPages,
                    ),

                    // Pokemon Grid
                    Expanded(
                      child: _buildPokemonGrid(
                        state.pokemons,
                        columnCount,
                        totalPages,
                      ),
                    ),

                    // Pagination Controls
                    PaginationControls(
                      currentPage: _currentPage,
                      totalPages: totalPages,
                      onPageChanged: _goToPage,
                    ),
                  ],
                );
              },
            );
          }

          // Initial state
          return FullScreenLoading(
            message: AppStrings.loadingPokedex,
          );
        },
      ),
    );
  }

  Widget _buildPokemonGrid(
    List<PokemonListItemEntity> allPokemons,
    int columnCount,
    int totalPages,
  ) {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: (page) => setState(() => _currentPage = page),
      itemCount: totalPages,
      itemBuilder: (context, pageIndex) {
        final startIndex = pageIndex * _pokemonPerPage;
        final endIndex = (startIndex + _pokemonPerPage).clamp(0, allPokemons.length);
        final pagePokemons = allPokemons.sublist(startIndex, endIndex);

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columnCount,
            childAspectRatio: 0.72,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: pagePokemons.length,
          itemBuilder: (context, index) {
            final pokemon = pagePokemons[index];
            return PokemonGridCard(
              pokemon: pokemon,
              index: index,
              onTap: () => _navigator.navigateToDetail(context, pokemon.id),
            );
          },
        );
      },
    );
  }
}
