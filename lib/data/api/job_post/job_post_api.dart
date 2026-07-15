import 'package:nimora_worker/domain/model/request/job_post_request_model.dart';
import 'package:nimora_worker/domain/model/response/job_post_response_model.dart';

abstract class JobPostApi {
  Future<JobPostResponseModel> jobPostRequest({
    required JobPostRequestModel jobPostRequestModel,
  });
}