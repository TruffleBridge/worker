//
// import 'package:nimora_worker/bloc/onboarding/onboarding_bloc.dart';
// import 'package:nimora_worker/core/utils/injection_container.dart';
// import 'package:nimora_worker/domain/repositories/onboarding/onboarding_repository.dart';
// import 'package:nimora_worker/domain/repositories/onboarding/onboarding_repository_impl.dart';
// import 'package:nimora_worker/domain/use_cases/onboarding_usecases/onboarding_usecases.dart';
//
// Future<void> registerOnboardingModule() async {
//   sl.registerLazySingleton<OnboardingRepository>(
//         () => OnboardingRepositoryImpl(
//       sharedPreferences: sl(),
//     ),
//   );
//
//   sl.registerLazySingleton<GetOnboardingItemsUseCase>(
//         () => GetOnboardingItemsUseCase(sl()),
//   );
//
//   sl.registerLazySingleton<HasSeenOnboardingUseCase>(
//         () => HasSeenOnboardingUseCase(sl()),
//   );
//
//   sl.registerLazySingleton<MarkOnboardingAsSeenUseCase>(
//         () => MarkOnboardingAsSeenUseCase(sl()),
//   );
//
//   // sl.registerFactory<SplashBloc>(
//   //       () => SplashBloc(
//   //     hasSeenOnboardingUseCase: sl(),
//   //     tokenStorage: sl<TokenStorage>(),
//   //   ),
//   // );
//
//   sl.registerFactory<OnboardingBloc>(
//         () => OnboardingBloc(
//       getOnboardingItemsUseCase: sl(),
//       markOnboardingAsSeenUseCase: sl(),
//     ),
//   );
// }