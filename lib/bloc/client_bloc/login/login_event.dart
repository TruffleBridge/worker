part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class ClientLoginOnLoadEvent extends LoginEvent {
  const ClientLoginOnLoadEvent();
}

class ClientLoginPhoneChanged extends LoginEvent {
  final String phone;

  const ClientLoginPhoneChanged(this.phone);

  @override
  List<Object?> get props => [phone];
}

class ClientLoginWhatsAppChanged extends LoginEvent {
  final bool value;

  const ClientLoginWhatsAppChanged(this.value);

  @override
  List<Object?> get props => [value];
}
class ClientLoginEmailChanged extends LoginEvent {
  final String email;

  const ClientLoginEmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class ClientLoginPasswordChanged extends LoginEvent {
  final String password;

  const ClientLoginPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}
class ClientLoginSubmitted extends LoginEvent {
  const ClientLoginSubmitted();
}

class ClientGoogleLoginSubmitted extends LoginEvent {
  const ClientGoogleLoginSubmitted();
}