part of 'splash_bloc.dart';

abstract class WorkerSplashState extends Equatable {
  const WorkerSplashState();

  @override
  List<Object?> get props => [];
}

class WorkerSplashInitial extends WorkerSplashState {
  const WorkerSplashInitial();
}

class WorkerSplashLoading extends WorkerSplashState {
  const WorkerSplashLoading();
}

class WorkerSplashNavigateToOnboarding extends WorkerSplashState {
  const WorkerSplashNavigateToOnboarding();
}

class WorkerSplashNavigateToLogin extends WorkerSplashState {
  const WorkerSplashNavigateToLogin();
}

class WorkerSplashNavigateToHome extends WorkerSplashState {
  const WorkerSplashNavigateToHome();
}
