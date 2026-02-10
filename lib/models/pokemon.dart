class Pokemon {
  final int id;
  final String name;
  final String imageUrl;
  final String? shinyImageUrl;
  final List<String> types;
  final int height;
  final int weight;
  final List<PokemonStat> stats;
  final List<PokemonAbility> abilities;
  final int baseExperience;
  final String? genus;
  final String? description;

  Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.shinyImageUrl,
    required this.types,
    required this.height,
    required this.weight,
    required this.stats,
    required this.abilities,
    required this.baseExperience,
    this.genus,
    this.description,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      imageUrl: json['sprites']['other']['official-artwork']['front_default'] ??
          json['sprites']['front_default'] ??
          '',
      shinyImageUrl: json['sprites']['other']['official-artwork']['front_shiny'],
      types: (json['types'] as List)
          .map((type) => type['type']['name'] as String)
          .toList(),
      height: json['height'],
      weight: json['weight'],
      stats: (json['stats'] as List)
          .map((stat) => PokemonStat.fromJson(stat))
          .toList(),
      abilities: (json['abilities'] as List)
          .map((ability) => PokemonAbility.fromJson(ability))
          .toList(),
      baseExperience: json['base_experience'] ?? 0,
    );
  }

  String get capitalizedName {
    return name[0].toUpperCase() + name.substring(1);
  }

  int get totalStats {
    return stats.fold(0, (sum, stat) => sum + stat.baseStat);
  }

  double get averageStats {
    return totalStats / stats.length;
  }

  String get primaryType => types.first;
  String? get secondaryType => types.length > 1 ? types[1] : null;
}

class PokemonStat {
  final String name;
  final int baseStat;
  final int effort;

  PokemonStat({
    required this.name,
    required this.baseStat,
    required this.effort,
  });

  factory PokemonStat.fromJson(Map<String, dynamic> json) {
    return PokemonStat(
      name: json['stat']['name'],
      baseStat: json['base_stat'],
      effort: json['effort'] ?? 0,
    );
  }

  String get displayName {
    return name
        .split('-')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  String get shortName {
    switch (name) {
      case 'hp':
        return 'HP';
      case 'attack':
        return 'ATK';
      case 'defense':
        return 'DEF';
      case 'special-attack':
        return 'SP.ATK';
      case 'special-defense':
        return 'SP.DEF';
      case 'speed':
        return 'SPD';
      default:
        return displayName;
    }
  }
}

class PokemonAbility {
  final String name;
  final bool isHidden;

  PokemonAbility({
    required this.name,
    required this.isHidden,
  });

  factory PokemonAbility.fromJson(Map<String, dynamic> json) {
    return PokemonAbility(
      name: json['ability']['name'],
      isHidden: json['is_hidden'] ?? false,
    );
  }

  String get displayName {
    return name
        .split('-')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}

class PokemonListItem {
  final String name;
  final String url;

  PokemonListItem({
    required this.name,
    required this.url,
  });

  factory PokemonListItem.fromJson(Map<String, dynamic> json) {
    return PokemonListItem(
      name: json['name'],
      url: json['url'],
    );
  }

  int get id {
    final parts = url.split('/');
    return int.parse(parts[parts.length - 2]);
  }

  String get imageUrl {
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
  }

  String get capitalizedName {
    return name[0].toUpperCase() + name.substring(1);
  }
}
