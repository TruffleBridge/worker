part of 'splash_bloc.dart';

abstract class ClientSplashEvent extends Equatable {
  const ClientSplashEvent();

  @override
  List<Object?> get props => [];
}

class ClientSplashStarted extends ClientSplashEvent {
  const ClientSplashStarted();
}
