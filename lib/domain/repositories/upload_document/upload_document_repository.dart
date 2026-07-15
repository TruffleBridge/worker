
import 'package:nimora_worker/domain/model/response/upload_response_model.dart';

abstract class UploadRepository {
  Future<UploadFileResponseModel> uploadFile({
    required String filePath,
    required String fileName,
  });
}