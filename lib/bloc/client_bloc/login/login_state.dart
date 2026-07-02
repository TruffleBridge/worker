part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginOnLoadedState extends LoginState {
  final String phone;
  final bool receiveWhatsApp;
  final LoginStatus status;
  final String? errorMessage;

  const LoginOnLoadedState({
    this.phone = '',
    this.receiveWhatsApp = false,
    this.status = LoginStatus.initial,
    this.errorMessage,
  });

  bool get isFormValid => phone.trim().length >= 10;

  static const _sentinel = Object();

  LoginOnLoadedState copyWith({
    String? phone,
    bool? receiveWhatsApp,
    LoginStatus? status,
    Object? errorMessage = _sentinel,
  }) {
    return LoginOnLoadedState(
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
    phone,
    receiveWhatsApp,
    status,
    errorMessage,
  ];
}