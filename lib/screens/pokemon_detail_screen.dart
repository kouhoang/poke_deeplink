import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../models/pokemon.dart';
import '../services/pokemon_service.dart';
import 'dart:math' as math;

class PokemonDetailScreen extends StatefulWidget {
  final String id;

  const PokemonDetailScreen({super.key, required this.id});

  @override
  State<PokemonDetailScreen> createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen>
    with SingleTickerProviderStateMixin {
  final PokemonService _pokemonService = PokemonService();
  Pokemon? _pokemon;
  bool _isLoading = true;
  String? _error;
  bool _showShiny = false;
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
    _loadPokemonDetail();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  Future<void> _loadPokemonDetail() async {
    try {
      final pokemon = await _pokemonService.getPokemonDetail(
        int.parse(widget.id),
      );
      setState(() {
        _pokemon = pokemon;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
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

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: const Color(0xFF0F172A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1E293B),
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  strokeWidth: 6,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    const Color(0xFF4ECDC4),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Loading Pokémon...',
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_error != null || _pokemon == null) {
      return Scaffold(
        backgroundColor: const Color(0xFF0F172A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1E293B),
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 80,
                color: Color(0xFFFF6B6B),
              ),
              const SizedBox(height: 16),
              Text(
                'Error loading Pokémon',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                    _error = null;
                  });
                  _loadPokemonDetail();
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

    final pokemon = _pokemon!;
    final primaryColor = _getTypeColor(pokemon.primaryType);

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: CustomScrollView(
        slivers: [
          // Stunning App Bar with Pokemon
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => context.go('/'),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                pokemon.capitalizedName,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  shadows: [
                    const Shadow(
                      color: Colors.black45,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Gradient Background
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          primaryColor,
                          primaryColor.withValues(alpha: 0.7),
                        ],
                      ),
                    ),
                  ),

                  // Animated Pokeball Background
                  Positioned.fill(
                    child: AnimatedBuilder(
                      animation: _rotationController,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _rotationController.value * 2 * math.pi,
                          child: Opacity(
                            opacity: 0.1,
                            child: Icon(
                              Icons.catching_pokemon,
                              size: 300,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Pokemon Image
                  Center(
                    child: Hero(
                      tag: 'pokemon-${pokemon.id}',
                      child: GestureDetector(
                        onTap: () {
                          if (pokemon.shinyImageUrl != null) {
                            setState(() => _showShiny = !_showShiny);
                          }
                        },
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: CachedNetworkImage(
                            key: ValueKey(_showShiny),
                            imageUrl:
                                _showShiny && pokemon.shinyImageUrl != null
                                ? pokemon.shinyImageUrl!
                                : pokemon.imageUrl,
                            height: 250,
                            width: 250,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.catching_pokemon,
                              size: 200,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Pokemon ID Badge
                  Positioned(
                    top: 100,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                          width: 2,
                        ),
                      ),
                      child: Text(
                        '#${pokemon.id.toString().padLeft(3, '0')}',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  // Shiny Indicator
                  if (pokemon.shinyImageUrl != null)
                    Positioned(
                      top: 100,
                      left: 20,
                      child:
                          GestureDetector(
                                onTap: () =>
                                    setState(() => _showShiny = !_showShiny),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: _showShiny
                                        ? Colors.amber.withValues(alpha: 0.9)
                                        : Colors.black.withValues(alpha: 0.3),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white.withValues(
                                        alpha: 0.3,
                                      ),
                                      width: 2,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                              )
                              .animate(
                                onPlay: (controller) => controller.repeat(),
                              )
                              .shimmer(
                                duration: const Duration(seconds: 2),
                                color: Colors.amber,
                              ),
                    ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(color: Color(0xFF0F172A)),
              child: Column(
                children: [
                  const SizedBox(height: 24),

                  // Types
                  _buildTypesSection(pokemon, primaryColor),

                  const SizedBox(height: 24),

                  // Quick Stats
                  _buildQuickStats(pokemon, primaryColor),

                  const SizedBox(height: 24),

                  // Abilities
                  _buildAbilitiesSection(pokemon, primaryColor),

                  const SizedBox(height: 24),

                  // Base Stats
                  _buildStatsSection(pokemon, primaryColor),

                  const SizedBox(height: 24),

                  // Physical Info
                  _buildPhysicalInfo(pokemon, primaryColor),

                  const SizedBox(height: 24),

                  // Share Button
                  _buildShareButton(pokemon, primaryColor),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypesSection(Pokemon pokemon, Color primaryColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        alignment: WrapAlignment.center,
        children: pokemon.types.map((type) {
          final color = _getTypeColor(type);
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withValues(alpha: 0.7)],
              ),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(_getTypeIcon(type), color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  type.toUpperCase(),
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ).animate().scale(delay: const Duration(milliseconds: 100));
        }).toList(),
      ),
    );
  }

  Widget _buildQuickStats(Pokemon pokemon, Color primaryColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              primaryColor.withValues(alpha: 0.2),
              primaryColor.withValues(alpha: 0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: primaryColor.withValues(alpha: 0.3),
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildQuickStatItem(
              icon: Icons.favorite,
              label: 'Total',
              value: pokemon.totalStats.toString(),
              color: const Color(0xFFFF6B6B),
            ),
            Container(width: 1, height: 50, color: Colors.white24),
            _buildQuickStatItem(
              icon: Icons.trending_up,
              label: 'Average',
              value: pokemon.averageStats.toStringAsFixed(1),
              color: const Color(0xFF4ECDC4),
            ),
            Container(width: 1, height: 50, color: Colors.white24),
            _buildQuickStatItem(
              icon: Icons.star,
              label: 'Base EXP',
              value: pokemon.baseExperience.toString(),
              color: const Color(0xFFFFD93D),
            ),
          ],
        ),
      ).animate().fadeIn().slideY(begin: 0.2, end: 0),
    );
  }

  Widget _buildQuickStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 12, color: Colors.white60),
        ),
      ],
    );
  }

  Widget _buildAbilitiesSection(Pokemon pokemon, Color primaryColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Abilities',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: pokemon.abilities.map((ability) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: ability.isHidden
                      ? const Color(0xFFB388EB).withValues(alpha: 0.2)
                      : primaryColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: ability.isHidden
                        ? const Color(0xFFB388EB).withValues(alpha: 0.5)
                        : primaryColor.withValues(alpha: 0.5),
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (ability.isHidden)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.visibility_off,
                          size: 18,
                          color: const Color(0xFFB388EB),
                        ),
                      ),
                    Text(
                      ability.displayName,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ).animate().fadeIn(delay: const Duration(milliseconds: 200)),
    );
  }

  Widget _buildStatsSection(Pokemon pokemon, Color primaryColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [const Color(0xFF1E293B), const Color(0xFF334155)],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.bar_chart, color: primaryColor, size: 28),
                const SizedBox(width: 12),
                Text(
                  'Base Stats',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ...pokemon.stats.asMap().entries.map((entry) {
              final index = entry.key;
              final stat = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: _buildStatBar(
                  stat: stat,
                  color: primaryColor,
                  delay: index * 100,
                ),
              );
            }),
          ],
        ),
      ).animate().fadeIn(delay: const Duration(milliseconds: 300)),
    );
  }

  Widget _buildStatBar({
    required PokemonStat stat,
    required Color color,
    required int delay,
  }) {
    final percentage = stat.baseStat / 255;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 80,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    stat.shortName,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
                if (stat.effort > 0)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFD93D).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '+${stat.effort} EV',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFFFD93D),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Text(
              stat.baseStat.toString(),
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 12,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            FractionallySizedBox(
              widthFactor: percentage,
              child:
                  Container(
                    height: 12,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color, color.withValues(alpha: 0.7)],
                      ),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: color.withValues(alpha: 0.5),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  ).animate().scaleX(
                    duration: const Duration(milliseconds: 800),
                    delay: Duration(milliseconds: delay),
                    begin: 0,
                    end: 1,
                    curve: Curves.easeOutCubic,
                  ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPhysicalInfo(Pokemon pokemon, Color primaryColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF4ECDC4).withValues(alpha: 0.2),
                    const Color(0xFF4ECDC4).withValues(alpha: 0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF4ECDC4).withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Icon(Icons.height, color: const Color(0xFF4ECDC4), size: 36),
                  const SizedBox(height: 12),
                  Text(
                    'Height',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.white60,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${(pokemon.height / 10).toStringAsFixed(1)} m',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: const Duration(milliseconds: 400)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFFF8FAB).withValues(alpha: 0.2),
                    const Color(0xFFFF8FAB).withValues(alpha: 0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFFFF8FAB).withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.monitor_weight,
                    color: const Color(0xFFFF8FAB),
                    size: 36,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Weight',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.white60,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${(pokemon.weight / 10).toStringAsFixed(1)} kg',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: const Duration(milliseconds: 500)),
          ),
        ],
      ),
    );
  }

  Widget _buildShareButton(Pokemon pokemon, Color primaryColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, primaryColor.withValues(alpha: 0.7)],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () async {
              final deepLink = 'https://poke-kou.vercel.app/pokemon/${pokemon.id}';
              await Clipboard.setData(ClipboardData(text: deepLink));
              
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        const Icon(Icons.check_circle, color: Colors.white),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Deep link copied to clipboard!',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    backgroundColor: const Color(0xFF6BCF7F),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.content_copy, color: Colors.white, size: 24),
                  const SizedBox(width: 12),
                  Text(
                    'Copy Deep Link',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ).animate().fadeIn(delay: const Duration(milliseconds: 600)),
    );
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'fire':
        return Icons.local_fire_department;
      case 'water':
        return Icons.water_drop;
      case 'grass':
        return Icons.grass;
      case 'electric':
        return Icons.bolt;
      case 'ice':
        return Icons.ac_unit;
      case 'fighting':
        return Icons.sports_martial_arts;
      case 'poison':
        return Icons.science;
      case 'ground':
        return Icons.terrain;
      case 'flying':
        return Icons.air;
      case 'psychic':
        return Icons.psychology;
      case 'bug':
        return Icons.bug_report;
      case 'rock':
        return Icons.landscape;
      case 'ghost':
        return Icons.visibility_off;
      case 'dragon':
        return Icons.pets;
      case 'dark':
        return Icons.dark_mode;
      case 'steel':
        return Icons.shield;
      case 'fairy':
        return Icons.auto_awesome;
      default:
        return Icons.circle;
    }
  }
}
