import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';

/// Base class for all use cases
/// T is the return type, Params is the input parameters type
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// Use case with no parameters
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
