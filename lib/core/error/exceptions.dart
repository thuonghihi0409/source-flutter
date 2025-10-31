class ServerException implements Exception {
  final String message;
  final int? statusCode;

  const ServerException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;

  const NetworkException(this.message);

  @override
  String toString() => message;
}

class CacheException implements Exception {
  final String message;

  const CacheException(this.message);

  @override
  String toString() => message;
}

class UnauthorizedException implements Exception {
  final String message;

  const UnauthorizedException(this.message);

  @override
  String toString() => message;
}

class RefreshTokenExpiredException implements Exception {
  final String message;

  const RefreshTokenExpiredException([
    this.message = 'Refresh token has expired. Please login again.',
  ]);

  @override
  String toString() => message;
}

class AuthenticationException implements Exception {
  final String message;

  const AuthenticationException(this.message);

  @override
  String toString() => message;
}

class InvalidCredentialsException implements Exception {
  final String message;

  const InvalidCredentialsException(this.message);

  @override
  String toString() => message;
}

class SessionExpiredException implements Exception {
  final String message;

  const SessionExpiredException(this.message);

  @override
  String toString() => message;
}

class ValidationException implements Exception {
  final String message;

  const ValidationException(this.message);

  @override
  String toString() => message;
}

class PermissionException implements Exception {
  final String message;

  const PermissionException(this.message);

  @override
  String toString() => message;
}

class NotFoundException implements Exception {
  final String message;

  const NotFoundException(this.message);

  @override
  String toString() => message;
}

class PasswordException implements Exception {
  final String message;

  const PasswordException(this.message);

  @override
  String toString() => message;
}

class EmployeeNotFoundException implements Exception {
  final String message;

  const EmployeeNotFoundException(this.message);

  @override
  String toString() => message;
}

class EmployeePermissionException implements Exception {
  final String message;

  const EmployeePermissionException(this.message);

  @override
  String toString() => message;
}
