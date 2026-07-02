class JobAppliedResponseModel {
  bool? status;
  String? message;
  JobAppliedData? data;

  JobAppliedResponseModel({this.status, this.message, this.data});

  JobAppliedResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? JobAppliedData.fromJson(json['data']) : null;
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

class JobAppliedData {
  Application? application;
  List<Bookings>? bookings;
  List<ShiftLog>? shiftLogs;

  JobAppliedData({this.application, this.bookings, this.shiftLogs});

  JobAppliedData.fromJson(Map<String, dynamic> json) {
    application = json['application'] != null
        ? Application.fromJson(json['application'])
        : null;
    if (json['bookings'] != null) {
      bookings = <Bookings>[];
      json['bookings'].forEach((v) {
        bookings!.add(Bookings.fromJson(v));
      });
    }
    if (json['shiftLogs'] != null) {
      shiftLogs = <ShiftLog>[];
      json['shiftLogs'].forEach((v) {
        shiftLogs!.add(ShiftLog.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (application != null) {
      data['application'] = application!.toJson();
    }
    if (bookings != null) {
      data['bookings'] = bookings!.map((v) => v.toJson()).toList();
    }
    if (shiftLogs != null) {
      data['shiftLogs'] = shiftLogs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Application {
  int? id;
  int? userId;
  int? jobId;
  int? applicationStatusId;
  String? createdAt;
  String? updatedAt;
  ApplicationStatus? applicationStatus;

  Application(
      {this.id,
        this.userId,
        this.jobId,
        this.applicationStatusId,
        this.createdAt,
        this.updatedAt,
        this.applicationStatus});

  Application.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    jobId = json['jobId'];
    applicationStatusId = json['applicationStatusId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    applicationStatus = json['applicationStatus'] != null
        ? ApplicationStatus.fromJson(json['applicationStatus'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['jobId'] = jobId;
    data['applicationStatusId'] = applicationStatusId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (applicationStatus != null) {
      data['applicationStatus'] = applicationStatus!.toJson();
    }
    return data;
  }
}

class ApplicationStatus {
  int? id;
  String? name;

  ApplicationStatus({this.id, this.name});

  ApplicationStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Bookings {
  int? id;
  int? jobId;
  int? clientId;
  int? workerId;
  int? jobSessionId;
  int? bookingStatusId;
  String? cancelReason;
  String? createdAt;
  String? updatedAt;
  BookingStatus? bookingStatus;
  ShiftLog? shiftLog;

  Bookings(
      {this.id,
        this.jobId,
        this.clientId,
        this.workerId,
        this.jobSessionId,
        this.bookingStatusId,
        this.cancelReason,
        this.createdAt,
        this.updatedAt,
        this.bookingStatus,
        this.shiftLog});

  Bookings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['jobId'];
    clientId = json['clientId'];
    workerId = json['workerId'];
    jobSessionId = json['jobSessionId'];
    bookingStatusId = json['bookingStatusId'];
    cancelReason = json['cancelReason'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    bookingStatus = json['bookingStatus'] != null
        ? BookingStatus.fromJson(json['bookingStatus'])
        : null;
    shiftLog = json['shiftLog'] != null
        ? ShiftLog.fromJson(json['shiftLog'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['jobId'] = jobId;
    data['clientId'] = clientId;
    data['workerId'] = workerId;
    data['jobSessionId'] = jobSessionId;
    data['bookingStatusId'] = bookingStatusId;
    data['cancelReason'] = cancelReason;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (bookingStatus != null) {
      data['bookingStatus'] = bookingStatus!.toJson();
    }
    if (shiftLog != null) {
      data['shiftLog'] = shiftLog!.toJson();
    }
    return data;
  }
}

class BookingStatus {
  int? id;
  String? name;
  String? status;

  BookingStatus({this.id, this.name, this.status});

  BookingStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    return data;
  }
}

class ShiftLog {
  int? id;
  int? bookingId;
  String? clockInTime;
  String? clockOutTime;
  String? createdAt;
  String? updatedAt;

  ShiftLog(
      {this.id,
        this.bookingId,
        this.clockInTime,
        this.clockOutTime,
        this.createdAt,
        this.updatedAt});

  ShiftLog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['bookingId'];
    clockInTime = json['clockInTime'];
    clockOutTime = json['clockOutTime'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bookingId'] = bookingId;
    data['clockInTime'] = clockInTime;
    data['clockOutTime'] = clockOutTime;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
