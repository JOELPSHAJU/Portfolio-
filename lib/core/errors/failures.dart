/// Base class for all failures that are returned in the Domain layer instead of throwing exceptions.
abstract class Failure {
  final String message;
  final String? code;

  const Failure({required this.message, this.code});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          code == other.code;

  @override
  int get hashCode => message.hashCode ^ code.hashCode;

  @override
  String toString() => '$runtimeType: $message';
}

/// Returned when a ServerException occurs.
class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.code});
}

/// Returned when a CacheException occurs.
class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.code});
}

/// Returned when a validation error occurs.
class ValidationFailure extends Failure {
  const ValidationFailure({required super.message, super.code});
}

/// General fallback failure.
class UnknownFailure extends Failure {
  const UnknownFailure({required super.message, super.code});
}
