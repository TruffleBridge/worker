import 'package:nimora_worker/domain/model/request/jobs_nearby_request_model.dart';
import 'package:nimora_worker/domain/model/response/job_applied_response_model.dart';
import 'package:nimora_worker/domain/model/response/job_detail_response_model.dart';
import 'package:nimora_worker/domain/model/response/job_tracker_response_model.dart';
import 'package:nimora_worker/domain/model/response/jobs_nearby_response_model.dart';

import '../../../domain/model/request/job_listing/job_listing_request_model.dart';
import '../../../domain/model/response/job_listing/job_listing_response_model.dart';

abstract class JobsApi {
  Future<JobsNearbyResponseModel> jobsRequest({
    required JobsNearbyRequestModel jobsNearbyRequestModel,
  });

  Future<JobTrackerResponseModel> jobTrackerRequest({
    required int page,
    required int limit,
    int? applicationStatusId,
    String? search,
  });

  Future<JobDetailResponseModel> jobDetailRequest({
    required int jobId,
    required double latitude,
    required double longitude,
  });

  Future<JobAppliedResponseModel> jobAppliedSubmit({
    required int jobId,
  });

  Future<MyJobsResponseModel> myJobsListRequest({
    required MyJobsRequestModel myJobsRequestModel,
  });
}


