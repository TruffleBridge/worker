import 'package:nimora_worker/data/api/create_profile/create_profile_api.dart';
import 'package:nimora_worker/domain/model/request/register_request_model.dart';
import 'package:nimora_worker/domain/model/response/register_response_model.dart';
import 'package:nimora_worker/domain/repositories/create_profile/create_profile_repository.dart';

class CreateProfileRepositoryImpl extends CreateProfileRepository {
  final CreateProfileApi createProfileApi;

  CreateProfileRepositoryImpl({required this.createProfileApi});

  @override
  Future<RegisterResponseModel> registerRequest({
    required RegisterRequestModel registerRequestModel,
  }) {
    return createProfileApi.registerRequest(registerRequestModel: registerRequestModel);
  }
}
