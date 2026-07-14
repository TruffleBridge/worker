part of 'jobs_bloc.dart';

abstract class JobsState extends Equatable {
  const JobsState();

  @override
  List<Object?> get props => [];
}

final class JobsInitial extends JobsState {
  const JobsInitial();
}

class JobsLoading extends JobsState {
  const JobsLoading();
}

class JobsSuccess extends JobsState {
  final List<Job> jobs;
  final List<Job> filteredJobs;
  final String query;
  final Job? selectedJob;
  final JobsTab selectedTab;

  const JobsSuccess({
    required this.jobs,
    required this.filteredJobs,
    this.query = '',
    this.selectedJob,
    this.selectedTab = JobsTab.allJobs,
  });

  JobsSuccess copyWith({
    List<Job>? jobs,
    List<Job>? filteredJobs,
    String? query,
    Job? selectedJob,
    JobsTab? selectedTab,
  }) {
    return JobsSuccess(
      jobs: jobs ?? this.jobs,
      filteredJobs: filteredJobs ?? this.filteredJobs,
      query: query ?? this.query,
      selectedJob: selectedJob ?? this.selectedJob,
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }

  @override
  List<Object?> get props => [
    jobs,
    filteredJobs,
    query,
    selectedJob,
    selectedTab,
  ];
}

class JobsError extends JobsState {
  final String message;

  const JobsError(this.message);

  @override
  List<Object?> get props => [message];
}

class JobDetailLoading extends JobsState {
  const JobDetailLoading();
}

class JobsDetailsOnLoadedState extends JobsState {
  final JobDetailResponseModel response;

  const JobsDetailsOnLoadedState(this.response);

  @override
  List<Object?> get props => [response];
}

class JobAppliedLoadingState extends JobsState {
  final JobDetailResponseModel jobDetail;

  const JobAppliedLoadingState({
    required this.jobDetail,
  });

  @override
  List<Object?> get props => [jobDetail];
}

class JobAppliedSuccessState extends JobsState {
  final JobDetailResponseModel jobDetail;
  final JobAppliedResponseModel response;

  const JobAppliedSuccessState({
    required this.jobDetail,
    required this.response,
  });

  @override
  List<Object?> get props => [jobDetail, response];
}

class JobAppliedErrorState extends JobsState {
  final JobDetailResponseModel jobDetail;
  final String message;

  const JobAppliedErrorState({
    required this.jobDetail,
    required this.message,
  });

  @override
  List<Object?> get props => [jobDetail, message];
}