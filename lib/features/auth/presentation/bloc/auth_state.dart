part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? error;

  const AuthState({
    required this.isLoading,
    required this.isSuccess,
    this.error,
  });

  const AuthState.initial() : this(isLoading: false, isSuccess: false);
  const AuthState.loading() : this(isLoading: true, isSuccess: false);
  const AuthState.success() : this(isLoading: false, isSuccess: true);
  factory AuthState.failure(String message) =>
      AuthState(isLoading: false, isSuccess: false, error: message);

  @override
  List<Object?> get props => [isLoading, isSuccess, error];
}
