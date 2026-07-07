class MyJobsResponseModel {
  final bool? success;
  final String? message;
  final MyJobsData? data;

  MyJobsResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory MyJobsResponseModel.fromJson(Map<String, dynamic> json) {
    return MyJobsResponseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? MyJobsData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class MyJobsData {
  final int? total;
  final int? page;
  final int? limit;
  final List<JobListItemModel> jobs;

  MyJobsData({
    this.total,
    this.page,
    this.limit,
    this.jobs = const [],
  });

  factory MyJobsData.fromJson(Map<String, dynamic> json) {
    return MyJobsData(
      total: int.tryParse(json['total'].toString()),
      page: int.tryParse(json['page'].toString()),
      limit: int.tryParse(json['limit'].toString()),
      jobs: (json['jobs'] as List<dynamic>? ?? [])
          .map((e) => JobListItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class JobListItemModel {
  final int? id;
  final String? title;
  final String? status;
  final String? location;
  final String? postedAt;
  final List<String> tags;
  final int? applicantsCount;
  final List<String> applicantAvatars;

  JobListItemModel({
    this.id,
    this.title,
    this.status,
    this.location,
    this.postedAt,
    this.tags = const [],
    this.applicantsCount,
    this.applicantAvatars = const [],
  });

  factory JobListItemModel.fromJson(Map<String, dynamic> json) {
    return JobListItemModel(
        id: json['id'] == null
            ? null
            : int.tryParse(json['id'].toString()),
      title: json['title'] as String?,
      status: json['status'] as String?,
      location: json['location'] as String?,
      postedAt: json['postedAt'] as String?,
      tags: (json['tags'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      applicantsCount: json['applicantsCount'] == null
          ? null
          : int.tryParse(json['applicantsCount'].toString()),
      applicantAvatars: (json['applicantAvatars'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }
}