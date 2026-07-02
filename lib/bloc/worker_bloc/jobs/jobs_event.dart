part of 'jobs_bloc.dart';

abstract class JobsEvent extends Equatable {
  const JobsEvent();

  @override
  List<Object?> get props => [];
}

class JobsOnLoadedEvent extends JobsEvent {
  const JobsOnLoadedEvent();
}

class JobsSearchChanged extends JobsEvent {
  final String query;

  const JobsSearchChanged(this.query);

  @override
  List<Object?> get props => [query];
}

class JobsTabChanged extends JobsEvent {
  final JobsTab tab;

  const JobsTabChanged(this.tab);

  @override
  List<Object?> get props => [tab];
}

class JobSaveToggled extends JobsEvent {
  final String jobId;

  const JobSaveToggled(this.jobId);

  @override
  List<Object?> get props => [jobId];
}

class JobSelected extends JobsEvent {
  final Job job;

  const JobSelected(this.job);

  @override
  List<Object?> get props => [job];
}

class JobDetailRequested extends JobsEvent {
  final String jobId;
  final double latitude;
  final double longitude;

  const JobDetailRequested(this.jobId, this.latitude, this.longitude);

  @override
  List<Object?> get props => [jobId, latitude, longitude];
}

class JobAppliedEvent extends JobsEvent {
  final int jobId;

  const JobAppliedEvent(this.jobId);

  @override
  List<Object?> get props => [jobId];
}
