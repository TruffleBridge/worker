import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimora_worker/bloc/worker_bloc/onboarding/onboarding_bloc.dart';
import 'package:nimora_worker/core/utils/app_dependencies.dart';
import 'package:nimora_worker/domain/repositories/onboarding/onboarding_repository_impl.dart';
import 'package:nimora_worker/domain/use_cases/onboarding_usecases/onboarding_usecases.dart';
import 'package:nimora_worker/presentation/views/worker_views/onboarding/onboarding_view.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = OnboardingRepositoryImpl(
      sharedPreferences: AppDependencies.sharedPreferences,
    );

    return BlocProvider(
      create: (_) => OnboardingBloc(
        getOnboardingItemsUseCase:
        GetOnboardingItemsUseCase(repository),
        markOnboardingAsSeenUseCase:
        MarkOnboardingAsSeenUseCase(repository),
      )..add(const OnboardingStarted()),
      child: const OnboardingView(),
    );
  }
}
