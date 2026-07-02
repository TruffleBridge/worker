part of 'onboarding_bloc.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

class OnboardingInitial extends OnboardingState {
  const OnboardingInitial();
}

class OnboardingLoading extends OnboardingState {
  const OnboardingLoading();
}

class OnboardingLoaded extends OnboardingState {
  final List<OnboardingItem> items;
  final int currentPage;
  final bool isLastPage;

  const OnboardingLoaded({
    required this.items,
    required this.currentPage,
    required this.isLastPage,
  });

  OnboardingLoaded copyWith({
    List<OnboardingItem>? items,
    int? currentPage,
    bool? isLastPage,
  }) {
    return OnboardingLoaded(
      items: items ?? this.items,
      currentPage: currentPage ?? this.currentPage,
      isLastPage: isLastPage ?? this.isLastPage,
    );
  }

  @override
  List<Object?> get props => [items, currentPage, isLastPage];
}

class OnboardingError extends OnboardingState {
  final String message;
  const OnboardingError({required this.message});

  @override
  List<Object?> get props => [message];
}

class OnboardingCompleted extends OnboardingState {
  const OnboardingCompleted();
}
