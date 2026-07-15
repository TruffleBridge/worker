import 'package:nimora_worker/domain/model/response/notification_list_response_model.dart';

abstract class NotificationApi {
  Future<NotificationListResponseModel> notificationListRequest();
}