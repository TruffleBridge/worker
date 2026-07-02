// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:nimora_worker/domain/use_cases/auth_use_cases/register_use_cases.dart';
//
//
// part 'register_event.dart';
// part 'register_state.dart';
//
// class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
//   final RegisterUseCase _registerUseCase;
//
//   RegisterBloc({required RegisterUseCase registerUseCase})
//       : _registerUseCase = registerUseCase,
//         super(const RegisterState()) {
//     on<RegisterFirstNameChanged>(
//         (e, emit) => emit(state.copyWith(firstName: e.value)));
//     on<RegisterLastNameChanged>(
//         (e, emit) => emit(state.copyWith(lastName: e.value)));
//     on<RegisterEmailChanged>(
//         (e, emit) => emit(state.copyWith(email: e.value)));
//     on<RegisterPasswordChanged>(
//         (e, emit) => emit(state.copyWith(password: e.value)));
//     on<RegisterPhoneChanged>(
//         (e, emit) => emit(state.copyWith(phone: e.value)));
//     on<RegisterPasswordVisibilityToggled>(
//         (e, emit) =>
//             emit(state.copyWith(passwordVisible: !state.passwordVisible)));
//     on<RegisterSubmitted>(_onSubmitted);
//   }
//
//   Future<void> _onSubmitted(
//       RegisterSubmitted e, Emitter<RegisterState> emit) async {
//     if (!state.isFormValid) return;
//     emit(state.copyWith(status: RegisterStatus.loading));
//     final result = await _registerUseCase(RegisterParams(
//       firstName: state.firstName,
//       lastName: state.lastName,
//       email: state.email,
//       password: state.password,
//       phoneNumber: state.phone,
//     ));
//     result.fold(
//       (f) => emit(state.copyWith(
//           status: RegisterStatus.failure, errorMessage: f.message)),
//       (_) => emit(state.copyWith(status: RegisterStatus.success)),
//     );
//   }
// }
