import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nimora_worker/domain/model/request/job_post_request_model.dart';
import 'package:nimora_worker/domain/model/response/job_post_response_model.dart';
import 'package:nimora_worker/domain/repositories/job_post/job_post_repository.dart';

part 'job_post_event.dart';
part 'job_post_state.dart';

class JobPostBloc extends Bloc<JobPostEvent, JobPostState> {
  final JobPostRepository jobPostRepository;

  JobPostBloc({
    required this.jobPostRepository,
  }) : super(const JobPostState()) {
    on<JobPostOnLoadedEvent>(_onLoaded);
    on<JobPostUpdateBasicDetailsEvent>(_onUpdateBasicDetails);
    on<JobPostUpdateScheduleEvent>(_onUpdateSchedule);
    on<JobPostSubmitEvent>(_onSubmit);
  }

  void _onLoaded(
      JobPostOnLoadedEvent event,
      Emitter<JobPostState> emit,
      ) {
    emit(
      state.copyWith(
        isLoading: false,
        isSubmitting: false,
        isSuccess: false,
        errorMessage: '',
      ),
    );
  }

  void _onUpdateBasicDetails(
      JobPostUpdateBasicDetailsEvent event,
      Emitter<JobPostState> emit,
      ) {
    emit(
      state.copyWith(
        title: event.title,
        description: event.description,
        category: event.category,
        serviceCategoryId: event.serviceCategoryId,
        serviceId: event.serviceId,
        errorMessage: '',
      ),
    );
  }

  void _onUpdateSchedule(
      JobPostUpdateScheduleEvent event,
      Emitter<JobPostState> emit,
      ) {
    emit(
      state.copyWith(
        hourlyRate: event.hourlyRate,
        shift: event.shift,
        hoursPerDay: event.hoursPerDay,
        serviceRequirement: event.serviceRequirement,
        street1: event.street1,
        city: event.city,
        stateName: event.stateName,
        zipCode: event.zipCode,
        latitude: event.latitude,
        longitude: event.longitude,
        startDate: event.startDate,
        endDate: event.endDate,
        startTime: event.startTime,
        endTime: event.endTime,
        timeSlotStartTime: event.timeSlotStartTime,
        timeSlotEndTime: event.timeSlotEndTime,
        errorMessage: '',
      ),
    );
  }

  Future<void> _onSubmit(
      JobPostSubmitEvent event,
      Emitter<JobPostState> emit,
      ) async {
    final updatedState = state.copyWith(
      isSubmitting: true,
      isSuccess: false,
      errorMessage: '',
      experienceLevel: event.experienceLevel,
      selectedSupportNeeds: event.requiredSkills,
      selectedCertifications: event.certifications,
      selectedLanguages: event.preferredLanguages,
      genderPreference: event.genderPreference,
    );

    emit(updatedState);

    try {
      final requestModel = JobPostRequestModel(
        title: updatedState.title,
        description: updatedState.description,
        category: updatedState.category,
        serviceCategoryId: updatedState.serviceCategoryId,
        serviceId: updatedState.serviceId,
        hourlyRate: updatedState.hourlyRate,
        shift: updatedState.shift,
        hoursPerDay: updatedState.hoursPerDay,
        //ToDo
        // serviceRequirement: updatedState.serviceRequirement,
        serviceRequirement: updatedState.description,
        location: JobPostLocation(
          street1: updatedState.street1,
          city: updatedState.city,
          state: updatedState.stateName,
          zipCode: updatedState.zipCode,
          latitude: updatedState.latitude,
          longitude: updatedState.longitude,
        ),
        sessions: [
          JobPostSessions(
            startDate: updatedState.startDate,
            endDate: updatedState.endDate,
            startTime: updatedState.startTime,
            endTime: updatedState.endTime,
            timeSlots: [
              TimeSlots(
                startTime: updatedState.timeSlotStartTime,
                endTime: updatedState.timeSlotEndTime,
              ),
            ],
          ),
        ],
      );

      final JobPostResponseModel response =
      await jobPostRepository.jobPostRequest(
        jobPostRequestModel: requestModel,
      );

      if (response.status == true) {
        emit(
          updatedState.copyWith(
            isSubmitting: false,
            isSuccess: true,
            errorMessage: '',
          ),
        );
      } else {
        emit(
          updatedState.copyWith(
            isSubmitting: false,
            isSuccess: false,
            errorMessage: response.message ?? 'Failed to post job',
          ),
        );
      }
    } catch (e) {
      emit(
        updatedState.copyWith(
          isSubmitting: false,
          isSuccess: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}