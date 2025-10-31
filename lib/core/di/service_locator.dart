import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Global State Management (kept for future use)

import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/datasources/auth_remote_data_source_impl.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
// Theme
import '../providers/theme_provider.dart';
// Routing
import '../routing/app_router.dart';
import '../services/flexible_http_service.dart';
// Services
import '../services/http_service.dart';
import '../services/language_service.dart';
import '../services/theme_service.dart';
import '../services/token_manager.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  // External dependencies
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio();
    dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true, error: true),
    );
    return dio;
  });

  // SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Services
  sl.registerLazySingleton<TokenManager>(
    () => TokenManager(prefs: sharedPreferences),
  );
  sl.registerLazySingleton<LanguageService>(() => LanguageService(prefs: sl()));

  // Theme services
  sl.registerLazySingleton<ThemeService>(() => ThemeService());
  sl.registerLazySingleton<ThemeProvider>(() => ThemeProvider());

  // Core HTTP services
  sl.registerLazySingleton<HttpService>(() => HttpService(tokenManager: sl()));
  sl.registerLazySingleton<FlexibleHttpService>(
    () => FlexibleHttpService(tokenManager: sl()),
  );

  // Set refresh/unauthorized callbacks to a minimal redirect
  sl<HttpService>().onRefreshToken = () async {
    await sl<TokenManager>().clearTokens();
    await sl<SharedPreferences>().remove('user_role');
    navigateToLogin();
  };

  // Set unauthorized callback to handle when refresh token is expired
  sl<HttpService>().onUnauthorized = () async {
    await sl<TokenManager>().clearTokens();
    await sl<SharedPreferences>().remove('user_role');
    navigateToLogin();
  };

  // Auth (minimal template)
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(httpService: sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remote: sl()),
  );
}
