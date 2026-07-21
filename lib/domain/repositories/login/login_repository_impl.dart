import 'package:nimora_worker/data/api/login/login_api.dart';
import 'package:nimora_worker/domain/model/response/user_model.dart';
import 'package:nimora_worker/domain/repositories/login/login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginApi loginApi;

  LoginRepositoryImpl({required this.loginApi});

  @override
  Future<UserModel> loginResponseModel({
    required String userName,
    required String password,
  }) {
    return loginApi.loginResponseModel(userName: userName, password: password);
  }

  @override
  Future<UserModel> googleLogin({
    required String idToken,
  }) {
    return loginApi.googleLogin(
      idToken: idToken,
    );
  }
}
