import 'package:dio/dio.dart';
import 'package:nimora_worker/data/api/upload_document/upload_document_api.dart';
import 'package:nimora_worker/domain/model/response/upload_response_model.dart';

class UploadApiImpl implements UploadApi {
  final Dio dio;

  UploadApiImpl({
    required this.dio,
  });

  @override
  Future<UploadFileResponseModel> uploadFile({
    required String filePath,
    required String fileName,
  }) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          filePath,
          filename: fileName,
        ),
      });

      final response = await dio.post(
        '/api/uploads/',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );

      return UploadFileResponseModel.fromJson(
        Map<String, dynamic>.from(
          response.data as Map,
        ),
      );
    } on DioException catch (e) {
      final responseData = e.response?.data;

      String errorMessage = 'Failed to upload file';

      if (responseData is Map) {
        errorMessage =
            responseData['message']?.toString() ??
                errorMessage;
      }

      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(
        e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }
}