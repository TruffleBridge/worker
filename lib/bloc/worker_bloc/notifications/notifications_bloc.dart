import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimora_worker/domain/model/response/notification_list_response_model.dart';
import 'package:nimora_worker/domain/repositories/jobs/jobs_repository.dart';
import 'package:nimora_worker/domain/repositories/notifications/notifications_repository.dart';

part 'notifications_event.dart';

part 'notifications_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository notificationRepository;
  final JobsRepository jobsRepository;

  NotificationBloc({
    required this.notificationRepository,
    required this.jobsRepository,
  }) : super(const NotificationState()) {
    on<NotificationRequested>(_onNotificationRequested);
    on<NotificationBookingApproved>(_onNotificationBookingApproved);
    on<NotificationBookingDeclined>(_onNotificationBookingDeclined);
  }

  Future<void> _onNotificationRequested(
    NotificationRequested event,
    Emitter<NotificationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearErrorMessage: true));

    try {
      final response = await notificationRepository.notificationListRequest();

      emit(
        state.copyWith(
          isLoading: false,
          notifications: response.data?.result ?? const [],
          clearErrorMessage: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }

  Future<void> _onNotificationBookingApproved(
    NotificationBookingApproved event,
    Emitter<NotificationState> emit,
  ) async {
    await _updateBookingStatus(
      jobId: event.jobId,
      workerId: event.workerId,
      clientId: event.clientId,
      statusType: 'Confirmed',
      emit: emit,
    );
  }

  Future<void> _onNotificationBookingDeclined(
    NotificationBookingDeclined event,
    Emitter<NotificationState> emit,
  ) async {
    await _updateBookingStatus(
      jobId: event.jobId,
      workerId: event.workerId,
      clientId: event.clientId,
      statusType: 'Rejected',
      emit: emit,
    );
  }

  Future<void> _updateBookingStatus({
    required int jobId,
    required int workerId,
    required int clientId,
    required String statusType,
    required Emitter<NotificationState> emit,
  }) async {
    emit(
      state.copyWith(
        isUpdating: true,
        updatingJobId: jobId,
        clearSuccessMessage: true,
        clearErrorMessage: true,
      ),
    );

    try {
      final response = await jobsRepository.clientBookingStatusUpdate(
        jobId: jobId,
        workerId: workerId,
        statusType: statusType,
        clientId: clientId,
      );

      emit(
        state.copyWith(
          isUpdating: false,
          successMessage:
              response.message ?? 'Booking status updated successfully',
          clearUpdatingJobId: true,
          clearErrorMessage: true,
        ),
      );

      add(const NotificationRequested());
    } catch (e) {
      emit(
        state.copyWith(
          isUpdating: false,
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
          clearUpdatingJobId: true,
        ),
      );
    }
  }
}
