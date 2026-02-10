class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://pokeapi.co/api/v2';
  static const String pokemonEndpoint = '/pokemon';
  static const String speciesEndpoint = '/pokemon-species';
  
  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration retryDelay = Duration(seconds: 2);
  
  // Pagination
  static const int defaultLimit = 151;
  static const int itemsPerPage = 20;
}

class AppConstants {
  AppConstants._();
  
  static const String appName = 'Pokédex';
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 2);
}
