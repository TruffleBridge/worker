import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nimora_worker/core/enums/job_tab.dart';
import 'package:nimora_worker/domain/model/request/jobs_nearby_request_model.dart';
import 'package:nimora_worker/domain/model/response/job_applied_response_model.dart';
import 'package:nimora_worker/domain/model/response/job_detail_response_model.dart';
import 'package:nimora_worker/domain/model/view_model/job.dart';
import 'package:nimora_worker/domain/repositories/jobs/jobs_repository.dart';

part 'jobs_event.dart';

part 'jobs_state.dart';

class JobsBloc extends Bloc<JobsEvent, JobsState> {
  final JobsRepository _jobsRepository;

  JobsBloc({required this._jobsRepository}) : super(JobsInitial()) {
    on<JobsOnLoadedEvent>(_onLoaded);
    on<JobsSearchChanged>(_onSearchChanged);
    on<JobSaveToggled>(_onSaveToggled);
    on<JobSelected>(_onSelected);
    on<JobsTabChanged>(_onTabChanged);
    on<JobDetailRequested>(_onDetailRequested);
    on<JobAppliedEvent>(_onJobAppliedEvent);
  }

  Future<void> _onLoaded(
    JobsOnLoadedEvent event,
    Emitter<JobsState> emit,
  ) async {
    emit(const JobsLoading());

    try {
      final response = await _jobsRepository.jobsRequest(
        jobsNearbyRequestModel: JobsNearbyRequestModel(
          page: 1,
          limit: 10,
          search: '',
          locationType: 'current',
          latitude: 13.0827,
          longitude: 80.2707,
          address: 'Chennai, Tamil Nadu',
          radiusKm: 25,
        ),
      );

      final jobs =
          response.data?.jobs?.map((e) => Job.fromJson(e.toJson())).toList() ??
          [];

      emit(JobsSuccess(jobs: jobs, filteredJobs: jobs));
    } catch (e) {
      emit(JobsError(e.toString()));
    }
  }

  void _onSearchChanged(JobsSearchChanged event, Emitter<JobsState> emit) {
    final currentState = state;

    if (currentState is JobsSuccess) {
      final query = event.query.toLowerCase();

      final filteredJobs = event.query.isEmpty
          ? currentState.jobs
          : currentState.jobs.where((job) {
              return job.title.toLowerCase().contains(query) ||
                  job.location.toLowerCase().contains(query);
            }).toList();

      emit(
        currentState.copyWith(filteredJobs: filteredJobs, query: event.query),
      );
    }
  }

  void _onSaveToggled(JobSaveToggled event, Emitter<JobsState> emit) {
    final currentState = state;

    if (currentState is JobsSuccess) {
      final updatedJobs = currentState.jobs.map((job) {
        return job.id == event.jobId
            ? job.copyWith(isSaved: !job.isSaved)
            : job;
      }).toList();

      final filteredJobs = currentState.query.isEmpty
          ? updatedJobs
          : updatedJobs.where((job) {
              final query = currentState.query.toLowerCase();

              return job.title.toLowerCase().contains(query) ||
                  job.location.toLowerCase().contains(query);
            }).toList();

      emit(
        currentState.copyWith(jobs: updatedJobs, filteredJobs: filteredJobs),
      );
    }
  }

  void _onSelected(JobSelected event, Emitter<JobsState> emit) {
    final currentState = state;

    if (currentState is JobsSuccess) {
      emit(currentState.copyWith(selectedJob: event.job));
    }
  }

  void _onTabChanged(JobsTabChanged event, Emitter<JobsState> emit) {
    final currentState = state;

    if (currentState is JobsSuccess) {
      emit(currentState.copyWith(selectedTab: event.tab));
    }
  }

  Future<void> _onDetailRequested(
    JobDetailRequested event,
    Emitter<JobsState> emit,
  ) async {
    emit(const JobDetailLoading());

    try {
      final response = await _jobsRepository.jobDetailRequest(
        jobId: int.parse(event.jobId),
        latitude: event.latitude,
        longitude: event.longitude,
      );

      emit(JobsDetailsOnLoadedState(response));
    } catch (e) {
      emit(JobsError(e.toString()));
    }
  }

  Future<void> _onJobAppliedEvent(
      JobAppliedEvent event,
      Emitter<JobsState> emit,
      ) async {
    final currentState = state;

    if (currentState is! JobsDetailsOnLoadedState) {
      return;
    }

    emit(const JobAppliedLoadingState());

    try {
      final response = await _jobsRepository.jobAppliedSubmit(
        jobId: event.jobId,
      );

      emit(
        JobAppliedSuccessState(
          response: response,
        ),
      );
    } catch (e) {
      emit(
        JobAppliedErrorState(
          message: e.toString(),
        ),
      );
    }
  }
}
