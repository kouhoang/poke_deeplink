import '../../domain/entities/pokemon_entity.dart';

/// Data model for Pokemon (extends entity)
class PokemonModel extends PokemonEntity {
  const PokemonModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    super.shinyImageUrl,
    required super.types,
    required super.height,
    required super.weight,
    required super.stats,
    required super.abilities,
    required super.baseExperience,
    super.genus,
    super.description,
  });

  /// Creates PokemonModel from JSON
  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: _extractImageUrl(json),
      shinyImageUrl: _extractShinyImageUrl(json),
      types: _extractTypes(json),
      height: json['height'] as int,
      weight: json['weight'] as int,
      stats: _extractStats(json),
      abilities: _extractAbilities(json),
      baseExperience: json['base_experience'] as int? ?? 0,
      genus: null, // Will be populated from species endpoint
      description: null, // Will be populated from species endpoint
    );
  }

  /// Converts model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'shinyImageUrl': shinyImageUrl,
      'types': types,
      'height': height,
      'weight': weight,
      'stats': stats.map((s) => (s as PokemonStatModel).toJson()).toList(),
      'abilities': abilities
          .map((a) => (a as PokemonAbilityModel).toJson())
          .toList(),
      'base_experience': baseExperience,
      'genus': genus,
      'description': description,
    };
  }

  static String _extractImageUrl(Map<String, dynamic> json) {
    try {
      return json['sprites']?['other']?['official-artwork']?['front_default']
              as String? ??
          json['sprites']?['front_default'] as String? ??
          '';
    } catch (e) {
      return '';
    }
  }

  static String? _extractShinyImageUrl(Map<String, dynamic> json) {
    try {
      return json['sprites']?['other']?['official-artwork']?['front_shiny']
          as String?;
    } catch (e) {
      return null;
    }
  }

  static List<String> _extractTypes(Map<String, dynamic> json) {
    try {
      final types = json['types'] as List<dynamic>?;
      if (types == null) return [];
      return types
          .map((type) => type['type']?['name'] as String?)
          .where((name) => name != null)
          .cast<String>()
          .toList();
    } catch (e) {
      return [];
    }
  }

  static List<PokemonStatEntity> _extractStats(Map<String, dynamic> json) {
    try {
      final stats = json['stats'] as List<dynamic>?;
      if (stats == null) return [];
      return stats
          .map(
            (stat) => PokemonStatModel.fromJson(stat as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      return [];
    }
  }

  static List<PokemonAbilityEntity> _extractAbilities(
    Map<String, dynamic> json,
  ) {
    try {
      final abilities = json['abilities'] as List<dynamic>?;
      if (abilities == null) return [];
      return abilities
          .map(
            (ability) =>
                PokemonAbilityModel.fromJson(ability as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Creates a copy with updated fields
  PokemonModel copyWith({
    int? id,
    String? name,
    String? imageUrl,
    String? shinyImageUrl,
    List<String>? types,
    int? height,
    int? weight,
    List<PokemonStatEntity>? stats,
    List<PokemonAbilityEntity>? abilities,
    int? baseExperience,
    String? genus,
    String? description,
  }) {
    return PokemonModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      shinyImageUrl: shinyImageUrl ?? this.shinyImageUrl,
      types: types ?? this.types,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      stats: stats ?? this.stats,
      abilities: abilities ?? this.abilities,
      baseExperience: baseExperience ?? this.baseExperience,
      genus: genus ?? this.genus,
      description: description ?? this.description,
    );
  }
}

/// Data model for Pokemon stat
class PokemonStatModel extends PokemonStatEntity {
  const PokemonStatModel({
    required super.name,
    required super.baseStat,
    required super.effort,
  });

  factory PokemonStatModel.fromJson(Map<String, dynamic> json) {
    return PokemonStatModel(
      name: json['stat']?['name'] as String? ?? '',
      baseStat: json['base_stat'] as int? ?? 0,
      effort: json['effort'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stat': {'name': name},
      'base_stat': baseStat,
      'effort': effort,
    };
  }
}

/// Data model for Pokemon ability
class PokemonAbilityModel extends PokemonAbilityEntity {
  const PokemonAbilityModel({required super.name, required super.isHidden});

  factory PokemonAbilityModel.fromJson(Map<String, dynamic> json) {
    return PokemonAbilityModel(
      name: json['ability']?['name'] as String? ?? '',
      isHidden: json['is_hidden'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ability': {'name': name},
      'is_hidden': isHidden,
    };
  }
}

/// Data model for Pokemon list item
class PokemonListItemModel extends PokemonListItemEntity {
  const PokemonListItemModel({
    required super.id,
    required super.name,
    required super.imageUrl,
  });

  factory PokemonListItemModel.fromJson(Map<String, dynamic> json) {
    final url = json['url'] as String? ?? '';
    final id = _extractIdFromUrl(url);

    return PokemonListItemModel(
      id: id,
      name: json['name'] as String? ?? '',
      imageUrl: _generateImageUrl(id),
    );
  }

  static int _extractIdFromUrl(String url) {
    try {
      final parts = url.split('/');
      final idString = parts[parts.length - 2];
      return int.parse(idString);
    } catch (e) {
      return 0;
    }
  }

  static String _generateImageUrl(int id) {
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'url': 'https://pokeapi.co/api/v2/pokemon/$id/'};
  }
}
