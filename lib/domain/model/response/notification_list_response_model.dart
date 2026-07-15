class NotificationListResponseModel {
  bool? status;
  String? message;
  NotificationListData? data;

  NotificationListResponseModel({this.status, this.message, this.data});

  NotificationListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? NotificationListData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class NotificationListData {
  int? count;
  int? totalCount;
  List<NotificationListResult>? result;

  NotificationListData({this.count, this.totalCount, this.result});

  NotificationListData.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    totalCount = json['totalCount'];
    if (json['result'] != null) {
      result = <NotificationListResult>[];
      json['result'].forEach((v) {
        result!.add(NotificationListResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['totalCount'] = totalCount;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationListResult {
  int? id;
  String? profilePicture;
  String? clientName;
  String? jobTitle;
  String? date;
  String? time;
  String? duration;
  String? location;
  String? bookingStatus;
  String? notificationTime;

  NotificationListResult(
      {this.id,
        this.profilePicture,
        this.clientName,
        this.jobTitle,
        this.date,
        this.time,
        this.duration,
        this.location,
        this.bookingStatus,
        this.notificationTime});

  NotificationListResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profilePicture = json['profilePicture'];
    clientName = json['clientName'];
    jobTitle = json['jobTitle'];
    date = json['date'];
    time = json['time'];
    duration = json['duration'];
    location = json['location'];
    bookingStatus = json['bookingStatus'];
    notificationTime = json['notificationTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['profilePicture'] = profilePicture;
    data['clientName'] = clientName;
    data['jobTitle'] = jobTitle;
    data['date'] = date;
    data['time'] = time;
    data['duration'] = duration;
    data['location'] = location;
    data['bookingStatus'] = bookingStatus;
    data['notificationTime'] = notificationTime;
    return data;
  }
}
