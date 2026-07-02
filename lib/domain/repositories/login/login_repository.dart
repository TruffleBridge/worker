
import 'package:nimora_worker/domain/model/response/user_model.dart';

abstract class LoginRepository {
  Future<UserModel> loginResponseModel({
    required String userName,
    required String password,
  });
}
