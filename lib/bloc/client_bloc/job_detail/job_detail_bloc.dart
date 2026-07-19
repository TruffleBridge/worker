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
    on<ClientBookingStatusUpdateEvent>(_onBookingStatusUpdate);
  }

  // ---------------------------------------------------------------------------
  // Fetch client job detail
  // ---------------------------------------------------------------------------

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
          message: e.toString().replaceFirst(
            'Exception: ',
            '',
          ),
        ),
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Update booking status
  // ---------------------------------------------------------------------------

  Future<void> _onBookingStatusUpdate(
      ClientBookingStatusUpdateEvent event,
      Emitter<ClientJobDetailState> emit,
      ) async {
    final currentState = state;

    if (currentState is! ClientJobDetailLoaded) {
      return;
    }

    emit(
      ClientBookingStatusUpdating(
        response: currentState.response,
        workerId: event.workerId,
      ),
    );

    try {
      final response = await jobsRepository.clientBookingStatusUpdate(
        jobId: event.jobId,
        workerId: event.workerId,
        clientId: 0,
        statusType: event.statusType,
      );

      if (response.status == true) {
        emit(
          ClientBookingStatusUpdateSuccess(
            response: currentState.response,
            message: response.message ?? 'Booking status updated successfully',
          ),
        );

        add(
          FetchClientJobDetailEvent(
            jobId: event.jobId,
          ),
        );

        return;
      }

      emit(
        ClientBookingStatusUpdateFailure(
          response: currentState.response,
          message: response.message ?? 'Failed to update booking status',
        ),
      );
    } catch (e) {
      emit(
        ClientBookingStatusUpdateFailure(
          response: currentState.response,
          message: e.toString().replaceFirst(
            'Exception: ',
            '',
          ),
        ),
      );
    }
  }
}