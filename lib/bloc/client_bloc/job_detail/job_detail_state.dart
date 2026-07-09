import 'package:equatable/equatable.dart';

import '../../../domain/model/response/job_detail/job_detail_response_model.dart';

abstract class ClientJobDetailState extends Equatable {
  const ClientJobDetailState();

  @override
  List<Object?> get props => [];
}

class ClientJobDetailInitial extends ClientJobDetailState {}

class ClientJobDetailLoading extends ClientJobDetailState {}

class ClientJobDetailLoaded extends ClientJobDetailState {
  final ClientJobDetailResponseModel response;

  const ClientJobDetailLoaded({
    required this.response,
  });

  @override
  List<Object?> get props => [response];
}

class ClientJobDetailError extends ClientJobDetailState {
  final String message;

  const ClientJobDetailError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}