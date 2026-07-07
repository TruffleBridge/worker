import 'package:nimora_worker/data/api/jobs/jobs_api.dart';
import 'package:nimora_worker/domain/model/request/jobs_nearby_request_model.dart';
import 'package:nimora_worker/domain/model/response/job_applied_response_model.dart';
import 'package:nimora_worker/domain/model/response/job_detail_response_model.dart';
import 'package:nimora_worker/domain/model/response/jobs_nearby_response_model.dart';
import 'package:nimora_worker/domain/repositories/jobs/jobs_repository.dart';

import '../../model/request/job_listing/job_listing_request_model.dart';
import '../../model/response/job_listing/job_listing_response_model.dart';

class JobsRepositoryImpl extends JobsRepository {
  final JobsApi jobsApi;

  JobsRepositoryImpl({required this.jobsApi});

  @override
  Future<JobsNearbyResponseModel> jobsRequest({
    required JobsNearbyRequestModel jobsNearbyRequestModel,
  }) {
    return jobsApi.jobsRequest(jobsNearbyRequestModel: jobsNearbyRequestModel);
  }

  @override
  Future<JobDetailResponseModel> jobDetailRequest({
    required int jobId,
    required double latitude,
    required double longitude,
  }) {
    return jobsApi.jobDetailRequest(
      jobId: jobId,
      latitude: latitude,
      longitude: longitude,
    );
  }

  @override
  Future<JobAppliedResponseModel> jobAppliedSubmit({
    required int jobId,
  }) {
    return jobsApi.jobAppliedSubmit(
      jobId: jobId,
    );
  }
  @override
  Future<MyJobsResponseModel> myJobsListRequest({
    required MyJobsRequestModel myJobsRequestModel,
  }) async {
    return jobsApi.myJobsListRequest(
      myJobsRequestModel: myJobsRequestModel,
    );
  }
}