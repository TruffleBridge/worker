part of 'job_post_bloc.dart';

abstract class JobPostEvent extends Equatable {
  const JobPostEvent();

  @override
  List<Object?> get props => [];
}

class JobPostOnLoadedEvent extends JobPostEvent {
  const JobPostOnLoadedEvent();
}

/// Step 1
class JobPostUpdateBasicDetailsEvent extends JobPostEvent {
  final String title;
  final String description;
  final String category;
  final int? serviceCategoryId;
  final int? serviceId;

  const JobPostUpdateBasicDetailsEvent({
    required this.title,
    required this.description,
    required this.category,
    required this.serviceCategoryId,
    required this.serviceId,
  });

  @override
  List<Object?> get props => [
    title,
    description,
    category,
    serviceCategoryId,
    serviceId,
  ];
}

/// Step 2
class JobPostUpdateScheduleEvent extends JobPostEvent {
  final int hourlyRate;
  final String shift;
  final int hoursPerDay;
  final String serviceRequirement;

  final String street1;
  final String city;
  final String stateName;
  final String zipCode;
  final double? latitude;
  final double? longitude;

  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;
  final String timeSlotStartTime;
  final String timeSlotEndTime;

  const JobPostUpdateScheduleEvent({
    required this.hourlyRate,
    required this.shift,
    required this.hoursPerDay,
    required this.serviceRequirement,
    required this.street1,
    required this.city,
    required this.stateName,
    required this.zipCode,
    required this.latitude,
    required this.longitude,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.timeSlotStartTime,
    required this.timeSlotEndTime,
  });

  @override
  List<Object?> get props => [
    hourlyRate,
    shift,
    hoursPerDay,
    serviceRequirement,
    street1,
    city,
    stateName,
    zipCode,
    latitude,
    longitude,
    startDate,
    endDate,
    startTime,
    endTime,
    timeSlotStartTime,
    timeSlotEndTime,
  ];
}

/// Step 3
class JobPostSubmitEvent extends JobPostEvent {
  final String experienceLevel;
  final List<String> requiredSkills;
  final List<String> certifications;
  final List<String> preferredLanguages;
  final String genderPreference;

  const JobPostSubmitEvent({
    required this.experienceLevel,
    required this.requiredSkills,
    required this.certifications,
    required this.preferredLanguages,
    required this.genderPreference,
  });

  @override
  List<Object?> get props => [
    experienceLevel,
    requiredSkills,
    certifications,
    preferredLanguages,
    genderPreference,
  ];
}