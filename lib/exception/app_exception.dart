abstract class AppException implements Exception {
  final String message;
  final String? code;

  const AppException({
    required this.message,
    this.code,
  });

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  const NetworkException({
    super.message = 'Network connection failed.',
    super.code,
  });
}

class AuthenticationException extends AppException {
  const AuthenticationException({
    required super.message,
    super.code,
  });
}

class NotFoundException extends AppException {
  const NotFoundException({
    required super.message,
    super.code,
  });
}

class NotDataFoundException extends AppException {
  const NotDataFoundException({
    required super.message,
    super.code,
  });
}