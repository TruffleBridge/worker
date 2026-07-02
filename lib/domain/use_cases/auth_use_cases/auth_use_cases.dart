import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nimora_worker/domain/model/response/user_model.dart';
import 'package:nimora_worker/domain/model/view_model/auth_credentials_model.dart';
import 'package:nimora_worker/domain/repositories/auth/auth_repository.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/utils/use_case.dart';

// ── Sign In ──────────────────────────────────────────────────────────────────

class SignInUseCase implements UseCase<User, AuthCredentials> {
  final AuthRepository repository;
  const SignInUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(AuthCredentials params) =>
      repository.signInWithEmailPassword(params);
}

class SignInWithGoogleUseCase implements UseCase<User, NoParams> {
  final AuthRepository repository;
  const SignInWithGoogleUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) =>
      repository.signInWithGoogle();
}

class SignInWithFacebookUseCase implements UseCase<User, NoParams> {
  final AuthRepository repository;
  const SignInWithFacebookUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) =>
      repository.signInWithFacebook();
}

// ── Register ─────────────────────────────────────────────────────────────────

// class RegisterUseCase implements UseCase<User, RegisterParams> {
//   final AuthRepository repository;
//   const RegisterUseCase(this.repository);
//
//   @override
//   Future<Either<Failure, User>> call(RegisterParams params) =>
//       repository.register(params);
// }

// ── Forgot Password ───────────────────────────────────────────────────────────

class ForgotPasswordParams extends Equatable {
  final String email;
  const ForgotPasswordParams(this.email);

  @override
  List<Object?> get props => [email];
}

class ForgotPasswordUseCase implements UseCase<void, ForgotPasswordParams> {
  final AuthRepository repository;
  const ForgotPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ForgotPasswordParams params) =>
      repository.forgotPassword(params.email);
}

// ── Reset Password ────────────────────────────────────────────────────────────

class ResetPasswordParams extends Equatable {
  final String token;
  final String newPassword;
  const ResetPasswordParams({required this.token, required this.newPassword});

  @override
  List<Object?> get props => [token, newPassword];
}

class ResetPasswordUseCase implements UseCase<void, ResetPasswordParams> {
  final AuthRepository repository;
  const ResetPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ResetPasswordParams params) =>
      repository.resetPassword(
        token: params.token,
        newPassword: params.newPassword,
      );
}

// ── Sign Out ──────────────────────────────────────────────────────────────────

class SignOutUseCase implements UseCase<void, NoParams> {
  final AuthRepository repository;
  const SignOutUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) =>
      repository.signOut();
}
