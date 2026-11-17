abstract class AppException implements Exception {
  final String message;
  final dynamic cause;

  const AppException(this.message, [this.cause]);

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  const NetworkException(super.message, [super.cause]);
}

class ValidationException extends AppException {
  const ValidationException(super.message, [super.cause]);
}

class ServerException extends AppException {
  final int? statusCode;

  const ServerException(super.message, [super.cause, this.statusCode]);
}
