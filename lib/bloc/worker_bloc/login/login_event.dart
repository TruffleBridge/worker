part of 'login_bloc.dart';

abstract class WorkerLoginEvent extends Equatable {
  const WorkerLoginEvent();

  @override
  List<Object?> get props => [];
}
class LoginOnLoadEvent extends WorkerLoginEvent{
  const LoginOnLoadEvent();
  @override
  List<Object?> get props => [];
}
class LoginEmailChanged extends WorkerLoginEvent {
  final String email;

  const LoginEmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class LoginPasswordChanged extends WorkerLoginEvent {
  final String password;

  const LoginPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class LoginRememberMeToggled extends WorkerLoginEvent {
  const LoginRememberMeToggled();
}

class LoginPasswordVisibilityToggled extends WorkerLoginEvent {
  const LoginPasswordVisibilityToggled();
}

class LoginSubmitted extends WorkerLoginEvent {
  const LoginSubmitted();
}

class LoginWithGooglePressed extends WorkerLoginEvent {
  const LoginWithGooglePressed();
}

class LoginWithFacebookPressed extends WorkerLoginEvent {
  const LoginWithFacebookPressed();
}

class WorkerGoogleLoginSubmitted extends WorkerLoginEvent {
  const WorkerGoogleLoginSubmitted();
}