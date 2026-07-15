import 'package:nimora_worker/data/api/upload_document/upload_document_api.dart';
import 'package:nimora_worker/domain/model/response/upload_response_model.dart';
import 'package:nimora_worker/domain/repositories/upload_document/upload_document_repository.dart';

class UploadRepositoryImpl implements UploadRepository {
  final UploadApi uploadApi;

  UploadRepositoryImpl({
    required this.uploadApi,
  });

  @override
  Future<UploadFileResponseModel> uploadFile({
    required String filePath,
    required String fileName,
  }) async {
    return uploadApi.uploadFile(
      filePath: filePath,
      fileName: fileName,
    );
  }
}