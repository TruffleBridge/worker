// // import 'package:dio/dio.dart';
// // import 'package:nimora_worker/bloc/login/login_bloc.dart';
// // import 'package:nimora_worker/core/utils/injection_container.dart';
// // import 'package:nimora_worker/domain/use_cases/auth_use_cases/auth_use_cases.dart';
// // import 'package:nimora_worker/infrastructure/storage/token_storage/token_storage.dart';
// //
// //
// // Future<void> registerAuthModule() async {
// //   // Data Sources
// //   sl.registerLazySingleton<AuthRemoteDataSource>(
// //         () => AuthRemoteDataSourceImpl(
// //       dio: sl<Dio>(),
// //       tokenStorage: sl<TokenStorage>(),
// //     ),
// //   );
// //
// //   sl.registerLazySingleton<AuthLocalDataSource>(
// //         () => AuthLocalDataSourceImpl(
// //       sharedPreferences: sl(),
// //     ),
// //   );
// //
// //   // Repository
// //   sl.registerLazySingleton<AuthRepository>(
// //         () => AuthRepositoryImpl(
// //       remoteDataSource: sl(),
// //       localDataSource: sl(),
// //       tokenStorage: sl(),
// //     ),
// //   );
// //
// //   // Use Cases
// //   sl.registerLazySingleton<SignInUseCase>(
// //         () => SignInUseCase(sl()),
// //   );
// //
// //   sl.registerLazySingleton<SignInWithGoogleUseCase>(
// //         () => SignInWithGoogleUseCase(sl()),
// //   );
// //
// //   sl.registerLazySingleton<SignInWithFacebookUseCase>(
// //         () => SignInWithFacebookUseCase(sl()),
// //   );
// //
// //   // sl.registerLazySingleton<RegisterUseCase>(
// //   //       () => RegisterUseCase(sl()),
// //   // );
// //
// //   sl.registerLazySingleton<ForgotPasswordUseCase>(
// //         () => ForgotPasswordUseCase(sl()),
// //   );
// //
// //   sl.registerLazySingleton<ResetPasswordUseCase>(
// //         () => ResetPasswordUseCase(sl()),
// //   );
// //
// //   sl.registerLazySingleton<SignOutUseCase>(
// //         () => SignOutUseCase(sl()),
// //   );
// //
// //   // Blocs
// //   sl.registerFactory<LoginBloc>(
// //         () => LoginBloc(
// //       signInUseCase: sl(),
// //       signInWithGoogleUseCase: sl(),
// //       signInWithFacebookUseCase: sl(),
// //     ),
// //   );
// //
// //   // sl.registerFactory<RegisterBloc>(
// //   //       () => RegisterBloc(
// //   //     registerUseCase: sl(),
// //   //   ),
// //   // );
// //   //
// //   // sl.registerFactory<ForgotPasswordBloc>(
// //   //       () => ForgotPasswordBloc(
// //   //     forgotPasswordUseCase: sl(),
// //   //   ),
// //   // );
// //   //
// //   // sl.registerFactory<DefinePasswordBloc>(
// //   //       () => DefinePasswordBloc(
// //   //     resetPasswordUseCase: sl(),
// //   //   ),
// //   // );
// // }
//
// import 'package:dio/dio.dart';
// import 'package:nimora_worker/bloc/login/login_bloc.dart';
// import 'package:nimora_worker/core/utils/injection_container.dart';
// import 'package:nimora_worker/domain/repositories/auth/auth_repository.dart';
// import 'package:nimora_worker/domain/use_cases/auth_use_cases/auth_use_cases.dart';
// import 'package:nimora_worker/infrastructure/storage/token_storage/token_storage.dart';
//
// Future<void> registerAuthModule() async {
//   sl.registerLazySingleton<AuthRemoteDataSource>(
//         () => AuthRemoteDataSourceImpl(
//       dio: sl<Dio>(),
//       tokenStorage: sl<TokenStorage>(),
//     ),
//   );
//
//   sl.registerLazySingleton<AuthRepository>(
//         () => AuthRepositoryImpl(
//       remoteDataSource: sl<AuthRemoteDataSource>(),
//       tokenStorage: sl<TokenStorage>(),
//     ),
//   );
//
//   sl.registerLazySingleton<SignInUseCase>(
//         () => SignInUseCase(
//       sl<AuthRepository>(),
//     ),
//   );
//
//   sl.registerFactory<LoginBloc>(
//         () => LoginBloc(
//       signInUseCase: sl<SignInUseCase>(),
//     ),
//   );
// }