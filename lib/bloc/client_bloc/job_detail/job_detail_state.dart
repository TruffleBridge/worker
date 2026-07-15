import 'package:equatable/equatable.dart';

import '../../../domain/model/response/job_detail/job_detail_response_model.dart';

abstract class ClientJobDetailState extends Equatable {
  const ClientJobDetailState();

  @override
  List<Object?> get props => [];
}

// ---------------------------------------------------------------------------
// Initial
// ---------------------------------------------------------------------------

class ClientJobDetailInitial extends ClientJobDetailState {}

// ---------------------------------------------------------------------------
// Loading
// ---------------------------------------------------------------------------

class ClientJobDetailLoading extends ClientJobDetailState {}

// ---------------------------------------------------------------------------
// Loaded
// ---------------------------------------------------------------------------

class ClientJobDetailLoaded extends ClientJobDetailState {
  final ClientJobDetailResponseModel response;

  const ClientJobDetailLoaded({
    required this.response,
  });

  @override
  List<Object?> get props => [
    response,
  ];
}

// ---------------------------------------------------------------------------
// Error
// ---------------------------------------------------------------------------

class ClientJobDetailError extends ClientJobDetailState {
  final String message;

  const ClientJobDetailError({
    required this.message,
  });

  @override
  List<Object?> get props => [
    message,
  ];
}

// ---------------------------------------------------------------------------
// Booking status updating
// ---------------------------------------------------------------------------

class ClientBookingStatusUpdating extends ClientJobDetailState {
  final ClientJobDetailResponseModel response;
  final int workerId;

  const ClientBookingStatusUpdating({
    required this.response,
    required this.workerId,
  });

  @override
  List<Object?> get props => [
    response,
    workerId,
  ];
}

// ---------------------------------------------------------------------------
// Booking status update success
// ---------------------------------------------------------------------------

class ClientBookingStatusUpdateSuccess extends ClientJobDetailState {
  final ClientJobDetailResponseModel response;
  final String message;

  const ClientBookingStatusUpdateSuccess({
    required this.response,
    required this.message,
  });

  @override
  List<Object?> get props => [
    response,
    message,
  ];
}

// ---------------------------------------------------------------------------
// Booking status update failure
// ---------------------------------------------------------------------------

class ClientBookingStatusUpdateFailure extends ClientJobDetailState {
  final ClientJobDetailResponseModel response;
  final String message;

  const ClientBookingStatusUpdateFailure({
    required this.response,
    required this.message,
  });

  @override
  List<Object?> get props => [
    response,
    message,
  ];
}