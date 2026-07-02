part of 'splash_bloc.dart';

abstract class ClientSplashState extends Equatable {
  const ClientSplashState();

  @override
  List<Object?> get props => [];
}

class ClientSplashInitial extends ClientSplashState {
  const ClientSplashInitial();
}

class ClientSplashLoading extends ClientSplashState {
  const ClientSplashLoading();
}

class ClientSplashNavigateToOnboarding extends ClientSplashState {
  const ClientSplashNavigateToOnboarding();
}

class ClientSplashNavigateToLogin extends ClientSplashState {
  const ClientSplashNavigateToLogin();
}

class ClientSplashNavigateToHome extends ClientSplashState {
  const ClientSplashNavigateToHome();
}
