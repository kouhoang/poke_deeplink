/// Centralized string constants for localization
/// This is a simple approach. For full i18n, consider using flutter_localizations
class AppStrings {
  AppStrings._();

  // App
  static const String appName = 'Pokédex';

  // Common
  static const String loading = 'Loading...';
  static const String error = 'Error';
  static const String retry = 'Retry';
  static const String back = 'Back';
  static const String next = 'Next';
  static const String previous = 'Previous';

  // Pokemon List Screen
  static const String pokedex = 'Pokédex';
  static const String pokemon = 'Pokémon';
  static const String loadingPokedex = 'Loading Pokédex...';
  static const String pokemonCount = 'Pokémon';
  static const String page = 'Page';
  static const String errorLoadingPokemon = 'Error loading Pokémon';
  static const String loadingPage = 'Loading page';

  // Pokemon Detail Screen
  static const String loadingPokemonDetail = 'Loading Pokémon...';
  static const String errorLoadingPokemonDetail = 'Error loading Pokémon';
  static const String abilities = 'Abilities';
  static const String baseStats = 'Base Stats';
  static const String height = 'Height';
  static const String weight = 'Weight';
  static const String baseExperience = 'Base EXP';
  static const String total = 'Total';
  static const String average = 'Average';
  static const String shareDeepLink = 'Share Deep Link';
  static const String deepLinkCopied = 'Deep link copied to clipboard!';
  static const String shinyVersion = 'Shiny Version';

  // Stats
  static const String hp = 'HP';
  static const String attack = 'ATK';
  static const String defense = 'DEF';
  static const String specialAttack = 'SP.ATK';
  static const String specialDefense = 'SP.DEF';
  static const String speed = 'SPD';

  // Pokemon Types
  static const String typeNormal = 'NORMAL';
  static const String typeFire = 'FIRE';
  static const String typeWater = 'WATER';
  static const String typeElectric = 'ELECTRIC';
  static const String typeGrass = 'GRASS';
  static const String typeIce = 'ICE';
  static const String typeFighting = 'FIGHTING';
  static const String typePoison = 'POISON';
  static const String typeGround = 'GROUND';
  static const String typeFlying = 'FLYING';
  static const String typePsychic = 'PSYCHIC';
  static const String typeBug = 'BUG';
  static const String typeRock = 'ROCK';
  static const String typeGhost = 'GHOST';
  static const String typeDragon = 'DRAGON';
  static const String typeDark = 'DARK';
  static const String typeSteel = 'STEEL';
  static const String typeFairy = 'FAIRY';

  // Helper method to get localized type name
  static String getTypeName(String type) {
    final typeMap = {
      'normal': typeNormal,
      'fire': typeFire,
      'water': typeWater,
      'electric': typeElectric,
      'grass': typeGrass,
      'ice': typeIce,
      'fighting': typeFighting,
      'poison': typePoison,
      'ground': typeGround,
      'flying': typeFlying,
      'psychic': typePsychic,
      'bug': typeBug,
      'rock': typeRock,
      'ghost': typeGhost,
      'dragon': typeDragon,
      'dark': typeDark,
      'steel': typeSteel,
      'fairy': typeFairy,
    };
    return typeMap[type.toLowerCase()] ?? type.toUpperCase();
  }
}
