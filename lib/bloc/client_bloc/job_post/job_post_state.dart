part of 'job_post_bloc.dart';
class JobPostState extends Equatable {
  final bool isLoading;
  final bool isSubmitting;
  final bool isSuccess;
  final String errorMessage;

  final String title;
  final String description;
  final String category;
  final int? serviceCategoryId;
  final int? serviceId;

  final int? hourlyRate;
  final String shift;
  final int? hoursPerDay;
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

  final String experienceLevel;
  final List<String> selectedSupportNeeds;
  final List<String> selectedCertifications;
  final List<String> selectedLanguages;
  final String genderPreference;

  const JobPostState({
    this.isLoading = false,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage = '',
    this.title = '',
    this.description = '',
    this.category = '',
    this.serviceCategoryId,
    this.serviceId,
    this.hourlyRate,
    this.shift = '',
    this.hoursPerDay,
    this.serviceRequirement = '',
    this.street1 = '',
    this.city = '',
    this.stateName = '',
    this.zipCode = '',
    this.latitude,
    this.longitude,
    this.startDate = '',
    this.endDate = '',
    this.startTime = '',
    this.endTime = '',
    this.timeSlotStartTime = '',
    this.timeSlotEndTime = '',
    this.experienceLevel = '',
    this.selectedSupportNeeds = const [],
    this.selectedCertifications = const [],
    this.selectedLanguages = const [],
    this.genderPreference = 'none',
  });

  JobPostState copyWith({
    bool? isLoading,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
    String? title,
    String? description,
    String? category,
    int? serviceCategoryId,
    int? serviceId,
    int? hourlyRate,
    String? shift,
    int? hoursPerDay,
    String? serviceRequirement,
    String? street1,
    String? city,
    String? stateName,
    String? zipCode,
    double? latitude,
    double? longitude,
    String? startDate,
    String? endDate,
    String? startTime,
    String? endTime,
    String? timeSlotStartTime,
    String? timeSlotEndTime,
    String? experienceLevel,
    List<String>? selectedSupportNeeds,
    List<String>? selectedCertifications,
    List<String>? selectedLanguages,
    String? genderPreference,
  }) {
    return JobPostState(
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      serviceCategoryId: serviceCategoryId ?? this.serviceCategoryId,
      serviceId: serviceId ?? this.serviceId,
      hourlyRate: hourlyRate ?? this.hourlyRate,
      shift: shift ?? this.shift,
      hoursPerDay: hoursPerDay ?? this.hoursPerDay,
      serviceRequirement: serviceRequirement ?? this.serviceRequirement,
      street1: street1 ?? this.street1,
      city: city ?? this.city,
      stateName: stateName ?? this.stateName,
      zipCode: zipCode ?? this.zipCode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      timeSlotStartTime: timeSlotStartTime ?? this.timeSlotStartTime,
      timeSlotEndTime: timeSlotEndTime ?? this.timeSlotEndTime,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      selectedSupportNeeds:
      selectedSupportNeeds ?? this.selectedSupportNeeds,
      selectedCertifications:
      selectedCertifications ?? this.selectedCertifications,
      selectedLanguages: selectedLanguages ?? this.selectedLanguages,
      genderPreference: genderPreference ?? this.genderPreference,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isSubmitting,
    isSuccess,
    errorMessage,
    title,
    description,
    category,
    serviceCategoryId,
    serviceId,
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
    experienceLevel,
    selectedSupportNeeds,
    selectedCertifications,
    selectedLanguages,
    genderPreference,
  ];
}