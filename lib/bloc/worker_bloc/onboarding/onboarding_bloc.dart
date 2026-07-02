import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nimora_worker/core/utils/use_case.dart';
import 'package:nimora_worker/domain/model/view_model/onboarding_item_model.dart';
import 'package:nimora_worker/domain/use_cases/onboarding_usecases/onboarding_usecases.dart';

part 'onboarding_event.dart';

part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final GetOnboardingItemsUseCase _getOnboardingItemsUseCase;
  final MarkOnboardingAsSeenUseCase _markOnboardingAsSeenUseCase;

  OnboardingBloc({
    required this._getOnboardingItemsUseCase,
    required this._markOnboardingAsSeenUseCase,
  }) : super(const OnboardingInitial()) {
    on<OnboardingStarted>(_onStarted);
    on<OnboardingPageChanged>(_onPageChanged);
    on<OnboardingNextPressed>(_onNextPressed);
    on<OnboardingSkipPressed>(_onSkipPressed);
    on<OnboardingGetStartedPressed>(_onGetStartedPressed);
  }

  Future<void> _onStarted(
    OnboardingStarted event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(const OnboardingLoading());
    final result = await _getOnboardingItemsUseCase(NoParams());
    result.fold(
      (failure) => emit(OnboardingError(message: failure.message)),
      (items) => emit(
        OnboardingLoaded(
          items: items,
          currentPage: 0,
          isLastPage: items.length == 1,
        ),
      ),
    );
  }

  void _onPageChanged(
    OnboardingPageChanged event,
    Emitter<OnboardingState> emit,
  ) {
    final current = state;
    if (current is OnboardingLoaded) {
      emit(
        current.copyWith(
          currentPage: event.pageIndex,
          isLastPage: event.pageIndex == current.items.length - 1,
        ),
      );
    }
  }

  void _onNextPressed(
    OnboardingNextPressed event,
    Emitter<OnboardingState> emit,
  ) {
    final current = state;
    if (current is OnboardingLoaded && !current.isLastPage) {
      final nextPage = current.currentPage + 1;
      emit(
        current.copyWith(
          currentPage: nextPage,
          isLastPage: nextPage == current.items.length - 1,
        ),
      );
    }
  }

  // Future<void> _onSkipPressed(
  //   OnboardingSkipPressed event,
  //   Emitter<OnboardingState> emit,
  // ) async {
  //   await _markOnboardingAsSeenUseCase(NoParams());
  //   emit(const OnboardingCompleted());
  // }
  //
  // Future<void> _onGetStartedPressed(
  //   OnboardingGetStartedPressed event,
  //   Emitter<OnboardingState> emit,
  // ) async {
  //   await _markOnboardingAsSeenUseCase(NoParams());
  //   emit(const OnboardingCompleted());
  // }
  Future<void> _onSkipPressed(
      OnboardingSkipPressed event,
      Emitter<OnboardingState> emit,
      ) async {
    final result = await _markOnboardingAsSeenUseCase(NoParams());

    result.fold(
          (failure) => emit(OnboardingError(message: failure.message)),
          (_) => emit(const OnboardingCompleted()),
    );
  }

  Future<void> _onGetStartedPressed(
      OnboardingGetStartedPressed event,
      Emitter<OnboardingState> emit,
      ) async {
    final result = await _markOnboardingAsSeenUseCase(NoParams());

    result.fold(
          (failure) => emit(OnboardingError(message: failure.message)),
          (_) => emit(const OnboardingCompleted()),
    );
  }
}
