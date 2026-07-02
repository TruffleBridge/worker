import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:nimora_worker/data/api/login/login_api.dart';
import 'package:nimora_worker/domain/model/response/user_model.dart';
import 'package:nimora_worker/infrastructure/storage/token_storage/token_storage.dart';

class LoginApiImpl extends LoginApi {
  final Dio _dio;
  final TokenStorage _tokenStorage;

  LoginApiImpl({
    required this._dio,
    required this._tokenStorage,
  });

  @override
  Future<UserModel> loginResponseModel({
    required String userName,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/api/auth/login',
        data: {
          'email': userName,
          'password': password,
        },
      );

      final body = Map<String, dynamic>.from(
        response.data as Map<String, dynamic>,
      );

      final token =
          body['token'] ??
              body['access_token'] ??
              body['accessToken'];

      if (token != null) {
        await _tokenStorage.saveToken(token.toString());
      }

      debugPrint('Login Response => $body');

      return UserModel.fromJson(body);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?['message'] ??
            'Something went wrong',
      );
    }
  }
}