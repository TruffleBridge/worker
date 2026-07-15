import 'package:dio/dio.dart';
import 'package:nimora_worker/data/api/notifications/notifications_api.dart';
import 'package:nimora_worker/domain/model/response/notification_list_response_model.dart';

class NotificationApiImpl implements NotificationApi {
  final Dio dio;

  NotificationApiImpl({
    required this.dio,
  });

  @override
  Future<NotificationListResponseModel> notificationListRequest() async {
    try {
      final response = await dio.post(
        '/api/notification/notificationList',
      );

      return NotificationListResponseModel.fromJson(
        Map<String, dynamic>.from(
          response.data as Map,
        ),
      );
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?['message'] ??
            'Failed to load notifications',
      );
    }
  }
}