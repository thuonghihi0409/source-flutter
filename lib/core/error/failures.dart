import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure(super.message);
}

class InvalidCredentialsFailure extends Failure {
  const InvalidCredentialsFailure(super.message);
}

class SessionExpiredFailure extends Failure {
  const SessionExpiredFailure(super.message);
}

class PermissionFailure extends Failure {
  const PermissionFailure(super.message);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}

class PasswordFailure extends Failure {
  const PasswordFailure(super.message);
}

class EmployeeNotFoundFailure extends Failure {
  const EmployeeNotFoundFailure(super.message);
}

class EmployeePermissionFailure extends Failure {
  const EmployeePermissionFailure(super.message);
}
