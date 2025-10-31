import '../../../../core/services/http_service.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final HttpService httpService;
  const AuthRemoteDataSourceImpl({required this.httpService});

  @override
  Future<void> login({required String email, required String password}) async {
    // Template: simulate a successful login without calling a backend.
    await Future.delayed(const Duration(milliseconds: 500));
    // If you have an API, replace with:
    // await httpService.post('/auth/login', data: {'email': email, 'password': password});
  }
}
