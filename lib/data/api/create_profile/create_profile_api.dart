import 'package:nimora_worker/domain/model/request/register_request_model.dart';
import 'package:nimora_worker/domain/model/response/register_response_model.dart';

abstract class CreateProfileApi {
  Future<RegisterResponseModel> registerRequest({
    required RegisterRequestModel registerRequestModel,
  });
}
