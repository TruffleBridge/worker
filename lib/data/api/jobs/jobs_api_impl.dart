import 'package:dio/dio.dart';
import 'package:nimora_worker/data/api/jobs/jobs_api.dart';
import 'package:nimora_worker/domain/model/request/jobs_nearby_request_model.dart';
import 'package:nimora_worker/domain/model/response/job_applied_response_model.dart';
import 'package:nimora_worker/domain/model/response/job_detail_response_model.dart';
import 'package:nimora_worker/domain/model/response/jobs_nearby_response_model.dart';

class JobsApiImpl extends JobsApi {
  final Dio _dio;

  JobsApiImpl({required this._dio});

  @override
  Future<JobsNearbyResponseModel> jobsRequest({
    required JobsNearbyRequestModel jobsNearbyRequestModel,
  }) async {
    try {
      final response = await _dio.post(
        '/api/job/jobsNearby',
        data: jobsNearbyRequestModel.toJson(),
      );

      return JobsNearbyResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data?['message'] ?? 'Failed to load jobs');
    }
  }

  @override
  Future<JobDetailResponseModel> jobDetailRequest({
    required int jobId,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await _dio.post(
        '/api/job/viewJobDetail',
        data: {'jobId': jobId, 'latitude': latitude, 'longitude': longitude},
      );

      return JobDetailResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data?['message'] ?? 'Failed to load jobs');
    }
  }

  @override
  Future<JobAppliedResponseModel> jobAppliedSubmit({required int jobId}) async {
    try {
      final response = await _dio.post(
        '/api/job/applyJob',
        data: {'jobId': jobId},
      );

      return JobAppliedResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data?['message'] ?? 'Failed to load jobs');
    }
  }
}
