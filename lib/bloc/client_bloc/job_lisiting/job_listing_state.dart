import 'package:equatable/equatable.dart';

import '../../../domain/model/response/job_listing/job_listing_response_model.dart';

abstract class MyJobsListState extends Equatable {
  const MyJobsListState();

  @override
  List<Object?> get props => [];
}

class MyJobsListInitial extends  MyJobsListState{}

class MyJobsListLoading extends  MyJobsListState {}

class MyJobsListLoaded extends  MyJobsListState {
  final String status;
  final List<JobListItemModel> jobs;
  final int total;

  const MyJobsListLoaded({
    required this.status,
    required this.jobs,
    required this.total,
  });

  @override
  List<Object?> get props => [status, jobs, total];
}

class MyJobsListError extends  MyJobsListState {
  final String message;

  const MyJobsListError({required this.message});

  @override
  List<Object?> get props => [message];
}