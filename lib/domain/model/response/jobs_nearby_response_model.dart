class JobsNearbyResponseModel {
  bool? status;
  String? message;
  Data? data;

  JobsNearbyResponseModel({this.status, this.message, this.data});

  JobsNearbyResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  int? totalCount;
  Pagination? pagination;
  Filters? filters;
  List<Jobs>? jobs;

  Data({this.totalCount, this.pagination, this.filters, this.jobs});

  Data.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    filters =
    json['filters'] != null ? Filters.fromJson(json['filters']) : null;

    if (json['jobs'] != null) {
      jobs = <Jobs>[];
      json['jobs'].forEach((v) {
        jobs!.add(Jobs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalCount'] = totalCount;
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    if (filters != null) {
      data['filters'] = filters!.toJson();
    }
    if (jobs != null) {
      data['jobs'] = jobs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pagination {
  int? page;
  int? limit;
  int? totalPages;

  Pagination({this.page, this.limit, this.totalPages});

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['limit'] = limit;
    data['totalPages'] = totalPages;
    return data;
  }
}

class Filters {
  String? locationType;
  String? resolvedFrom;
  double? latitude;
  double? longitude;
  int? radiusKm;

  Filters({
    this.locationType,
    this.resolvedFrom,
    this.latitude,
    this.longitude,
    this.radiusKm,
  });

  Filters.fromJson(Map<String, dynamic> json) {
    locationType = json['locationType'];
    resolvedFrom = json['resolvedFrom'];
    latitude = _toDouble(json['latitude']);
    longitude = _toDouble(json['longitude']);
    radiusKm = _toInt(json['radiusKm']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['locationType'] = locationType;
    data['resolvedFrom'] = resolvedFrom;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['radiusKm'] = radiusKm;
    return data;
  }
}

class Jobs {
  int? id;
  String? title;
  String? description;
  String? category;
  int? hourlyRate;
  String? shift;
  int? postedBy;
  String? hoursPerDay;
  String? serviceRequirement;
  String? createdAt;
  String? updatedAt;
  int? distanceKm;
  int? applicationCount;
  Location? location;
  List<Sessions>? sessions;
  List<JobServiceCategories>? jobServiceCategories;

  Jobs({
    this.id,
    this.title,
    this.description,
    this.category,
    this.hourlyRate,
    this.shift,
    this.postedBy,
    this.hoursPerDay,
    this.serviceRequirement,
    this.createdAt,
    this.updatedAt,
    this.distanceKm,
    this.applicationCount,
    this.location,
    this.sessions,
    this.jobServiceCategories,
  });

  Jobs.fromJson(Map<String, dynamic> json) {
    id = _toInt(json['id']);
    title = json['title'];
    description = json['description'];
    category = json['category'];
    hourlyRate = _toInt(json['hourlyRate']);
    shift = json['shift'];
    postedBy = _toInt(json['postedBy']);
    hoursPerDay = json['hoursPerDay']?.toString();
    serviceRequirement = json['serviceRequirement'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    distanceKm = _toInt(json['distanceKm']);
    applicationCount = _toInt(json['applicationCount']);

    location =
    json['location'] != null ? Location.fromJson(json['location']) : null;

    if (json['sessions'] != null) {
      sessions = <Sessions>[];
      json['sessions'].forEach((v) {
        sessions!.add(Sessions.fromJson(v));
      });
    }

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
    data['hoursPerDay'] = hoursPerDay;
    data['serviceRequirement'] = serviceRequirement;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['distanceKm'] = distanceKm;
    data['applicationCount'] = applicationCount;

    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (sessions != null) {
      data['sessions'] = sessions!.map((v) => v.toJson()).toList();
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
  int? jobId;
  String? street1;
  String? street2;
  String? city;
  String? state;
  String? zipCode;
  double? latitude;
  double? longitude;

  Location({
    this.id,
    this.jobId,
    this.street1,
    this.street2,
    this.city,
    this.state,
    this.zipCode,
    this.latitude,
    this.longitude,
  });

  Location.fromJson(Map<String, dynamic> json) {
    id = _toInt(json['id']);
    jobId = _toInt(json['jobId']);
    street1 = json['street1'];
    street2 = json['street2'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zipCode'];
    latitude = _toDouble(json['latitude']);
    longitude = _toDouble(json['longitude']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['jobId'] = jobId;
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

class Sessions {
  int? id;
  int? jobId;
  String? startTime;
  String? endTime;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;

  Sessions({
    this.id,
    this.jobId,
    this.startTime,
    this.endTime,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.updatedAt,
  });

  Sessions.fromJson(Map<String, dynamic> json) {
    id = _toInt(json['id']);
    jobId = _toInt(json['jobId']);
    startTime = json['startTime'];
    endTime = json['endTime'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['jobId'] = jobId;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
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

  JobServiceCategories({
    this.id,
    this.jobId,
    this.serviceCategoryId,
    this.serviceId,
    this.serviceCategory,
    this.service,
  });

  JobServiceCategories.fromJson(Map<String, dynamic> json) {
    id = _toInt(json['id']);
    jobId = _toInt(json['jobId']);
    serviceCategoryId = _toInt(json['serviceCategoryId']);
    serviceId = _toInt(json['serviceId']);
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
    id = _toInt(json['id']);
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
    id = _toInt(json['id']);
    name = json['name'];
    description = json['description'];
    serviceCategoryId = _toInt(json['serviceCategoryId']);
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

/// helpers
int? _toInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is double) return value.round();
  return double.tryParse(value.toString())?.round();
}

double? _toDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  return double.tryParse(value.toString());
}