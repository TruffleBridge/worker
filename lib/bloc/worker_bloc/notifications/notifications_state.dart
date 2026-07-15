part of 'notifications_bloc.dart';

class NotificationState extends Equatable {
  final bool isLoading;
  final bool isUpdating;
  final int? updatingJobId;
  final List<NotificationListResult> notifications;
  final String? successMessage;
  final String? errorMessage;

  const NotificationState({
    this.isLoading = false,
    this.isUpdating = false,
    this.updatingJobId,
    this.notifications = const [],
    this.successMessage,
    this.errorMessage,
  });

  NotificationState copyWith({
    bool? isLoading,
    bool? isUpdating,
    int? updatingJobId,
    List<NotificationListResult>? notifications,
    String? successMessage,
    String? errorMessage,
    bool clearUpdatingJobId = false,
    bool clearSuccessMessage = false,
    bool clearErrorMessage = false,
  }) {
    return NotificationState(
      isLoading: isLoading ?? this.isLoading,
      isUpdating: isUpdating ?? this.isUpdating,
      updatingJobId: clearUpdatingJobId
          ? null
          : updatingJobId ?? this.updatingJobId,
      notifications: notifications ?? this.notifications,
      successMessage: clearSuccessMessage
          ? null
          : successMessage ?? this.successMessage,
      errorMessage: clearErrorMessage
          ? null
          : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isUpdating,
    updatingJobId,
    notifications,
    successMessage,
    errorMessage,
  ];
}