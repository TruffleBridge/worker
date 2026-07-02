import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:nimora_worker/domain/use_cases/onboarding_usecases/onboarding_usecases.dart';
import 'package:nimora_worker/infrastructure/storage/token_storage/token_storage.dart';

import '../../../../core/utils/use_case.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class ClientSplashBloc extends Bloc<ClientSplashEvent, ClientSplashState> {
  final HasSeenOnboardingUseCase hasSeenOnboardingUseCase;
  final TokenStorage tokenStorage;

  ClientSplashBloc({
    required this.hasSeenOnboardingUseCase,
    required this.tokenStorage,
  })  : super(const ClientSplashInitial()) {
    on<ClientSplashStarted>(_onStarted);
  }

  Future<void> _onStarted(
      ClientSplashStarted event,
      Emitter<ClientSplashState> emit,
      ) async {
    emit(const ClientSplashLoading());

    // Minimum splash duration for branding
    await Future.delayed(const Duration(seconds: 2));

    // ── Check if user is already logged in ──────────────────────────────────
    final token = await tokenStorage.readToken();
    debugPrint('=== SPLASH: token from storage: $token');
    if (token != null && token.isNotEmpty) {
      debugPrint('=== SPLASH: navigating to HOME ✅');
      emit(const ClientSplashNavigateToHome());
      return;
    }

    // ── No token → check if onboarding has been seen ────────────────────────
    final result = await hasSeenOnboardingUseCase(NoParams());
    result.fold(
          (_) => emit(const ClientSplashNavigateToOnboarding()),
          (hasSeen) {
        if (hasSeen) {
          emit(const ClientSplashNavigateToLogin());
        } else {
          emit(const ClientSplashNavigateToOnboarding());
        }
      },
    );
  }
}

