import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  const AuthRepositoryImpl({required this.remote});

  @override
  Future<Either<Failure, Unit>> login({
    required String email,
    required String password,
  }) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        return left(const ValidationFailure('Email và mật khẩu là bắt buộc'));
      }
      await remote.login(email: email, password: password);
      return right(unit);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
