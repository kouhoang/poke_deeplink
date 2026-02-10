import 'package:equatable/equatable.dart';

/// Base class for all failures in the application
abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure({
    required this.message,
    this.statusCode,
  });

  @override
  List<Object?> get props => [message, statusCode];
}

/// Failure for server-related errors
class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.statusCode,
  });
}

/// Failure for network-related errors (no internet, timeout, etc.)
class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
  });
}

/// Failure for cache-related errors
class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
  });
}

/// Failure for validation errors
class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
  });
}

/// Failure for unexpected errors
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({
    required super.message,
  });
}
