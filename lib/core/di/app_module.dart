// import 'package:dio/dio.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:nimora_worker/core/utils/injection_container.dart';
// import 'package:nimora_worker/infrastructure/storage/token_storage/auth_repository.dart';
// import 'package:nimora_worker/infrastructure/storage/token_storage/dio_client.dart';
// import 'package:nimora_worker/infrastructure/storage/token_storage/token_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// Future<void> registerAppModule() async {
//   final sharedPreferences = await SharedPreferences.getInstance();
//
//   sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
//
//   // ── Secure storage & token ────────────────────────────────────────────────
//   sl.registerLazySingleton<FlutterSecureStorage>(
//         () => const FlutterSecureStorage(),
//   );
//
//   sl.registerLazySingleton<TokenStorage>(
//         () => TokenStorage(sl<FlutterSecureStorage>()),
//   );
//
//   // ── Dio (with auth interceptor pre-attached) ─────────────────────────────
//   sl.registerLazySingleton<AuthInterceptor>(
//         () => AuthInterceptor(sl<TokenStorage>()),
//   );
//
//   sl.registerLazySingleton<Dio>(
//         () => createDio(sl<AuthInterceptor>()),
//   );
// }