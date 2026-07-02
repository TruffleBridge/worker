part of 'splash_bloc.dart';

abstract class WorkerSplashEvent extends Equatable {
  const WorkerSplashEvent();

  @override
  List<Object?> get props => [];
}

class WorkerSplashStarted extends WorkerSplashEvent {
  const WorkerSplashStarted();
}
