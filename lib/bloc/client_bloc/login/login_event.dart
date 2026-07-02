part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginOnLoadEvent extends LoginEvent {
  const LoginOnLoadEvent();
}

class LoginPhoneChanged extends LoginEvent {
  final String phone;

  const LoginPhoneChanged(this.phone);

  @override
  List<Object?> get props => [phone];
}

class LoginWhatsAppChanged extends LoginEvent {
  final bool value;

  const LoginWhatsAppChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}
