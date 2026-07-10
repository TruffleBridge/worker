import 'package:equatable/equatable.dart';

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

abstract class ClientJobDetailEvent extends Equatable {
  const ClientJobDetailEvent();

  @override
  List<Object?> get props => [];
}