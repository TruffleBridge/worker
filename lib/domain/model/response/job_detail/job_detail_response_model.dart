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
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? JobDetailData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class JobDetailData {
  final JobModel? job;
  final LocationModel? location;
  final dynamic schedule;
  final SessionsResponse? sessions;
  final List<String> serviceRequirements;
  final List<String> requiredSkills;
  final List<String> preferredLanguages;
  final List<String> certifications;
  final ApplicantsResponse? applicants;

  // Optional fallbacks for old API shape
  // final List<JobServiceCategoryModel>? jobServiceCategories;
  // final ServiceDetailsModel? serviceDetails;
  // final PostedByModel? postedBy;


  JobDetailData({
    this.job,
    this.location,
    this.schedule,
    this.sessions,
    this.serviceRequirements = const [],
    this.requiredSkills = const [],
    this.preferredLanguages = const [],
    this.certifications = const [],
    this.applicants,
    // this.jobServiceCategories,
    // this.serviceDetails,
    // this.postedBy,

  });

  /// Convenience getter for UI — always returns a flat session list
  List<SessionModel> get sessionItems => sessions?.items ?? [];

  factory JobDetailData.fromJson(Map<String, dynamic> json) {
    return JobDetailData(
      job: json['job'] != null
          ? JobModel.fromJson(json['job'] as Map<String, dynamic>)
          : null,
      location: _parseLocation(json['location']),
      schedule: json['schedule'],
      sessions: _parseSessions(json['sessions']),
      serviceRequirements: _parseStringList(json['serviceRequirements']),
      requiredSkills: _parseStringList(json['requiredSkills']),
      preferredLanguages: _parseStringList(json['preferredLanguages']),
      certifications: _parseStringList(json['certifications']),
      applicants: json['applicants'] is Map<String, dynamic>
          ? ApplicantsResponse.fromJson(json['applicants'] as Map<String, dynamic>)
          : null,
      // jobServiceCategories: _parseJobServiceCategories(json),
      // serviceDetails: json['serviceDetails'] is Map<String, dynamic>
      //     ? ServiceDetailsModel.fromJson(
      //   json['serviceDetails'] as Map<String, dynamic>,
      // )
      //     : null,
      // postedBy: json['postedBy'] is Map<String, dynamic>
      //     ? PostedByModel.fromJson(json['postedBy'] as Map<String, dynamic>)
      //     : null,
    );
  }

  static LocationModel? _parseLocation(dynamic locationJson) {
    if (locationJson is Map<String, dynamic>) {
      return LocationModel.fromJson(locationJson);
    }
    if (locationJson is List && locationJson.isNotEmpty) {
      return LocationModel.fromJson(locationJson.first as Map<String, dynamic>);
    }
    return null;
  }

  static SessionsResponse? _parseSessions(dynamic sessionsJson) {
    if (sessionsJson is Map<String, dynamic>) {
      return SessionsResponse.fromJson(sessionsJson);
    }
    if (sessionsJson is List) {
      return SessionsResponse(
        totalCount: sessionsJson.length,
        items: sessionsJson
            .map((e) => SessionModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    }
    return null;
  }

  static List<String> _parseStringList(dynamic value) {
    if (value is List) {
      return value.map((e) => e.toString()).toList();
    }
    return [];
  }

  // static List<JobServiceCategoryModel>? _parseJobServiceCategories(
  //     Map<String, dynamic> json,
  //     ) {
  //   final fromJob = (json['job'] as Map<String, dynamic>?)?['jobServiceCategories'];
  //   if (fromJob is List) {
  //     return fromJob
  //         .map(
  //           (e) => JobServiceCategoryModel.fromJson(e as Map<String, dynamic>),
  //     )
  //         .toList();
  //   }
  //
  //   final topLevel = json['jobServiceCategories'];
  //   if (topLevel is List) {
  //     return topLevel
  //         .map(
  //           (e) => JobServiceCategoryModel.fromJson(e as Map<String, dynamic>),
  //     )
  //         .toList();
  //   }
  //
  //   return null;
  // }
}

class JobModel {
  final int? id;
  final String? jobNumber;
  final String? title;
  final String? description;
  final String? location;
  final String? postedTime;
  final List<String> tags;
  final String? hourlyRate;
  final String? payRate;
  final String? shift;
  final String? hoursPerDay;
  final String? status;
  final String? publishStatus;
  final dynamic experienceLevel;
  final String? experienceLevelLabel;
  final String? genderPreference;
  final bool? isNdisCompliant;
  final dynamic frequency;
  final String? frequencyLabel;
  final String? preferredStartDate;
  final String? serviceType;
  final int? applicantCount;
  final List<ApplicantPreviewModel> applicantPreview;
  // final List<JobServiceCategoryModel> jobServiceCategories;
  final String? createdAt;
  final String? updatedAt;

  JobModel({
    this.id,
    this.jobNumber,
    this.title,
    this.description,
    this.location,
    this.postedTime,
    this.tags = const [],
    this.hourlyRate,
    this.payRate,
    this.shift,
    this.hoursPerDay,
    this.status,
    this.publishStatus,
    this.experienceLevel,
    this.experienceLevelLabel,
    this.genderPreference,
    this.isNdisCompliant,
    this.frequency,
    this.frequencyLabel,
    this.preferredStartDate,
    this.serviceType,
    this.applicantCount,
    this.applicantPreview = const [],
    // this.jobServiceCategories = const [],
    this.createdAt,
    this.updatedAt,
  });

  /// Backward-compatible alias for old UI code
  int? get applicationCount => applicantCount;

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'] as int?,
      jobNumber: json['jobNumber'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      location: json['location'] as String?,
      postedTime: json['postedTime'] as String?,
      tags: (json['tags'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      hourlyRate: json['hourlyRate']?.toString(),
      payRate: json['payRate'] as String?,
      shift: json['shift'] as String?,
      hoursPerDay: json['hoursPerDay']?.toString(),
      status: json['status'] as String?,
      publishStatus: json['publishStatus'] as String?,
      experienceLevel: json['experienceLevel'],
      experienceLevelLabel: json['experienceLevelLabel'] as String?,
      genderPreference: json['genderPreference'] as String?,
      isNdisCompliant: json['isNdisCompliant'] as bool?,
      frequency: json['frequency'],
      frequencyLabel: json['frequencyLabel'] as String?,
      preferredStartDate: json['preferredStartDate'] as String?,
      serviceType: json['serviceType'] as String?,
      applicantCount: json['applicantCount'] as int? ??
          json['applicationCount'] as int?,
      applicantPreview: (json['applicantPreview'] as List<dynamic>? ?? [])
          .map(
            (e) => ApplicantPreviewModel.fromJson(e as Map<String, dynamic>),
      )
          .toList(),
      // jobServiceCategories:
      // (json['jobServiceCategories'] as List<dynamic>? ?? [])
      //     .map(
      //       (e) =>
      //       JobServiceCategoryModel.fromJson(e as Map<String, dynamic>),
      // )
      //     .toList(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }
}

class ApplicantPreviewModel {
  final int? id;
  final String? profilePicture;

  ApplicantPreviewModel({
    this.id,
    this.profilePicture,
  });

  factory ApplicantPreviewModel.fromJson(Map<String, dynamic> json) {
    return ApplicantPreviewModel(
      id: json['id'] as int?,
      profilePicture: json['profilePicture'] as String?,
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
      id: json['id'] as int?,
      jobId: json['jobId'] as int?,
      street1: json['street1'] as String?,
      street2: json['street2'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      zipCode: json['zipCode'] as String?,
      latitude: json['latitude']?.toString(),
      longitude: json['longitude']?.toString(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      distanceKm: json['distanceKm'],
    );
  }
}

class SessionsResponse {
  final int? totalCount;
  final List<SessionModel> items;

  SessionsResponse({
    this.totalCount,
    this.items = const [],
  });

  factory SessionsResponse.fromJson(Map<String, dynamic> json) {
    return SessionsResponse(
      totalCount: json['totalCount'] as int?,
      items: (json['items'] as List<dynamic>? ?? [])
          .map((e) => SessionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class SessionModel {
  final int? id;
  final int? jobId;
  final String? title;
  final String? timeRange;
  final String? startDate;
  final String? endDate;
  final String? startTime;
  final String? endTime;
  final String? dayOfWeek;
  final String? dayName;
  final String? createdAt;
  final String? updatedAt;

  SessionModel({
    this.id,
    this.jobId,
    this.title,
    this.timeRange,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.dayOfWeek,
    this.dayName,
    this.createdAt,
    this.updatedAt,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id'] as int?,
      jobId: json['jobId'] as int?,
      title: json['title'] as String?,
      timeRange: json['timeRange'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      dayOfWeek: json['dayOfWeek'] as String?,
      dayName: json['dayName'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }
}

class ApplicantsResponse {
  final int? totalCount;
  final PaginationModel? pagination;
  final List<ApplicantModel> items;

  ApplicantsResponse({
    this.totalCount,
    this.pagination,
    this.items = const [],
  });

  factory ApplicantsResponse.fromJson(Map<String, dynamic> json) {
    return ApplicantsResponse(
      totalCount: json['totalCount'] as int?,
      pagination: json['pagination'] is Map<String, dynamic>
          ? PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>)
          : null,
      items: (json['items'] as List<dynamic>? ?? [])
          .map((e) => ApplicantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class PaginationModel {
  final int? page;
  final int? limit;
  final int? totalPages;

  PaginationModel({
    this.page,
    this.limit,
    this.totalPages,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      page: json['page'] as int?,
      limit: json['limit'] as int?,
      totalPages: json['totalPages'] as int?,
    );
  }
}

class ApplicantModel {
  final int? applicationId;
  final int? userId;
  final String? fullName;
  final String? profilePicture;
  final dynamic availability;
  final dynamic location;
  final dynamic distanceKm;
  final String? distanceLabel;
  final String? appliedAt;
  final ApplicationStatusModel? applicationStatus;

  ApplicantModel({
    this.applicationId,
    this.userId,
    this.fullName,
    this.profilePicture,
    this.availability,
    this.location,
    this.distanceKm,
    this.distanceLabel,
    this.appliedAt,
    this.applicationStatus,
  });

  factory ApplicantModel.fromJson(Map<String, dynamic> json) {
    return ApplicantModel(
      applicationId: json['applicationId'] as int?,
      userId: json['userId'] as int?,
      fullName: json['fullName'] as String?,
      profilePicture: json['profilePicture'] as String?,
      availability: json['availability'],
      location: json['location'],
      distanceKm: json['distanceKm'],
      distanceLabel: json['distanceLabel'] as String?,
      appliedAt: json['appliedAt'] as String?,
      applicationStatus: json['applicationStatus'] is Map<String, dynamic>
          ? ApplicationStatusModel.fromJson(
        json['applicationStatus'] as Map<String, dynamic>,
      )
          : null,
    );
  }
}

class ApplicationStatusModel {
  final int? id;
  final String? name;

  ApplicationStatusModel({
    this.id,
    this.name,
  });

  factory ApplicationStatusModel.fromJson(Map<String, dynamic> json) {
    return ApplicationStatusModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }
}

//
// class ServiceCategoryModel {
//   final int? id;
//   final String? name;
//   final String? description;
//
//   ServiceCategoryModel({
//     this.id,
//     this.name,
//     this.description,
//   });
//
//   factory ServiceCategoryModel.fromJson(Map<String, dynamic> json) {
//     return ServiceCategoryModel(
//       id: json['id'] as int?,
//       name: json['name'] as String?,
//       description: json['description'] as String?,
//     );
//   }
// }

// class JobServiceCategoryModel {
//   final int? id;
//   final int? jobId;
//   final int? serviceCategoryId;
//   final int? serviceId;
//   final ServiceCategoryModel? serviceCategory;
//   final ServiceModel? service;
//
//   JobServiceCategoryModel({
//     this.id,
//     this.jobId,
//     this.serviceCategoryId,
//     this.serviceId,
//     this.serviceCategory,
//     this.service,
//   });
//
//   factory JobServiceCategoryModel.fromJson(Map<String, dynamic> json) {
//     return JobServiceCategoryModel(
//       id: json['id'] as int?,
//       jobId: json['jobId'] as int?,
//       serviceCategoryId: json['serviceCategoryId'] as int?,
//       serviceId: json['serviceId'] as int?,
//       serviceCategory: json['serviceCategory'] is Map<String, dynamic>
//           ? ServiceCategoryModel.fromJson(
//         json['serviceCategory'] as Map<String, dynamic>,
//       )
//           : null,
//       service: json['service'] is Map<String, dynamic>
//           ? ServiceModel.fromJson(json['service'] as Map<String, dynamic>)
//           : null,
//     );
//   }
// }

// class ServiceDetailsModel {
//   final String? matchType;
//   final ServiceModel? service;
//   final ServiceCategoryModel? serviceCategory;
  // final List<JobServiceCategoryModel>? jobServiceCategories;

//   ServiceDetailsModel({
//     this.matchType,
//     this.service,
//     this.serviceCategory,
//     // this.jobServiceCategories,
//   });
//
//   factory ServiceDetailsModel.fromJson(Map<String, dynamic> json) {
//     return ServiceDetailsModel(
//       matchType: json['matchType'] as String?,
//       service: json['service'] is Map<String, dynamic>
//           ? ServiceModel.fromJson(json['service'] as Map<String, dynamic>)
//           : null,
//       serviceCategory: json['serviceCategory'] is Map<String, dynamic>
//           ? ServiceCategoryModel.fromJson(
//         json['serviceCategory'] as Map<String, dynamic>,
//       )
//           : null,
//       // jobServiceCategories: (json['jobServiceCategories'] as List<dynamic>?)
//       //     ?.map(
//       //       (e) => JobServiceCategoryModel.fromJson(e as Map<String, dynamic>),
//       // )
//       //     .toList(),
//     );
//   }
// }
//
// class UserInfoModel {
//   final int? id;
//   final String? firstName;
//   final String? lastName;
//   final String? email;
//   final String? phone;
//   final String? profilePicture;
//   final String? authProvider;
//   final bool? emailVerified;
//
//   UserInfoModel({
//     this.id,
//     this.firstName,
//     this.lastName,
//     this.email,
//     this.phone,
//     this.profilePicture,
//     this.authProvider,
//     this.emailVerified,
//   });
//
//   factory UserInfoModel.fromJson(Map<String, dynamic> json) {
//     return UserInfoModel(
//       id: json['id'] as int?,
//       firstName: json['firstName'] as String?,
//       lastName: json['lastName'] as String?,
//       email: json['email'] as String?,
//       phone: json['phone'] as String?,
//       profilePicture: json['profilePicture'] as String?,
//       authProvider: json['authProvider'] as String?,
//       emailVerified: json['emailVerified'] as bool?,
//     );
//   }
//    }
//
// class PostedByModel {
//   final UserInfoModel? user;
//   final dynamic about;
//
//   PostedByModel({
//     this.user,
//     this.about,
//   });
//
//   factory PostedByModel.fromJson(Map<String, dynamic> json) {
//     return PostedByModel(
//       user: json['user'] is Map<String, dynamic>
//           ? UserInfoModel.fromJson(json['user'] as Map<String, dynamic>)
//           : null,
//       about: json['about'],
//     );
//   }
// }

//
// class ServiceModel {
//   final int? id;
//   final String? name;
//   final String? description;
//   final int? serviceCategoryId;
//
//   ServiceModel({
//     this.id,
//     this.name,
//     this.description,
//     this.serviceCategoryId,
//   });
//
//   factory ServiceModel.fromJson(Map<String, dynamic> json) {
//     return ServiceModel(
//       id: json['id'] as int?,
//       name: json['name'] as String?,
//       description: json['description'] as String?,
//       serviceCategoryId: json['serviceCategoryId'] as int?,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'description': description,
//       'serviceCategoryId': serviceCategoryId,
//     };
//   }
// }