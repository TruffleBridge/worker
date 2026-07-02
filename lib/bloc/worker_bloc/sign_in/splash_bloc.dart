import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:nimora_worker/domain/use_cases/onboarding_usecases/onboarding_usecases.dart';
import 'package:nimora_worker/infrastructure/storage/token_storage/token_storage.dart';

import '../../../../core/utils/use_case.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class WorkerSplashBloc extends Bloc<WorkerSplashEvent, WorkerSplashState> {
  final HasSeenOnboardingUseCase _hasSeenOnboardingUseCase;
  final TokenStorage _tokenStorage;

  WorkerSplashBloc({
    required this._hasSeenOnboardingUseCase,
    required this._tokenStorage,
  })  : super(const WorkerSplashInitial()) {
    on<WorkerSplashStarted>(_onStarted);
  }

  Future<void> _onStarted(
      WorkerSplashStarted event,
    Emitter<WorkerSplashState> emit,
  ) async {
    emit(const WorkerSplashLoading());

    // Minimum splash duration for branding
    await Future.delayed(const Duration(seconds: 2));

    // ── Check if user is already logged in ──────────────────────────────────
    final token = await _tokenStorage.readToken();
    debugPrint('=== SPLASH: token from storage: $token');
    if (token != null && token.isNotEmpty) {
      debugPrint('=== SPLASH: navigating to HOME ✅');
      emit(const WorkerSplashNavigateToHome());
      return;
    }

    // ── No token → check if onboarding has been seen ────────────────────────
    final result = await _hasSeenOnboardingUseCase(NoParams());
    result.fold(
      (_) => emit(const WorkerSplashNavigateToOnboarding()),
      (hasSeen) {
        if (hasSeen) {
          emit(const WorkerSplashNavigateToLogin());
        } else {
          emit(const WorkerSplashNavigateToOnboarding());
        }
      },
    );
  }
}

