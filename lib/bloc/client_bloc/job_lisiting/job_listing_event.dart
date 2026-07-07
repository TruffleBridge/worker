import 'package:equatable/equatable.dart';

abstract class MyJobsListEvent extends Equatable {
  const MyJobsListEvent();

  @override
  List<Object?> get props => [];
}

/// Fired when the widget first loads, or when switching tabs
/// (status = "active" or "closed").
class FetchMyJobsListEvent extends MyJobsListEvent {
  final String status;
  final int page;
  final int limit;

  const FetchMyJobsListEvent({
    required this.status,
    this.page = 1,
    this.limit = 10,
  });

  @override
  List<Object?> get props => [status, page, limit];
}

/// Fired on pull-to-refresh.
class  RefreshMyJobsListEvent extends MyJobsListEvent{
  final String status;

  const RefreshMyJobsListEvent({required this.status});

  @override
  List<Object?> get props => [status];
}