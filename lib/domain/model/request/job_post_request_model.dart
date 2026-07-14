class JobPostRequestModel {
  String? title;
  String? description;
  String? category;
  int? serviceCategoryId;
  int? serviceId;
  int? hourlyRate;
  String? shift;
  int? hoursPerDay;
  String? serviceRequirement;
  JobPostLocation? location;
  List<JobPostSessions>? sessions;

  JobPostRequestModel(
      {this.title,
        this.description,
        this.category,
        this.serviceCategoryId,
        this.serviceId,
        this.hourlyRate,
        this.shift,
        this.hoursPerDay,
        this.serviceRequirement,
        this.location,
        this.sessions});

  JobPostRequestModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    category = json['category'];
    serviceCategoryId = json['serviceCategoryId'];
    serviceId = json['serviceId'];
    hourlyRate = json['hourlyRate'];
    shift = json['shift'];
    hoursPerDay = json['hoursPerDay'];
    serviceRequirement = json['serviceRequirement'];
    location = json['location'] != null
        ? JobPostLocation.fromJson(json['location'])
        : null;
    if (json['sessions'] != null) {
      sessions = <JobPostSessions>[];
      json['sessions'].forEach((v) {
        sessions!.add(JobPostSessions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['category'] = category;
    data['serviceCategoryId'] = serviceCategoryId;
    data['serviceId'] = serviceId;
    data['hourlyRate'] = hourlyRate;
    data['shift'] = shift;
    data['hoursPerDay'] = hoursPerDay;
    data['serviceRequirement'] = serviceRequirement;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (sessions != null) {
      data['sessions'] = sessions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JobPostLocation {
  String? street1;
  String? city;
  String? state;
  String? zipCode;
  double? latitude;
  double? longitude;

  JobPostLocation(
      {this.street1,
        this.city,
        this.state,
        this.zipCode,
        this.latitude,
        this.longitude});

  JobPostLocation.fromJson(Map<String, dynamic> json) {
    street1 = json['street1'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zipCode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['street1'] = street1;
    data['city'] = city;
    data['state'] = state;
    data['zipCode'] = zipCode;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}

class JobPostSessions {
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  List<TimeSlots>? timeSlots;

  JobPostSessions(
      {this.startDate,
        this.endDate,
        this.startTime,
        this.endTime,
        this.timeSlots});

  JobPostSessions.fromJson(Map<String, dynamic> json) {
    startDate = json['startDate'];
    endDate = json['endDate'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    if (json['timeSlots'] != null) {
      timeSlots = <TimeSlots>[];
      json['timeSlots'].forEach((v) {
        timeSlots!.add(TimeSlots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    if (timeSlots != null) {
      data['timeSlots'] = timeSlots!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimeSlots {
  String? startTime;
  String? endTime;

  TimeSlots({this.startTime, this.endTime});

  TimeSlots.fromJson(Map<String, dynamic> json) {
    startTime = json['startTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    return data;
  }
}
