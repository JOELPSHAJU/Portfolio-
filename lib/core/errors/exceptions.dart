/// Base exception interface for the application.
abstract class AppException implements Exception {
  final String message;
  final String? code;

  const AppException({required this.message, this.code});

  @override
  String toString() => '$runtimeType: $message${code != null ? ' (Code: $code)' : ''}';
}

/// Thrown when a remote server request fails.
class ServerException extends AppException {
  const ServerException({
    required super.message,
    super.code,
  });
}

/// Thrown when local cache read/write operations fail.
class CacheException extends AppException {
  const CacheException({
    required super.message,
    super.code,
  });
}

/// Thrown when validation of data or user inputs fails.
class ValidationException extends AppException {
  const ValidationException({
    required super.message,
    super.code,
  });
}
