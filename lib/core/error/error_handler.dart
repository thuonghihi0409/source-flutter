import '../error/exceptions.dart';
import '../error/failures.dart';

class ErrorHandler {
  static Failure mapExceptionToFailure(Exception exception) {
    if (exception is ServerException) {
      return ServerFailure(exception.message);
    } else if (exception is NetworkException) {
      return NetworkFailure(exception.message);
    } else if (exception is CacheException) {
      return CacheFailure(exception.message);
    } else if (exception is UnauthorizedException) {
      return SessionExpiredFailure(exception.message);
    } else if (exception is RefreshTokenExpiredException) {
      return SessionExpiredFailure(exception.message);
    } else if (exception is AuthenticationException) {
      return AuthenticationFailure(exception.message);
    } else if (exception is InvalidCredentialsException) {
      return InvalidCredentialsFailure(exception.message);
    } else if (exception is SessionExpiredException) {
      return SessionExpiredFailure(exception.message);
    } else if (exception is ValidationException) {
      return ValidationFailure(exception.message);
    } else if (exception is PermissionException) {
      return PermissionFailure(exception.message);
    } else if (exception is NotFoundException) {
      return NotFoundFailure(exception.message);
    } else if (exception is PasswordException) {
      return PasswordFailure(exception.message);
    } else if (exception is EmployeeNotFoundException) {
      return EmployeeNotFoundFailure(exception.message);
    } else if (exception is EmployeePermissionException) {
      return EmployeePermissionFailure(exception.message);
    } else {
      return ServerFailure(
        'An unexpected error occurred: ${exception.toString()}',
      );
    }
  }

  static String getErrorMessage(Failure failure) {
    final message = failure.message;

    // Handle specific network errors
    if (message.contains('Failed host lookup')) {
      return 'Không thể kết nối đến server. Vui lòng kiểm tra tên công ty và thử lại';
    } else if (message.contains('Connection timed out')) {
      return 'Kết nối bị timeout. Vui lòng thử lại';
    } else if (message.contains('No internet connection')) {
      return 'Không có kết nối internet. Vui lòng kiểm tra mạng';
    } else if (message.contains('Domain is required')) {
      return 'Tên công ty là bắt buộc';
    }

    return message;
  }

  static String getErrorMessageFromException(Exception exception) {
    final failure = mapExceptionToFailure(exception);
    return getErrorMessage(failure);
  }
}
