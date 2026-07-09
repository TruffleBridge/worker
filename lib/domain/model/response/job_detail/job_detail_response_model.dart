class ClientJobDetailResponseModel {
  final bool? status;
  final String? message;
  final JobDetailData? data;

  ClientJobDetailResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory ClientJobDetailResponseModel.fromJson(Map<String, dynamic> json) {
    return ClientJobDetailResponseModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? JobDetailData.fromJson(json['data'])
          : null,
    );
  }
}

class JobDetailData {
  final JobModel? job;
  final List<LocationModel>? location;
  final List<SessionModel>? sessions;
  final List<JobServiceCategoryModel>? jobServiceCategories;
  final ServiceDetailsModel? serviceDetails;
  final PostedByModel? postedBy;
  final JobRequirementsModel? jobRequirements;

  JobDetailData({
    this.job,
    this.location,
    this.sessions,
    this.jobServiceCategories,
    this.serviceDetails,
    this.postedBy,
    this.jobRequirements,
  });

  factory JobDetailData.fromJson(Map<String, dynamic> json) {
    return JobDetailData(
      job: json['job'] != null
          ? JobModel.fromJson(json['job'])
          : null,
      location: (json['location'] as List?)
          ?.map((e) => LocationModel.fromJson(e))
          .toList(),
      sessions: (json['sessions'] as List?)
          ?.map((e) => SessionModel.fromJson(e))
          .toList(),
      jobServiceCategories:
      (json['jobServiceCategories'] as List?)
          ?.map((e) => JobServiceCategoryModel.fromJson(e))
          .toList(),
      serviceDetails: json['serviceDetails'] != null
          ? ServiceDetailsModel.fromJson(json['serviceDetails'])
          : null,
      postedBy: json['postedBy'] != null
          ? PostedByModel.fromJson(json['postedBy'])
          : null,
      jobRequirements: json['jobRequirements'] != null
          ? JobRequirementsModel.fromJson(json['jobRequirements'])
          : null,
    );
  }
}
class JobModel {
  final int? id;
  final String? title;
  final String? description;
  final String? category;
  final String? hourlyRate;
  final String? shift;
  final String? hoursPerDay;
  final int? postedBy;
  final String? createdAt;
  final String? updatedAt;
  final int? applicationCount;

  JobModel({
    this.id,
    this.title,
    this.description,
    this.category,
    this.hourlyRate,
    this.shift,
    this.hoursPerDay,
    this.postedBy,
    this.createdAt,
    this.updatedAt,
    this.applicationCount,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      hourlyRate: json['hourlyRate'],
      shift: json['shift'],
      hoursPerDay: json['hoursPerDay'],
      postedBy: json['postedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      applicationCount: json['applicationCount'],
    );
  }
}
class LocationModel {
  final int? id;
  final int? jobId;
  final String? street1;
  final String? street2;
  final String? city;
  final String? state;
  final String? zipCode;
  final String? latitude;
  final String? longitude;
  final String? createdAt;
  final String? updatedAt;
  final dynamic distanceKm;

  LocationModel({
    this.id,
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
    this.distanceKm,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json["id"],
      jobId: json["jobId"],
      street1: json["street1"],
      street2: json["street2"],
      city: json["city"],
      state: json["state"],
      zipCode: json["zipCode"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
      distanceKm: json["distanceKm"],
    );
  }
}

class SessionModel {
  final int? id;
  final int? jobId;
  final String? startTime;
  final String? endTime;
  final String? startDate;
  final String? endDate;
  final String? dayOfWeek;
  final String? createdAt;
  final String? updatedAt;

  SessionModel({
    this.id,
    this.jobId,
    this.startTime,
    this.endTime,
    this.startDate,
    this.endDate,
    this.dayOfWeek,
    this.createdAt,
    this.updatedAt,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json["id"],
      jobId: json["jobId"],
      startTime: json["startTime"],
      endTime: json["endTime"],
      startDate: json["startDate"],
      endDate: json["endDate"],
      dayOfWeek: json["dayOfWeek"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
    );
  }
}

class ServiceCategoryModel {
  final int? id;
  final String? name;
  final String? description;

  ServiceCategoryModel({
    this.id,
    this.name,
    this.description,
  });

  factory ServiceCategoryModel.fromJson(Map<String, dynamic> json) {
    return ServiceCategoryModel(
      id: json["id"],
      name: json["name"],
      description: json["description"],
    );
  }
}

class JobServiceCategoryModel {
  final int? id;
  final int? jobId;
  final int? serviceCategoryId;
  final int? serviceId;
  final ServiceCategoryModel? serviceCategory;
  final ServiceModel? service;

  JobServiceCategoryModel({
    this.id,
    this.jobId,
    this.serviceCategoryId,
    this.serviceId,
    this.serviceCategory,
    this.service,
  });

  factory JobServiceCategoryModel.fromJson(Map<String, dynamic> json) {
    return JobServiceCategoryModel(
      id: json["id"],
      jobId: json["jobId"],
      serviceCategoryId: json["serviceCategoryId"],
      serviceId: json["serviceId"],
      serviceCategory: json["serviceCategory"] != null
          ? ServiceCategoryModel.fromJson(json["serviceCategory"])
          : null,
      service: json["service"] != null
          ? ServiceModel.fromJson(json["service"])
          : null,
    );
  }
}

class ServiceDetailsModel {
  final String? matchType;
  final ServiceModel? service;
  final ServiceCategoryModel? serviceCategory;
  final List<JobServiceCategoryModel>? jobServiceCategories;

  ServiceDetailsModel({
    this.matchType,
    this.service,
    this.serviceCategory,
    this.jobServiceCategories,
  });

  factory ServiceDetailsModel.fromJson(Map<String, dynamic> json) {
    return ServiceDetailsModel(
      matchType: json["matchType"],
      service: json["service"] != null
          ? ServiceModel.fromJson(json["service"])
          : null,
      serviceCategory: json["serviceCategory"] != null
          ? ServiceCategoryModel.fromJson(json["serviceCategory"])
          : null,
      jobServiceCategories: (json["jobServiceCategories"] as List?)
          ?.map((e) => JobServiceCategoryModel.fromJson(e))
          .toList(),
    );
  }
}
class UserInfoModel {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? profilePicture;
  final String? authProvider;
  final bool? emailVerified;

  UserInfoModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.profilePicture,
    this.authProvider,
    this.emailVerified,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      phone: json["phone"],
      profilePicture: json["profilePicture"],
      authProvider: json["authProvider"],
      emailVerified: json["emailVerified"],
    );
  }
}

class PostedByModel {
  final UserInfoModel? user;
  final dynamic about;

  PostedByModel({
    this.user,
    this.about,
  });

  factory PostedByModel.fromJson(Map<String, dynamic> json) {
    return PostedByModel(
      user: json["user"] != null
          ? UserInfoModel.fromJson(json["user"])
          : null,
      about: json["about"],
    );
  }
}
class JobRequirementsModel {
  final String? serviceRequirement;
  final String? description;
  final String? hoursPerDay;
  final String? shift;
  final String? hourlyRate;
  final List<SessionModel>? sessions;

  JobRequirementsModel({
    this.serviceRequirement,
    this.description,
    this.hoursPerDay,
    this.shift,
    this.hourlyRate,
    this.sessions,
  });

  factory JobRequirementsModel.fromJson(Map<String, dynamic> json) {
    return JobRequirementsModel(
      serviceRequirement: json["serviceRequirement"],
      description: json["description"],
      hoursPerDay: json["hoursPerDay"],
      shift: json["shift"],
      hourlyRate: json["hourlyRate"],
      sessions: (json["sessions"] as List?)
          ?.map((e) => SessionModel.fromJson(e))
          .toList(),
    );
  }
}
class ServiceModel {
  final int? id;
  final String? name;
  final String? description;
  final int? serviceCategoryId;

  ServiceModel({
    this.id,
    this.name,
    this.description,
    this.serviceCategoryId,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      serviceCategoryId: json['serviceCategoryId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "serviceCategoryId": serviceCategoryId,
    };
  }
}
