import 'package:dio/dio.dart';
import 'package:nimora_worker/data/api/create_profile/create_profile_api.dart';
import 'package:nimora_worker/domain/model/request/register_request_model.dart';
import 'package:nimora_worker/domain/model/response/register_response_model.dart';

class CreateProfileApiImpl extends CreateProfileApi {
  final Dio dio;

  CreateProfileApiImpl({required this.dio});

  @override
  Future<RegisterResponseModel> registerRequest({
    required RegisterRequestModel registerRequestModel,
  }) async {
    try {
      final response = await dio.post(
        '/api/auth/register',
        data: registerRequestModel.toJson(),
      );

      return RegisterResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data?['message'] ?? 'Failed to register profile');
    }
  }
}
