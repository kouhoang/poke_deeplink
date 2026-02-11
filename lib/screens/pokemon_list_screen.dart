import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/pokemon.dart';
import '../services/pokemon_service.dart';

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({super.key});

  @override
  State<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  final PokemonService _pokemonService = PokemonService();
  final PageController _pageController = PageController();

  List<PokemonListItem> _allPokemon = [];
  final Map<int, List<Pokemon>> _loadedPages = {};

  bool _isLoadingList = true;
  String? _error;

  int _currentPage = 0;
  static const int _pokemonPerPage = 50; // Increased for web

  @override
  void initState() {
    super.initState();
    _loadPokemonList();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadPokemonList() async {
    try {
      final pokemonList = await _pokemonService.getPokemonList(limit: 500);
      setState(() {
        _allPokemon = pokemonList;
        _isLoadingList = false;
      });

      _loadPage(0);
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoadingList = false;
      });
    }
  }

  Future<void> _loadPage(int page) async {
    if (_loadedPages.containsKey(page)) return;

    final startIndex = page * _pokemonPerPage;
    final endIndex = (startIndex + _pokemonPerPage).clamp(
      0,
      _allPokemon.length,
    );
    final pageItems = _allPokemon.sublist(startIndex, endIndex);

    try {
      final futures = pageItems.map(
        (item) => _pokemonService.getPokemonDetail(item.id),
      );

      final results = await Future.wait(futures);

      setState(() {
        _loadedPages[page] = results;
      });
    } catch (e) {
      // Silently fail
    }
  }

  void _goToPage(int page) {
    setState(() => _currentPage = page);
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    _loadPage(page);
  }

  int get _totalPages => (_allPokemon.length / _pokemonPerPage).ceil();

  // Get responsive column count based on screen width
  int _getColumnCount(double width) {
    if (width > 1400) return 8; // Very wide screens
    if (width > 1200) return 6; // Desktop
    if (width > 900) return 5; // Laptop
    if (width > 600) return 4; // Tablet landscape
    if (width > 400) return 3; // Tablet portrait
    return 2; // Mobile
  }

  Color _getTypeColor(String type) {
    final typeColors = {
      'normal': const Color(0xFFA8A878),
      'fire': const Color(0xFFFF6B6B),
      'water': const Color(0xFF4ECDC4),
      'electric': const Color(0xFFFFD93D),
      'grass': const Color(0xFF6BCF7F),
      'ice': const Color(0xFF98D8C8),
      'fighting': const Color(0xFFFF8FAB),
      'poison': const Color(0xFFB388EB),
      'ground': const Color(0xFFE0AC69),
      'flying': const Color(0xFF8FA7DF),
      'psychic': const Color(0xFFFF8FAB),
      'bug': const Color(0xFFA8B820),
      'rock': const Color(0xFFB8A038),
      'ghost': const Color(0xFF705898),
      'dragon': const Color(0xFF7038F8),
      'dark': const Color(0xFF705848),
      'steel': const Color(0xFFB8B8D0),
      'fairy': const Color(0xFFFFB6B9),
    };
    return typeColors[type] ?? const Color(0xFFA8A878);
  }

  List<Widget> _buildPageIndicators() {
    List<Widget> indicators = [];

    indicators.add(_buildPageButton(0));

    if (_totalPages <= 7) {
      for (int i = 1; i < _totalPages; i++) {
        indicators.add(_buildPageButton(i));
      }
    } else {
      if (_currentPage <= 3) {
        for (int i = 1; i < 5; i++) {
          indicators.add(_buildPageButton(i));
        }
        indicators.add(_buildEllipsis());
        indicators.add(_buildPageButton(_totalPages - 1));
      } else if (_currentPage >= _totalPages - 4) {
        indicators.add(_buildEllipsis());
        for (int i = _totalPages - 5; i < _totalPages; i++) {
          indicators.add(_buildPageButton(i));
        }
      } else {
        indicators.add(_buildEllipsis());
        for (int i = _currentPage - 1; i <= _currentPage + 1; i++) {
          indicators.add(_buildPageButton(i));
        }
        indicators.add(_buildEllipsis());
        indicators.add(_buildPageButton(_totalPages - 1));
      }
    }

    return indicators;
  }

  Widget _buildPageButton(int page) {
    final isCurrentPage = page == _currentPage;
    return GestureDetector(
      onTap: () => _goToPage(page),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        width: isCurrentPage ? 36 : 28,
        height: isCurrentPage ? 36 : 28,
        decoration: BoxDecoration(
          gradient: isCurrentPage
              ? const LinearGradient(
                  colors: [Color(0xFF4ECDC4), Color(0xFF45B7D1)],
                )
              : null,
          color: isCurrentPage ? null : Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: isCurrentPage
              ? Border.all(color: const Color(0xFF4ECDC4), width: 2)
              : null,
        ),
        child: Center(
          child: Text(
            '${page + 1}',
            style: GoogleFonts.poppins(
              fontSize: isCurrentPage ? 13 : 11,
              fontWeight: isCurrentPage ? FontWeight.bold : FontWeight.w500,
              color: isCurrentPage ? Colors.white : Colors.white60,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEllipsis() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: 28,
      height: 28,
      child: Center(
        child: Text(
          '...',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white60,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingList) {
      return Scaffold(
        backgroundColor: const Color(0xFF0F172A),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4ECDC4)),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Loading Pokédex...',
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_error != null) {
      return Scaffold(
        backgroundColor: const Color(0xFF0F172A),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Color(0xFFFF6B6B),
              ),
              const SizedBox(height: 16),
              Text(
                'Error loading Pokémon',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _isLoadingList = true;
                    _error = null;
                    _loadedPages.clear();
                  });
                  _loadPokemonList();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4ECDC4),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final columnCount = _getColumnCount(constraints.maxWidth);

          return Column(
            children: [
              // Compact App Bar
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF1E293B), Color(0xFF334155)],
                  ),
                ),
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pokédex',
                                style: GoogleFonts.poppins(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '${_allPokemon.length} Pokémon',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: const Color(0xFF4ECDC4),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF4ECDC4,
                            ).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(
                                0xFF4ECDC4,
                              ).withValues(alpha: 0.5),
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            'Page ${_currentPage + 1}/$_totalPages',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF4ECDC4),
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Pokemon Grid
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (page) {
                    setState(() => _currentPage = page);
                    _loadPage(page);
                  },
                  itemCount: _totalPages,
                  itemBuilder: (context, pageIndex) {
                    final pokemonList = _loadedPages[pageIndex];

                    if (pokemonList == null) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                strokeWidth: 4,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xFF4ECDC4),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Loading page ${pageIndex + 1}...',
                              style: GoogleFonts.poppins(
                                color: Colors.white60,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columnCount,
                        childAspectRatio: 0.72,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: pokemonList.length,
                      itemBuilder: (context, index) {
                        final pokemon = pokemonList[index];
                        return _PokemonGridCard(
                          pokemon: pokemon,
                          index: index,
                          getTypeColor: _getTypeColor,
                        );
                      },
                    );
                  },
                ),
              ),

              // Pagination Controls
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: _currentPage > 0
                            ? () => _goToPage(_currentPage - 1)
                            : null,
                        icon: const Icon(Icons.chevron_left),
                        color: _currentPage > 0
                            ? const Color(0xFF4ECDC4)
                            : Colors.grey.shade700,
                        iconSize: 28,
                      ),

                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _buildPageIndicators(),
                          ),
                        ),
                      ),

                      IconButton(
                        onPressed: _currentPage < _totalPages - 1
                            ? () => _goToPage(_currentPage + 1)
                            : null,
                        icon: const Icon(Icons.chevron_right),
                        color: _currentPage < _totalPages - 1
                            ? const Color(0xFF4ECDC4)
                            : Colors.grey.shade700,
                        iconSize: 28,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _PokemonGridCard extends StatefulWidget {
  final Pokemon pokemon;
  final int index;
  final Color Function(String) getTypeColor;

  const _PokemonGridCard({
    required this.pokemon,
    required this.index,
    required this.getTypeColor,
  });

  @override
  State<_PokemonGridCard> createState() => _PokemonGridCardState();
}

class _PokemonGridCardState extends State<_PokemonGridCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final primaryColor = widget.getTypeColor(widget.pokemon.primaryType);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => context.go('/pokemon/${widget.pokemon.id}'),
        child: AnimatedScale(
          scale: _isHovered ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          child:
              Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          primaryColor.withValues(alpha: 0.2),
                          primaryColor.withValues(alpha: 0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: _isHovered
                            ? primaryColor.withValues(alpha: 0.6)
                            : primaryColor.withValues(alpha: 0.3),
                        width: _isHovered ? 2 : 1.5,
                      ),
                      boxShadow: _isHovered
                          ? [
                              BoxShadow(
                                color: primaryColor.withValues(alpha: 0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Stack(
                      children: [
                        // Pokeball Background
                        Positioned(
                          right: -8,
                          bottom: -8,
                          child: Opacity(
                            opacity: 0.05,
                            child: Icon(
                              Icons.catching_pokemon,
                              size: 60,
                              color: primaryColor,
                            ),
                          ),
                        ),

                        // Content
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ID Badge
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withValues(alpha: 0.3),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    '#${widget.pokemon.id.toString().padLeft(3, '0')}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),

                              const Spacer(),

                              // Pokemon Image
                              Center(
                                child: Hero(
                                  tag: 'pokemon-${widget.pokemon.id}',
                                  child: CachedNetworkImage(
                                    imageUrl: widget.pokemon.imageUrl,
                                    height: 55,
                                    width: 55,
                                    fit: BoxFit.contain,
                                    placeholder: (context, url) =>
                                        const SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white38,
                                          ),
                                        ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                          Icons.catching_pokemon,
                                          size: 35,
                                          color: Colors.white38,
                                        ),
                                  ),
                                ),
                              ),

                              const Spacer(),

                              // Name
                              Text(
                                widget.pokemon.capitalizedName,
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),

                              const SizedBox(height: 4),

                              // Types
                              Wrap(
                                spacing: 3,
                                runSpacing: 3,
                                children: widget.pokemon.types.take(2).map((
                                  type,
                                ) {
                                  final color = widget.getTypeColor(type);
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: color.withValues(alpha: 0.3),
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: color.withValues(alpha: 0.6),
                                        width: 0.8,
                                      ),
                                    ),
                                    child: Text(
                                      type.toUpperCase(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 7,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        letterSpacing: 0.3,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),

                              const SizedBox(height: 4),

                              // Stats
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _StatChip(
                                    label: 'HP',
                                    value: widget.pokemon.stats[0].baseStat
                                        .toString(),
                                    color: const Color(0xFFFF6B6B),
                                  ),
                                  _StatChip(
                                    label: 'ATK',
                                    value: widget.pokemon.stats[1].baseStat
                                        .toString(),
                                    color: const Color(0xFFFFD93D),
                                  ),
                                  _StatChip(
                                    label: 'DEF',
                                    value: widget.pokemon.stats[2].baseStat
                                        .toString(),
                                    color: const Color(0xFF4ECDC4),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                  .animate()
                  .fadeIn(delay: Duration(milliseconds: widget.index * 30))
                  .scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1, 1),
                    delay: Duration(milliseconds: widget.index * 30),
                  ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatChip({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
        margin: const EdgeInsets.symmetric(horizontal: 1),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 6.5,
                fontWeight: FontWeight.w600,
                color: Colors.white70,
              ),
            ),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
