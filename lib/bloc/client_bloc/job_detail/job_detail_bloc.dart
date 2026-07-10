import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/model/request/job_detail/job_detail_request_model.dart';
import '../../../domain/repositories/jobs/jobs_repository.dart';
import 'job_detail_event.dart';
import 'job_detail_state.dart';

class ClientJobDetailBloc
    extends Bloc<ClientJobDetailEvent, ClientJobDetailState> {
  final JobsRepository jobsRepository;

  ClientJobDetailBloc({
    required this.jobsRepository,
  }) : super(ClientJobDetailInitial()) {
    on<FetchClientJobDetailEvent>(_onFetchJobDetail);
  }

  Future<void> _onFetchJobDetail(
      FetchClientJobDetailEvent event,
      Emitter<ClientJobDetailState> emit,
      ) async {
    emit(ClientJobDetailLoading());

    try {
      final response = await jobsRepository.clientJobDetailRequest(
        clientJobDetailRequestModel: ClientJobDetailRequestModel(
          jobId: event.jobId,
          applicantsPage: event.applicantsPage,
          applicantsLimit: event.applicantsLimit,
        ),
      );

      emit(
        ClientJobDetailLoaded(
          response: response,
        ),
      );
    } catch (e) {
      emit(
        ClientJobDetailError(
          message: e.toString().replaceFirst("Exception: ", ""),
        ),
      );
    }
  }
}