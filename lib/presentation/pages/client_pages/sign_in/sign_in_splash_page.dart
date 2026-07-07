import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimora_worker/presentation/views/client_views/sign_in/sign_in_splash_view.dart';

import '../../../../bloc/client_bloc/login/login_bloc.dart';
import '../../../../bloc/worker_bloc/sign_in/splash_bloc.dart';
import '../../../../core/utils/app_dependencies.dart';
import '../../../../data/api/login/login_api_impl.dart';
import '../../../../domain/repositories/login/login_repository_impl.dart';
import '../../../../domain/repositories/onboarding/onboarding_repository_impl.dart';
import '../../../../domain/use_cases/onboarding_usecases/onboarding_usecases.dart';

class ClientSignInSplashPage extends StatelessWidget {
  const ClientSignInSplashPage({super.key});

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
          create: (_) => LoginBloc(
            loginRepository: loginRepository,
          )..add(ClientLoginOnLoadEvent()),
        ),
      ],
      child: const ClientSignInSplashView()
    );
  }
}