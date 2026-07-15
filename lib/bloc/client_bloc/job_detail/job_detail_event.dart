import 'package:equatable/equatable.dart';

abstract class ClientJobDetailEvent extends Equatable {
  const ClientJobDetailEvent();

  @override
  List<Object?> get props => [];
}

// ---------------------------------------------------------------------------
// Fetch job detail
// ---------------------------------------------------------------------------

class FetchClientJobDetailEvent extends ClientJobDetailEvent {
  final int jobId;
  final double applicantsPage;
  final double applicantsLimit;

  const FetchClientJobDetailEvent({
    required this.jobId,
    this.applicantsPage = 1,
    this.applicantsLimit = 20,
  });

  @override
  List<Object?> get props => [
    jobId,
    applicantsPage,
    applicantsLimit,
  ];
}

// ---------------------------------------------------------------------------
// Update booking status
// ---------------------------------------------------------------------------

class ClientBookingStatusUpdateEvent extends ClientJobDetailEvent {
  final int jobId;
  final int workerId;
  final String statusType;

  const ClientBookingStatusUpdateEvent({
    required this.jobId,
    required this.workerId,
    required this.statusType,
  });

  @override
  List<Object?> get props => [
    jobId,
    workerId,
    statusType,
  ];
}
