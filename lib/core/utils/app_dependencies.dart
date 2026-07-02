import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nimora_worker/core/constants/app_constants.dart';
import 'package:nimora_worker/core/utils/auth_interceptor.dart';
import 'package:nimora_worker/infrastructure/storage/token_storage/token_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDependencies {
  static late SharedPreferences sharedPreferences;
  static late FlutterSecureStorage secureStorage;
  static late TokenStorage tokenStorage;
  static late Dio dio;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();

    secureStorage = const FlutterSecureStorage();

    tokenStorage = TokenStorage(
      secureStorage,
    );

    dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Auth Token Interceptor
    dio.interceptors.add(
      AuthInterceptor(tokenStorage),
    );

    // API Logger
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
          compact: true,
          maxWidth: 120,
        ),
      );
    }
  }
}