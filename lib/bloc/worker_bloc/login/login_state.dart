part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure }
class WorkerLoginState extends Equatable{
 const WorkerLoginState();
 @override
 List<Object?> get props => <Object?>[];
}
class LoginOnLoadedState extends WorkerLoginState {
  final String email;
  final String password;
  final bool rememberMe;
  final bool passwordVisible;
  final LoginStatus status;
  final String? errorMessage;
  final UserModel? user;

  const LoginOnLoadedState({
    this.email = '',
    this.password = '',
    this.rememberMe = false,
    this.passwordVisible = false,
    this.status = LoginStatus.initial,
    this.errorMessage,
    this.user,
  });

  bool get isFormValid => email.trim().isNotEmpty && password.trim().isNotEmpty;

  static const _sentinel = Object();

  LoginOnLoadedState copyWith({
    String? email,
    String? password,
    bool? rememberMe,
    bool? passwordVisible,
    LoginStatus? status,
    Object? errorMessage = _sentinel,
    UserModel? user,
  }) {
    return LoginOnLoadedState(
      email: email ?? this.email,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
      passwordVisible: passwordVisible ?? this.passwordVisible,
      status: status ?? this.status,
      errorMessage: identical(errorMessage, _sentinel)
          ? this.errorMessage
          : errorMessage as String?,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    email,
    password,
    rememberMe,
    passwordVisible,
    status,
    errorMessage,
    user,
  ];
}
