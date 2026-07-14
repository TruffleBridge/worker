import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nimora_worker/core/enums/login_status.dart';

import '../../../domain/repositories/login/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc({required this.loginRepository}) : super(LoginState()) {
    on<ClientLoginOnLoadEvent>(_onLoad);
    on<ClientLoginEmailChanged>(_onEmailChanged);
    on<ClientLoginPasswordChanged>(_onPasswordChanged);
    on<ClientLoginPhoneChanged>(_onPhoneChanged);
    on<ClientLoginWhatsAppChanged>(_onWhatsAppChanged);
    on<ClientLoginSubmitted>(_onSubmitted);
  }

  void _onLoad(
      ClientLoginOnLoadEvent event,
      Emitter<LoginState> emit,
      ) {
    emit(const LoginOnLoadedState());
  }

  void _onPhoneChanged(
      ClientLoginPhoneChanged event,
      Emitter<LoginState> emit,
      ) {
    final state = this.state as LoginOnLoadedState;

    emit(
      state.copyWith(
        phone: event.phone,
        status: LoginStatus.initial,
        errorMessage: null,
      ),
    );
  }

  void _onWhatsAppChanged(
      ClientLoginWhatsAppChanged event,
      Emitter<LoginState> emit,
      ) {
    final state = this.state as LoginOnLoadedState;

    emit(
      state.copyWith(
        receiveWhatsApp: event.value,
      ),
    );
  }
  void _onEmailChanged(ClientLoginEmailChanged event, Emitter<LoginState> emit) {
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
      ClientLoginPasswordChanged event,
      Emitter<LoginState> emit,
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

  Future<void> _onSubmitted(
      ClientLoginSubmitted event,
      Emitter<LoginState> emit,
      ) async {
    final state = this.state as LoginOnLoadedState;

    if (!state.isFormValid) return;

    emit(
      state.copyWith(
        status: LoginStatus.loading,
      ),
    );

    // TODO:
    // Call send OTP API

    emit(
      state.copyWith(
        status: LoginStatus.otpSent,
      ),
    );
  }
}
