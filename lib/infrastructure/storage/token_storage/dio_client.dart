import 'package:dio/dio.dart';
import 'package:nimora_worker/core/constants/app_constants.dart';
import 'package:nimora_worker/infrastructure/storage/token_storage/auth_repository.dart';


/// Creates and returns the singleton [Dio] instance used by all data sources.
///
/// Configured with:
/// - Base URL from [AppConstants.baseUrl]
/// - JSON content-type header
/// - [AuthInterceptor] — automatically attaches `Authorization: Bearer <token>`
Dio createDio(AuthInterceptor authInterceptor) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout:
      const Duration(milliseconds: AppConstants.connectTimeoutMs),
      receiveTimeout:
      const Duration(milliseconds: AppConstants.receiveTimeoutMs),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  dio.interceptors.add(authInterceptor);

  return dio;
}
