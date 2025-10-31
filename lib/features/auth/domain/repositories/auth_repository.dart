import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> login({
    required String email,
    required String password,
  });
}
