import 'package:nimora_worker/data/api/jobs/jobs_api.dart';
import 'package:nimora_worker/domain/model/request/jobs_nearby_request_model.dart';
import 'package:nimora_worker/domain/model/response/booking_status_update_response_model.dart';
import 'package:nimora_worker/domain/model/response/job_applied_response_model.dart';
import 'package:nimora_worker/domain/model/response/job_detail_response_model.dart';
import 'package:nimora_worker/domain/model/response/job_tracker_response_model.dart';
import 'package:nimora_worker/domain/model/response/jobs_nearby_response_model.dart';
import 'package:nimora_worker/domain/repositories/jobs/jobs_repository.dart';

import '../../model/request/job_detail/job_detail_request_model.dart';
import '../../model/request/job_listing/job_listing_request_model.dart';
import '../../model/response/job_detail/job_detail_response_model.dart';
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
  Future<JobTrackerResponseModel> jobTrackerRequest({
    required int page,
    required int limit,
    int? applicationStatusId,
    String? search,
  }) {
    return jobsApi.jobTrackerRequest(
      page: page,
      limit: limit,
      applicationStatusId: applicationStatusId,
      search: search,
    );
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
  Future<JobAppliedResponseModel> jobAppliedSubmit({required int jobId}) {
    return jobsApi.jobAppliedSubmit(jobId: jobId);
  }

  @override
  Future<ClientJobsResponseModel> clientJobsListRequest({
    required ClientJobsRequestModel clientJobsRequestModel,
  }) async {
    return jobsApi.clientJobsListRequest(
      clientJobsRequestModel: clientJobsRequestModel,
    );
  }

  @override
  Future<ClientJobDetailResponseModel> clientJobDetailRequest({
    required ClientJobDetailRequestModel clientJobDetailRequestModel,
  }) async {
    return jobsApi.clientJobDetailRequest(
      clientJobDetailRequestModel: clientJobDetailRequestModel,
    );
  }

  @override
  Future<BookingStatusUpdateResponseModel> clientBookingStatusUpdate({
    required int jobId,
    required int workerId,
    required int clientId,
    required String statusType,
  }) async {
    return jobsApi.clientBookingStatusUpdate(
      jobId: jobId,
      workerId: workerId,
      statusType: statusType,
      clientId: clientId,
    );
  }
}
