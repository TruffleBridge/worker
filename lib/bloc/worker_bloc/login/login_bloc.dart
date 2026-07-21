// import 'dart:async';
//
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:nimora_worker/domain/model/response/user_model.dart';
// import 'package:nimora_worker/domain/model/view_model/auth_credentials_model.dart';
//
// part 'login_event.dart';
//
// part 'login_state.dart';
//
// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   LoginBloc() : super(const LoginState()) {
//     on<LoginOnLoadEvent>(_onLoginOnLoadEvent);
//     on<LoginEmailChanged>(_onEmailChanged);
//     on<LoginPasswordChanged>(_onPasswordChanged);
//     on<LoginRememberMeToggled>(_onRememberMeToggled);
//     on<LoginPasswordVisibilityToggled>(_onPasswordVisibilityToggled);
//     on<LoginSubmitted>(_onSubmitted);
//     // on<LoginWithGooglePressed>(_onGooglePressed);
//     // on<LoginWithFacebookPressed>(_onFacebookPressed);
//   }
//
//   FutureOr<void> _onLoginOnLoadEvent(
//     LoginOnLoadEvent event,
//     Emitter<LoginState> emit,
//   ) {}
//
//   void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
//     emit(
//       state.copyWith(
//         email: event.email,
//         status: LoginStatus.initial,
//         errorMessage: null,
//       ),
//     );
//   }
//
//   void _onPasswordChanged(
//     LoginPasswordChanged event,
//     Emitter<LoginState> emit,
//   ) {
//     emit(
//       state.copyWith(
//         password: event.password,
//         status: LoginStatus.initial,
//         errorMessage: null,
//       ),
//     );
//   }
//
//   void _onRememberMeToggled(
//     LoginRememberMeToggled event,
//     Emitter<LoginState> emit,
//   ) {
//     emit(state.copyWith(rememberMe: !state.rememberMe));
//   }
//
//   void _onPasswordVisibilityToggled(
//     LoginPasswordVisibilityToggled event,
//     Emitter<LoginState> emit,
//   ) {
//     emit(state.copyWith(passwordVisible: !state.passwordVisible));
//   }
//
//   Future<void> _onSubmitted(
//     LoginSubmitted event,
//     Emitter<LoginState> emit,
//   ) async {
//     if (state.status == LoginStatus.loading) return;
//
//     if (!state.isFormValid) return;
//
//     emit(state.copyWith(status: LoginStatus.loading, errorMessage: null));
//
//     final result = await _signInUseCase(
//       AuthCredentials(
//         email: state.email,
//         password: state.password,
//         rememberMe: state.rememberMe,
//       ),
//     );
//
//     _handleAuthResult(result, emit);
//   }
//
//   // Future<void> _onGooglePressed(
//   //     LoginWithGooglePressed event,
//   //     Emitter<LoginState> emit,
//   //     ) async {
//   //   if (state.status == LoginStatus.loading) return;
//   //
//   //   emit(
//   //     state.copyWith(
//   //       status: LoginStatus.loading,
//   //       errorMessage: null,
//   //     ),
//   //   );
//   //
//   //   final result = await _signInWithGoogleUseCase(
//   //     NoParams(),
//   //   );
//   //
//   //   _handleAuthResult(result, emit);
//   // }
//   //
//   // Future<void> _onFacebookPressed(
//   //     LoginWithFacebookPressed event,
//   //     Emitter<LoginState> emit,
//   //     ) async {
//   //   if (state.status == LoginStatus.loading) return;
//   //
//   //   emit(
//   //     state.copyWith(
//   //       status: LoginStatus.loading,
//   //       errorMessage: null,
//   //     ),
//   //   );
//   //
//   //   final result = await _signInWithFacebookUseCase(
//   //     NoParams(),
//   //   );
//   //
//   //   _handleAuthResult(result, emit);
//   // }
//
//   void _handleAuthResult(dynamic result, Emitter<LoginState> emit) {
//     result.fold(
//       (failure) {
//         emit(
//           state.copyWith(
//             status: LoginStatus.failure,
//             errorMessage: failure.message,
//           ),
//         );
//       },
//       (user) {
//         emit(
//           state.copyWith(
//             status: LoginStatus.success,
//             user: user,
//             errorMessage: null,
//           ),
//         );
//       },
//     );
//   }
// }

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimora_worker/domain/repositories/login/login_repository.dart';
import 'package:nimora_worker/domain/model/response/user_model.dart';
import 'package:nimora_worker/infrastructure/storage/token_storage/token_storage.dart';

import '../../../core/di/google_auth_service/google_auth_service.dart';

part 'login_event.dart';

part 'login_state.dart';

class WorkerLoginBloc extends Bloc<WorkerLoginEvent, WorkerLoginState> {
  final LoginRepository loginRepository;
  final TokenStorage tokenStorage;

  WorkerLoginBloc({required this.loginRepository, required this.tokenStorage,}) : super(WorkerLoginState()) {
    on<LoginOnLoadEvent>(_onLoginOnLoadEvent);
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginRememberMeToggled>(_onRememberMeToggled);
    on<LoginPasswordVisibilityToggled>(_onPasswordVisibilityToggled);
    on<LoginSubmitted>(_onSubmitted);
    on<WorkerGoogleLoginSubmitted>(_onGoogleLoginSubmitted);
  }

  FutureOr<void> _onLoginOnLoadEvent(
    LoginOnLoadEvent event,
    Emitter<WorkerLoginState> emit,
  ) {
    emit(LoginOnLoadedState());
  }

  void _onEmailChanged(LoginEmailChanged event, Emitter<WorkerLoginState> emit) {
    final castState = state as LoginOnLoadedState;
    emit(
      castState.copyWith(
        email: event.email,
        status: LoginStatus.initial,
        errorMessage: null,
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<WorkerLoginState> emit,
  ) {
    final castState = state as LoginOnLoadedState;
    emit(
      castState.copyWith(
        password: event.password,
        status: LoginStatus.initial,
        errorMessage: null,
      ),
    );
  }

  void _onRememberMeToggled(
    LoginRememberMeToggled event,
    Emitter<WorkerLoginState> emit,
  ) {
    final castState = state as LoginOnLoadedState;
    emit(castState.copyWith(rememberMe: !castState.rememberMe));
  }

  void _onPasswordVisibilityToggled(
    LoginPasswordVisibilityToggled event,
    Emitter<WorkerLoginState> emit,
  ) {
    final castState = state as LoginOnLoadedState;
    emit(castState.copyWith(passwordVisible: !castState.passwordVisible));
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<WorkerLoginState> emit,
  ) async {
    final castState = state as LoginOnLoadedState;
    if (castState.status == LoginStatus.loading) return;

    if (!castState.isFormValid) return;

    emit(castState.copyWith(status: LoginStatus.loading, errorMessage: null));

    try {
      final UserModel user = await loginRepository.loginResponseModel(
        userName: castState.email,
        password: castState.password,
      );

      final accessToken = user.data?.accessToken ?? '';

      if (accessToken.isNotEmpty) {
        await tokenStorage.saveToken(accessToken);
      }

      emit(
        castState.copyWith(
          status: LoginStatus.success,
          user: user,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        castState.copyWith(
          status: LoginStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onGoogleLoginSubmitted(
      WorkerGoogleLoginSubmitted event,
      Emitter<WorkerLoginState> emit,
      ) async {
    final state = this.state as LoginOnLoadedState;

    emit(
      state.copyWith(
        status: LoginStatus.loading,
        errorMessage: null,
      ),
    );

    try {
      final idToken = await GoogleAuthService().signIn();

      if (idToken == null) {
        emit(
          state.copyWith(
            status: LoginStatus.initial,
          ),
        );
        return;
      }

      await loginRepository.googleLogin(
        idToken: idToken,
      );

      emit(
        state.copyWith(
          status: LoginStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
