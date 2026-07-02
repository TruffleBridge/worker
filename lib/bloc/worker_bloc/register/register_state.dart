// part of 'register_bloc.dart';
//
// enum RegisterStatus { initial, loading, success, failure }
//
// class RegisterState extends Equatable {
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String password;
//   final String phone;
//   final bool passwordVisible;
//   final RegisterStatus status;
//   final String? errorMessage;
//
//   const RegisterState({
//     this.firstName = '',
//     this.lastName = '',
//     this.email = '',
//     this.password = '',
//     this.phone = '',
//     this.passwordVisible = false,
//     this.status = RegisterStatus.initial,
//     this.errorMessage,
//   });
//
//   bool get isFormValid =>
//       firstName.isNotEmpty &&
//       lastName.isNotEmpty &&
//       email.isNotEmpty &&
//       password.length >= 8 &&
//       phone.isNotEmpty;
//
//   RegisterState copyWith({
//     String? firstName,
//     String? lastName,
//     String? email,
//     String? password,
//     String? phone,
//     bool? passwordVisible,
//     RegisterStatus? status,
//     String? errorMessage,
//   }) =>
//       RegisterState(
//         firstName: firstName ?? this.firstName,
//         lastName: lastName ?? this.lastName,
//         email: email ?? this.email,
//         password: password ?? this.password,
//         phone: phone ?? this.phone,
//         passwordVisible: passwordVisible ?? this.passwordVisible,
//         status: status ?? this.status,
//         errorMessage: errorMessage,
//       );
//
//   @override
//   List<Object?> get props => [
//         firstName, lastName, email, password, phone,
//         passwordVisible, status, errorMessage,
//       ];
// }
