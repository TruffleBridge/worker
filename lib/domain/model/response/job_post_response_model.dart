class JobPostResponseModel {
  bool? status;
  String? message;
  JobPostData? data;

  JobPostResponseModel({this.status, this.message, this.data});

  JobPostResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? JobPostData.fromJson(json['data']) : null;
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

class JobPostData {
  Job? job;
  Location? location;
  List<Sessions>? sessions;
  List<JobServiceCategories>? jobServiceCategories;
  // List<Null>? requiredSkills;
  // List<Null>? preferredLanguages;
  // List<Null>? certifications;

  JobPostData(
      {this.job,
        this.location,
        this.sessions,
        this.jobServiceCategories,
        // this.requiredSkills,
        // this.preferredLanguages,
        // this.certifications,
      });

  JobPostData.fromJson(Map<String, dynamic> json) {
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
    // if (json['requiredSkills'] != null) {
    //   requiredSkills = <Null>[];
    //   json['requiredSkills'].forEach((v) {
    //     requiredSkills!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['preferredLanguages'] != null) {
    //   preferredLanguages = <Null>[];
    //   json['preferredLanguages'].forEach((v) {
    //     preferredLanguages!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['certifications'] != null) {
    //   certifications = <Null>[];
    //   json['certifications'].forEach((v) {
    //     certifications!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    // if (requiredSkills != null) {
    //   data['requiredSkills'] =
    //       requiredSkills!.map((v) => v.toJson()).toList();
    // }
    // if (preferredLanguages != null) {
    //   data['preferredLanguages'] =
    //       preferredLanguages!.map((v) => v.toJson()).toList();
    // }
    // if (certifications != null) {
    //   data['certifications'] =
    //       certifications!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Job {
  int? id;
  String? title;
  String? description;
  String? category;
  String? hourlyRate;
  String? shift;
  int? postedBy;
  String? hoursPerDay;
  String? serviceRequirement;
  String? status;
  String? experienceLevel;
  String? genderPreference;
  bool? isNdisCompliant;
  String? publishStatus;
  String? frequency;
  String? preferredStartDate;
  String? createdAt;
  String? updatedAt;

  Job(
      {this.id,
        this.title,
        this.description,
        this.category,
        this.hourlyRate,
        this.shift,
        this.postedBy,
        this.hoursPerDay,
        this.serviceRequirement,
        this.status,
        this.experienceLevel,
        this.genderPreference,
        this.isNdisCompliant,
        this.publishStatus,
        this.frequency,
        this.preferredStartDate,
        this.createdAt,
        this.updatedAt});

  Job.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    hourlyRate = json['hourlyRate'];
    shift = json['shift'];
    postedBy = json['postedBy'];
    hoursPerDay = json['hoursPerDay'];
    serviceRequirement = json['serviceRequirement'];
    status = json['status'];
    experienceLevel = json['experienceLevel'];
    genderPreference = json['genderPreference'];
    isNdisCompliant = json['isNdisCompliant'];
    publishStatus = json['publishStatus'];
    frequency = json['frequency'];
    preferredStartDate = json['preferredStartDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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
    data['status'] = status;
    data['experienceLevel'] = experienceLevel;
    data['genderPreference'] = genderPreference;
    data['isNdisCompliant'] = isNdisCompliant;
    data['publishStatus'] = publishStatus;
    data['frequency'] = frequency;
    data['preferredStartDate'] = preferredStartDate;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
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
  double? latitude;
  double? longitude;
  int? jobId;
  String? updatedAt;
  String? createdAt;

  Location(
      {this.id,
        this.street1,
        this.street2,
        this.city,
        this.state,
        this.zipCode,
        this.latitude,
        this.longitude,
        this.jobId,
        this.updatedAt,
        this.createdAt});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    street1 = json['street1'];
    street2 = json['street2'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zipCode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    jobId = json['jobId'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
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
    data['jobId'] = jobId;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    return data;
  }
}

class Sessions {
  int? id;
  int? jobId;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? dayOfWeek;
  String? createdAt;
  String? updatedAt;

  Sessions(
      {this.id,
        this.jobId,
        this.startDate,
        this.endDate,
        this.startTime,
        this.endTime,
        this.dayOfWeek,
        this.createdAt,
        this.updatedAt});

  Sessions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['jobId'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    dayOfWeek = json['dayOfWeek'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['jobId'] = jobId;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['dayOfWeek'] = dayOfWeek;
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
