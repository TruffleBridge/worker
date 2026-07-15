part of 'notifications_bloc.dart';

sealed class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

final class NotificationRequested extends NotificationEvent {
  const NotificationRequested();
}

final class NotificationBookingApproved extends NotificationEvent {
  final int jobId;
  final int workerId;

  const NotificationBookingApproved({
    required this.jobId,
    required this.workerId,
  });

  @override
  List<Object?> get props => [
    jobId,
    workerId,
  ];
}

final class NotificationBookingDeclined extends NotificationEvent {
  final int jobId;
  final int workerId;

  const NotificationBookingDeclined({
    required this.jobId,
    required this.workerId,
  });

  @override
  List<Object?> get props => [
    jobId,
    workerId,
  ];
}