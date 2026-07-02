part of 'onboarding_bloc.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

class OnboardingStarted extends OnboardingEvent {
  const OnboardingStarted();
}

class OnboardingPageChanged extends OnboardingEvent {
  final int pageIndex;
  const OnboardingPageChanged(this.pageIndex);

  @override
  List<Object?> get props => [pageIndex];
}

class OnboardingNextPressed extends OnboardingEvent {
  const OnboardingNextPressed();
}

class OnboardingSkipPressed extends OnboardingEvent {
  const OnboardingSkipPressed();
}

class OnboardingGetStartedPressed extends OnboardingEvent {
  const OnboardingGetStartedPressed();
}
