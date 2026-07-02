import 'package:dartz/dartz.dart';
import 'package:nimora_worker/domain/model/response/user_model.dart';
import 'package:nimora_worker/domain/model/view_model/auth_credentials_model.dart';

import '../../../../core/utils/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> signInWithEmailPassword(
      AuthCredentials credentials);

  Future<Either<Failure, User>> signInWithGoogle();

  Future<Either<Failure, User>> signInWithFacebook();

  // Future<Either<Failure, User>> register(RegisterParams params);

  Future<Either<Failure, void>> forgotPassword(String email);

  Future<Either<Failure, void>> resetPassword({
    required String token,
    required String newPassword,
  });

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, User?>> getCurrentUser();
}
