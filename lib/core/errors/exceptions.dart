/// Base exception class
class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() => 'AppException: $message (Status: $statusCode)';
}

/// Exception for server errors
class ServerException extends AppException {
  const ServerException({
    required super.message,
    super.statusCode,
  });

  @override
  String toString() => 'ServerException: $message (Status: $statusCode)';
}

/// Exception for network errors
class NetworkException extends AppException {
  const NetworkException({
    required super.message,
  });

  @override
  String toString() => 'NetworkException: $message';
}

/// Exception for cache errors
class CacheException extends AppException {
  const CacheException({
    required super.message,
  });

  @override
  String toString() => 'CacheException: $message';
}

/// Exception for parsing errors
class ParsingException extends AppException {
  const ParsingException({
    required super.message,
  });

  @override
  String toString() => 'ParsingException: $message';
}
