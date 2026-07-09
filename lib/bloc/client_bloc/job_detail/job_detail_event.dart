import 'package:equatable/equatable.dart';

class FetchClientJobDetailEvent extends ClientJobDetailEvent {
  final int jobId;
  final double latitude;
  final double longitude;

  const FetchClientJobDetailEvent({
    required this.jobId,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [
    jobId,
    latitude,
    longitude,
  ];
}

abstract class ClientJobDetailEvent extends Equatable {
  const ClientJobDetailEvent();

  @override
  List<Object?> get props => [];
}