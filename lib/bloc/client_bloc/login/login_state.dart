part of 'login_bloc.dart';

enum ClientLoginStatus { initial, loading, success, failure }
class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginOnLoadedState extends LoginState {
  final String email;
  final String password;
  final String phone;
  final bool receiveWhatsApp;
  final LoginStatus status;
  final String? errorMessage;

  const LoginOnLoadedState({
    this.email = '',
    this.password = '',
    this.phone = '',
    this.receiveWhatsApp = false,
    this.status = LoginStatus.initial,
    this.errorMessage,
  });

  bool get isFormValid => phone.trim().length >= 10;

  static const _sentinel = Object();

  LoginOnLoadedState copyWith({
    String? email,
    String? password,
    String? phone,
    bool? receiveWhatsApp,
    LoginStatus? status,
    Object? errorMessage = _sentinel,
  }) {
    return LoginOnLoadedState(
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      receiveWhatsApp: receiveWhatsApp ?? this.receiveWhatsApp,
      status: status ?? this.status,
      errorMessage: identical(errorMessage, _sentinel)
          ? this.errorMessage
          : errorMessage as String?,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    phone,
    receiveWhatsApp,
    status,
    errorMessage,
  ];
}