import 'package:nimora_worker/data/api/job_post/job_post_api.dart';
import 'package:nimora_worker/domain/model/request/job_post_request_model.dart';
import 'package:nimora_worker/domain/model/response/job_post_response_model.dart';
import 'package:nimora_worker/domain/repositories/job_post/job_post_repository.dart';

class JobPostRepositoryImpl extends JobPostRepository {
  final JobPostApi jobPostApi;

  JobPostRepositoryImpl({required this.jobPostApi});

  @override
  Future<JobPostResponseModel> jobPostRequest({
    required JobPostRequestModel jobPostRequestModel,
  }) {
    return jobPostApi.jobPostRequest(jobPostRequestModel: jobPostRequestModel);
  }
}
