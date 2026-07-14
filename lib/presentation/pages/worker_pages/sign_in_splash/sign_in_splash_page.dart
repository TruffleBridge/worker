import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimora_worker/bloc/worker_bloc/login/login_bloc.dart';
import 'package:nimora_worker/bloc/worker_bloc/sign_in/splash_bloc.dart';
import 'package:nimora_worker/core/utils/app_dependencies.dart';
import 'package:nimora_worker/data/api/login/login_api_impl.dart';
import 'package:nimora_worker/domain/repositories/login/login_repository_impl.dart';
import 'package:nimora_worker/domain/repositories/onboarding/onboarding_repository_impl.dart';
import 'package:nimora_worker/domain/use_cases/onboarding_usecases/onboarding_usecases.dart';
import 'package:nimora_worker/presentation/views/worker_views/sign_in_splash/sign_in_splash_view.dart';

class WorkerSignInSplashPage extends StatelessWidget {
  const WorkerSignInSplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final onboardingRepository = OnboardingRepositoryImpl(
      sharedPreferences: AppDependencies.sharedPreferences,
    );

    final loginApi = LoginApiImpl(
      dio: AppDependencies.dio,
      tokenStorage: AppDependencies.tokenStorage,
    );

    final loginRepository = LoginRepositoryImpl(
      loginApi: loginApi,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => WorkerSplashBloc(
            hasSeenOnboardingUseCase: HasSeenOnboardingUseCase(
              onboardingRepository,
            ),
            tokenStorage: AppDependencies.tokenStorage,
          )..add(WorkerSplashStarted()),
        ),
        BlocProvider(
          create: (_) => WorkerLoginBloc(
            loginRepository: loginRepository,
            tokenStorage: AppDependencies.tokenStorage,
          )..add(LoginOnLoadEvent()),
        ),
      ],
      child: const WorkerSignInSplashView(),
    );
  }
}