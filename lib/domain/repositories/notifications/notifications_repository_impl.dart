
import 'package:nimora_worker/data/api/notifications/notifications_api.dart';
import 'package:nimora_worker/domain/model/response/notification_list_response_model.dart';
import 'package:nimora_worker/domain/repositories/notifications/notifications_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationApi notificationApi;

  NotificationRepositoryImpl({
    required this.notificationApi,
  });

  @override
  Future<NotificationListResponseModel> notificationListRequest() {
    return notificationApi.notificationListRequest();
  }
}