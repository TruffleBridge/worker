class UpcomingBookingResponseModel {
  bool? status;
  String? message;
  UpcomingBookingsData? data;

  UpcomingBookingResponseModel({this.status, this.message, this.data});

  UpcomingBookingResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UpcomingBookingsData.fromJson(json['data']) : null;
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

class UpcomingBookingsData {
  int? totalCount;
  Filters? filters;
  List<String>? calendarDates;
  List<Bookings>? bookings;

  UpcomingBookingsData({this.totalCount, this.filters, this.calendarDates, this.bookings});

  UpcomingBookingsData.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    filters =
    json['filters'] != null ? Filters.fromJson(json['filters']) : null;
    calendarDates = json['calendarDates'].cast<String>();
    if (json['bookings'] != null) {
      bookings = <Bookings>[];
      json['bookings'].forEach((v) {
        bookings!.add(Bookings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalCount'] = totalCount;
    if (filters != null) {
      data['filters'] = filters!.toJson();
    }
    data['calendarDates'] = calendarDates;
    if (bookings != null) {
      data['bookings'] = bookings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Filters {
  String? selectedDate;
  int? month;
  int? year;

  Filters({this.selectedDate, this.month, this.year});

  Filters.fromJson(Map<String, dynamic> json) {
    selectedDate = json['selectedDate'];
    month = json['month'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['selectedDate'] = selectedDate;
    data['month'] = month;
    data['year'] = year;
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
  BookingStatus? bookingStatus;
  String? cancelReason;
  String? createdAt;
  String? updatedAt;
  String? role;
  Job? job;
  List<JobServiceCategories>? jobServiceCategories;
  Session? session;
  Client? client;
  Client? worker;

  Bookings(
      {this.id,
        this.jobId,
        this.clientId,
        this.workerId,
        this.jobSessionId,
        this.bookingStatusId,
        this.bookingStatus,
        this.cancelReason,
        this.createdAt,
        this.updatedAt,
        this.role,
        this.job,
        this.jobServiceCategories,
        this.session,
        this.client,
        this.worker});

  Bookings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['jobId'];
    clientId = json['clientId'];
    workerId = json['workerId'];
    jobSessionId = json['jobSessionId'];
    bookingStatusId = json['bookingStatusId'];
    bookingStatus = json['bookingStatus'] != null
        ? BookingStatus.fromJson(json['bookingStatus'])
        : null;
    cancelReason = json['cancelReason'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    role = json['role'];
    job = json['job'] != null ? Job.fromJson(json['job']) : null;
    if (json['jobServiceCategories'] != null) {
      jobServiceCategories = <JobServiceCategories>[];
      json['jobServiceCategories'].forEach((v) {
        jobServiceCategories!.add(JobServiceCategories.fromJson(v));
      });
    }
    session =
    json['session'] != null ? Session.fromJson(json['session']) : null;
    client =
    json['client'] != null ? Client.fromJson(json['client']) : null;
    worker =
    json['worker'] != null ? Client.fromJson(json['worker']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['jobId'] = jobId;
    data['clientId'] = clientId;
    data['workerId'] = workerId;
    data['jobSessionId'] = jobSessionId;
    data['bookingStatusId'] = bookingStatusId;
    if (bookingStatus != null) {
      data['bookingStatus'] = bookingStatus!.toJson();
    }
    data['cancelReason'] = cancelReason;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['role'] = role;
    if (job != null) {
      data['job'] = job!.toJson();
    }
    if (jobServiceCategories != null) {
      data['jobServiceCategories'] =
          jobServiceCategories!.map((v) => v.toJson()).toList();
    }
    if (session != null) {
      data['session'] = session!.toJson();
    }
    if (client != null) {
      data['client'] = client!.toJson();
    }
    if (worker != null) {
      data['worker'] = worker!.toJson();
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

class Job {
  int? id;
  String? title;
  String? description;
  String? category;
  int? hourlyRate;
  String? shift;
  int? postedBy;
  Location? location;
  List<JobServiceCategories>? jobServiceCategories;

  Job(
      {this.id,
        this.title,
        this.description,
        this.category,
        this.hourlyRate,
        this.shift,
        this.postedBy,
        this.location,
        this.jobServiceCategories});

  Job.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    hourlyRate = json['hourlyRate'];
    shift = json['shift'];
    postedBy = json['postedBy'];
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    if (json['jobServiceCategories'] != null) {
      jobServiceCategories = <JobServiceCategories>[];
      json['jobServiceCategories'].forEach((v) {
        jobServiceCategories!.add(JobServiceCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['category'] = category;
    data['hourlyRate'] = hourlyRate;
    data['shift'] = shift;
    data['postedBy'] = postedBy;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (jobServiceCategories != null) {
      data['jobServiceCategories'] =
          jobServiceCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Location {
  int? id;
  String? street1;
  String? street2;
  String? city;
  String? state;
  String? zipCode;
  String? latitude;
  String? longitude;

  Location(
      {this.id,
        this.street1,
        this.street2,
        this.city,
        this.state,
        this.zipCode,
        this.latitude,
        this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    street1 = json['street1'];
    street2 = json['street2'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zipCode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['street1'] = street1;
    data['street2'] = street2;
    data['city'] = city;
    data['state'] = state;
    data['zipCode'] = zipCode;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}

class JobServiceCategories {
  int? id;
  int? jobId;
  int? serviceCategoryId;
  int? serviceId;
  ServiceCategory? serviceCategory;
  Service? service;

  JobServiceCategories(
      {this.id,
        this.jobId,
        this.serviceCategoryId,
        this.serviceId,
        this.serviceCategory,
        this.service});

  JobServiceCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['jobId'];
    serviceCategoryId = json['serviceCategoryId'];
    serviceId = json['serviceId'];
    serviceCategory = json['serviceCategory'] != null
        ? ServiceCategory.fromJson(json['serviceCategory'])
        : null;
    service =
    json['service'] != null ? Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['jobId'] = jobId;
    data['serviceCategoryId'] = serviceCategoryId;
    data['serviceId'] = serviceId;
    if (serviceCategory != null) {
      data['serviceCategory'] = serviceCategory!.toJson();
    }
    if (service != null) {
      data['service'] = service!.toJson();
    }
    return data;
  }
}

class ServiceCategory {
  int? id;
  String? name;
  String? description;

  ServiceCategory({this.id, this.name, this.description});

  ServiceCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}

class Service {
  int? id;
  String? name;
  String? description;
  int? serviceCategoryId;

  Service({this.id, this.name, this.description, this.serviceCategoryId});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    serviceCategoryId = json['serviceCategoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['serviceCategoryId'] = serviceCategoryId;
    return data;
  }
}

class Session {
  int? id;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;

  Session(
      {this.id, this.startDate, this.endDate, this.startTime, this.endTime});

  Session.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    startTime = json['startTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    return data;
  }
}

class Client {
  int? id;
  String? firstName;
  String? lastName;
  String? profilePicture;
  String? email;
  String? phone;

  Client(
      {this.id,
        this.firstName,
        this.lastName,
        this.profilePicture,
        this.email,
        this.phone});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    profilePicture = json['profilePicture'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['profilePicture'] = profilePicture;
    data['email'] = email;
    data['phone'] = phone;
    return data;
  }
}
