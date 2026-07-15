import 'package:dio/dio.dart';
import 'package:nimora_worker/data/api/job_post/job_post_api.dart';
import 'package:nimora_worker/domain/model/request/job_post_request_model.dart';
import 'package:nimora_worker/domain/model/response/job_post_response_model.dart';

class JobPostApiImpl extends JobPostApi{
  final Dio dio;
  JobPostApiImpl({required this.dio});
  @override
  Future<JobPostResponseModel> jobPostRequest({
    required JobPostRequestModel jobPostRequestModel,
  })async{
    try {
      final response = await dio.post(
        '/api/client/postJob',
        data: jobPostRequestModel.toJson(),
      );

      return JobPostResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data?['message'] ?? 'Failed to load jobs');
    }
  }
}