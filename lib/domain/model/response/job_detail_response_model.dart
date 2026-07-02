class JobDetailResponseModel {
  bool? status;
  String? message;
  JobDetailData? data;

  JobDetailResponseModel({this.status, this.message, this.data});

  JobDetailResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? JobDetailData.fromJson(json['data']) : null;
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

class JobDetailData {
  JobDetailJob? job;
  List<Location>? location;
  List<Sessions>? sessions;
  List<JobServiceCategories>? jobServiceCategories;
  ServiceDetails? serviceDetails;
  PostedBy? postedBy;
  JobRequirements? jobRequirements;

  JobDetailData(
      {this.job,
        this.location,
        this.sessions,
        this.jobServiceCategories,
        this.serviceDetails,
        this.postedBy,
        this.jobRequirements});

  JobDetailData.fromJson(Map<String, dynamic> json) {
    job = json['job'] != null ? JobDetailJob.fromJson(json['job']) : null;
    if (json['location'] != null) {
      location = <Location>[];
      json['location'].forEach((v) {
        location!.add(Location.fromJson(v));
      });
    }
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
    serviceDetails = json['serviceDetails'] != null
        ? ServiceDetails.fromJson(json['serviceDetails'])
        : null;
    postedBy = json['postedBy'] != null
        ? PostedBy.fromJson(json['postedBy'])
        : null;
    jobRequirements = json['jobRequirements'] != null
        ? JobRequirements.fromJson(json['jobRequirements'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (job != null) {
      data['job'] = job!.toJson();
    }
    if (location != null) {
      data['location'] = location!.map((v) => v.toJson()).toList();
    }
    if (sessions != null) {
      data['sessions'] = sessions!.map((v) => v.toJson()).toList();
    }
    if (jobServiceCategories != null) {
      data['jobServiceCategories'] =
          jobServiceCategories!.map((v) => v.toJson()).toList();
    }
    if (serviceDetails != null) {
      data['serviceDetails'] = serviceDetails!.toJson();
    }
    if (postedBy != null) {
      data['postedBy'] = postedBy!.toJson();
    }
    if (jobRequirements != null) {
      data['jobRequirements'] = jobRequirements!.toJson();
    }
    return data;
  }
}

class JobDetailJob {
  int? id;
  String? title;
  String? description;
  String? category;
  int? hourlyRate;
  String? shift;
  String? hoursPerDay;
  int? postedBy;
  String? createdAt;
  String? updatedAt;
  int? applicationCount;

  JobDetailJob(
      {this.id,
        this.title,
        this.description,
        this.category,
        this.hourlyRate,
        this.shift,
        this.hoursPerDay,
        this.postedBy,
        this.createdAt,
        this.updatedAt,
        this.applicationCount});

  JobDetailJob.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    hourlyRate = json['hourlyRate'];
    shift = json['shift'];
    hoursPerDay = json['hoursPerDay'];
    postedBy = json['postedBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    applicationCount = json['applicationCount'];
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
    data['postedBy'] = postedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['applicationCount'] = applicationCount;
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
  int? distanceKm;

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
        this.updatedAt,
        this.distanceKm});

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
    distanceKm = json['distanceKm'];
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
    data['distanceKm'] = distanceKm;
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

class ServiceDetails {
  String? matchType;
  Service? service;
  ServiceCategory? serviceCategory;
  List<JobServiceCategories>? jobServiceCategories;

  ServiceDetails(
      {this.matchType,
        this.service,
        this.serviceCategory,
        this.jobServiceCategories});

  ServiceDetails.fromJson(Map<String, dynamic> json) {
    matchType = json['matchType'];
    service =
    json['service'] != null ? Service.fromJson(json['service']) : null;
    serviceCategory = json['serviceCategory'] != null
        ? ServiceCategory.fromJson(json['serviceCategory'])
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
    data['matchType'] = matchType;
    if (service != null) {
      data['service'] = service!.toJson();
    }
    if (serviceCategory != null) {
      data['serviceCategory'] = serviceCategory!.toJson();
    }
    if (jobServiceCategories != null) {
      data['jobServiceCategories'] =
          jobServiceCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PostedBy {
  User? user;
  About? about;

  PostedBy({this.user, this.about});

  PostedBy.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    about = json['about'] != null ? About.fromJson(json['about']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (about != null) {
      data['about'] = about!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? profilePicture;
  String? authProvider;
  bool? emailVerified;

  User(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.profilePicture,
        this.authProvider,
        this.emailVerified});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    profilePicture = json['profilePicture'];
    authProvider = json['authProvider'];
    emailVerified = json['emailVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['profilePicture'] = profilePicture;
    data['authProvider'] = authProvider;
    data['emailVerified'] = emailVerified;
    return data;
  }
}

class About {
  int? yearsOfExperience;
  String? professionalBio;
  String? experienceInfo;
  bool? newClientAvailability;
  String? degree;
  String? speciality;

  About(
      {this.yearsOfExperience,
        this.professionalBio,
        this.experienceInfo,
        this.newClientAvailability,
        this.degree,
        this.speciality});

  About.fromJson(Map<String, dynamic> json) {
    yearsOfExperience = json['yearsOfExperience'];
    professionalBio = json['professionalBio'];
    experienceInfo = json['experienceInfo'];
    newClientAvailability = json['newClientAvailability'];
    degree = json['degree'];
    speciality = json['speciality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['yearsOfExperience'] = yearsOfExperience;
    data['professionalBio'] = professionalBio;
    data['experienceInfo'] = experienceInfo;
    data['newClientAvailability'] = newClientAvailability;
    data['degree'] = degree;
    data['speciality'] = speciality;
    return data;
  }
}

class JobRequirements {
  String? serviceRequirement;
  String? description;
  String? hoursPerDay;
  String? shift;
  int? hourlyRate;
  List<Sessions>? sessions;

  JobRequirements(
      {this.serviceRequirement,
        this.description,
        this.hoursPerDay,
        this.shift,
        this.hourlyRate,
        this.sessions});

  JobRequirements.fromJson(Map<String, dynamic> json) {
    serviceRequirement = json['serviceRequirement'];
    description = json['description'];
    hoursPerDay = json['hoursPerDay'];
    shift = json['shift'];
    hourlyRate = json['hourlyRate'];
    if (json['sessions'] != null) {
      sessions = <Sessions>[];
      json['sessions'].forEach((v) {
        sessions!.add(Sessions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['serviceRequirement'] = serviceRequirement;
    data['description'] = description;
    data['hoursPerDay'] = hoursPerDay;
    data['shift'] = shift;
    data['hourlyRate'] = hourlyRate;
    if (sessions != null) {
      data['sessions'] = sessions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
