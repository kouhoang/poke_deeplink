import 'package:equatable/equatable.dart';

/// Domain entity for Pokemon
class PokemonEntity extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final String? shinyImageUrl;
  final List<String> types;
  final int height;
  final int weight;
  final List<PokemonStatEntity> stats;
  final List<PokemonAbilityEntity> abilities;
  final int baseExperience;
  final String? genus;
  final String? description;

  const PokemonEntity({
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

  String get capitalizedName {
    return name.isNotEmpty ? name[0].toUpperCase() + name.substring(1) : '';
  }

  int get totalStats {
    return stats.fold(0, (sum, stat) => sum + stat.baseStat);
  }

  double get averageStats {
    return stats.isNotEmpty ? totalStats / stats.length : 0;
  }

  String get primaryType => types.isNotEmpty ? types.first : '';
  String? get secondaryType => types.length > 1 ? types[1] : null;

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        shinyImageUrl,
        types,
        height,
        weight,
        stats,
        abilities,
        baseExperience,
        genus,
        description,
      ];
}

/// Domain entity for Pokemon stat
class PokemonStatEntity extends Equatable {
  final String name;
  final int baseStat;
  final int effort;

  const PokemonStatEntity({
    required this.name,
    required this.baseStat,
    required this.effort,
  });

  String get displayName {
    return name
        .split('-')
        .map((word) => word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '')
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

  @override
  List<Object?> get props => [name, baseStat, effort];
}

/// Domain entity for Pokemon ability
class PokemonAbilityEntity extends Equatable {
  final String name;
  final bool isHidden;

  const PokemonAbilityEntity({
    required this.name,
    required this.isHidden,
  });

  String get displayName {
    return name
        .split('-')
        .map((word) => word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '')
        .join(' ');
  }

  @override
  List<Object?> get props => [name, isHidden];
}

/// Domain entity for Pokemon list item
class PokemonListItemEntity extends Equatable {
  final int id;
  final String name;
  final String imageUrl;

  const PokemonListItemEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  String get capitalizedName {
    return name.isNotEmpty ? name[0].toUpperCase() + name.substring(1) : '';
  }

  @override
  List<Object?> get props => [id, name, imageUrl];
}
