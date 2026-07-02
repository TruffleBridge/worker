import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nimora_worker/core/enums/login_status.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginOnLoadEvent>(_onLoad);
    on<LoginPhoneChanged>(_onPhoneChanged);
    on<LoginWhatsAppChanged>(_onWhatsAppChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  void _onLoad(
      LoginOnLoadEvent event,
      Emitter<LoginState> emit,
      ) {
    emit(const LoginOnLoadedState());
  }

  void _onPhoneChanged(
      LoginPhoneChanged event,
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
      LoginWhatsAppChanged event,
      Emitter<LoginState> emit,
      ) {
    final state = this.state as LoginOnLoadedState;

    emit(
      state.copyWith(
        receiveWhatsApp: event.value,
      ),
    );
  }

  Future<void> _onSubmitted(
      LoginSubmitted event,
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
