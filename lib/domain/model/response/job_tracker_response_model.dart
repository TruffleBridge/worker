class JobTrackerResponseModel {
  bool? status;
  String? message;
  Data? data;

  JobTrackerResponseModel({this.status, this.message, this.data});

  JobTrackerResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? search;
  int? applicationStatusId;

  Filters({this.search, this.applicationStatusId});

  Filters.fromJson(Map<String, dynamic> json) {
    search = json['search'];
    applicationStatusId = json['applicationStatusId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['search'] = search;
    data['applicationStatusId'] = applicationStatusId;
    return data;
  }
}

class Jobs {
  Application? application;
  Job? job;
  Location? location;
  List<Sessions>? sessions;
  List<JobServiceCategories>? jobServiceCategories;
  PostedBy? postedBy;

  Jobs(
      {this.application,
        this.job,
        this.location,
        this.sessions,
        this.jobServiceCategories,
        this.postedBy});

  Jobs.fromJson(Map<String, dynamic> json) {
    application = json['application'] != null
        ? Application.fromJson(json['application'])
        : null;
    job = json['job'] != null ? Job.fromJson(json['job']) : null;
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
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
    postedBy = json['postedBy'] != null
        ? PostedBy.fromJson(json['postedBy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (application != null) {
      data['application'] = application!.toJson();
    }
    if (job != null) {
      data['job'] = job!.toJson();
    }
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
    if (postedBy != null) {
      data['postedBy'] = postedBy!.toJson();
    }
    return data;
  }
}

class Application {
  int? id;
  int? applicationStatusId;
  ApplicationStatus? applicationStatus;
  String? appliedAt;
  String? updatedAt;

  Application(
      {this.id,
        this.applicationStatusId,
        this.applicationStatus,
        this.appliedAt,
        this.updatedAt});

  Application.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    applicationStatusId = json['applicationStatusId'];
    applicationStatus = json['applicationStatus'] != null
        ? ApplicationStatus.fromJson(json['applicationStatus'])
        : null;
    appliedAt = json['appliedAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['applicationStatusId'] = applicationStatusId;
    if (applicationStatus != null) {
      data['applicationStatus'] = applicationStatus!.toJson();
    }
    data['appliedAt'] = appliedAt;
    data['updatedAt'] = updatedAt;
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

class Job {
  int? id;
  String? title;
  String? description;
  String? category;
  int? hourlyRate;
  String? shift;
  String? hoursPerDay;
  String? serviceRequirement;
  int? postedBy;
  String? createdAt;
  String? updatedAt;
  List<JobServiceCategories>? jobServiceCategories;

  Job(
      {this.id,
        this.title,
        this.description,
        this.category,
        this.hourlyRate,
        this.shift,
        this.hoursPerDay,
        this.serviceRequirement,
        this.postedBy,
        this.createdAt,
        this.updatedAt,
        this.jobServiceCategories});

  Job.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    hourlyRate = json['hourlyRate'];
    shift = json['shift'];
    hoursPerDay = json['hoursPerDay'];
    serviceRequirement = json['serviceRequirement'];
    postedBy = json['postedBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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
    data['hoursPerDay'] = hoursPerDay;
    data['serviceRequirement'] = serviceRequirement;
    data['postedBy'] = postedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (jobServiceCategories != null) {
      data['jobServiceCategories'] =
          jobServiceCategories!.map((v) => v.toJson()).toList();
    }
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

class Location {
  int? id;
  int? jobId;
  String? street1;
  String? street2;
  String? city;
  String? state;
  String? zipCode;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;

  Location(
      {this.id,
        this.jobId,
        this.street1,
        this.street2,
        this.city,
        this.state,
        this.zipCode,
        this.latitude,
        this.longitude,
        this.createdAt,
        this.updatedAt});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['jobId'];
    street1 = json['street1'];
    street2 = json['street2'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zipCode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
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

  Sessions(
      {this.id,
        this.jobId,
        this.startTime,
        this.endTime,
        this.startDate,
        this.endDate,
        this.createdAt,
        this.updatedAt});

  Sessions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['jobId'];
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

class PostedBy {
  int? id;
  String? firstName;
  String? lastName;
  String? profilePicture;

  PostedBy({this.id, this.firstName, this.lastName, this.profilePicture});

  PostedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    profilePicture = json['profilePicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['profilePicture'] = profilePicture;
    return data;
  }
}
