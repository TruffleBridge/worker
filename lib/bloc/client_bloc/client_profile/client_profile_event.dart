import 'package:equatable/equatable.dart';

import 'client_profile_state.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfileEvent extends ProfileEvent {}

class SignOutEvent extends ProfileEvent {}

// Documents event

class PickDocumentEvent extends ProfileEvent {}

class RemoveSelectedDocumentEvent extends ProfileEvent {
  const RemoveSelectedDocumentEvent();
}

class RemoveDocumentEvent extends ProfileEvent {
  final int index;

  const RemoveDocumentEvent (this.index);

  @override
  List<Object?> get props => [index];
}

class UploadDocumentEvent extends ProfileEvent {}

class ResetUploadSuccessEvent extends ProfileEvent {
  const ResetUploadSuccessEvent();
}

// Notification event

class ToggleNewMessagesEvent extends ProfileEvent {
  final bool value;

  const ToggleNewMessagesEvent(this.value);
}

class ToggleJobUpdatesEvent extends ProfileEvent {
  final bool value;

  const ToggleJobUpdatesEvent(this.value);
}

class TogglePaymentAlertsEvent extends ProfileEvent {
  final bool value;

  const TogglePaymentAlertsEvent(this.value);
}

class ToggleDocumentAlertsEvent extends ProfileEvent {
  final bool value;

 const ToggleDocumentAlertsEvent(this.value);
}

// Payment event

class AddPaymentCardEvent extends ProfileEvent {
  final PaymentCardModel card;

 const AddPaymentCardEvent(this.card);
}

class RemovePaymentCardEvent extends ProfileEvent {
  final int index;

 const RemovePaymentCardEvent(this.index);
}



// Account Settings
class ToggleTwoFactorEvent extends ProfileEvent {
  final bool enabled;

  const ToggleTwoFactorEvent(this.enabled);
}


class UpdatePasswordEvent extends ProfileEvent {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  const UpdatePasswordEvent({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });
}

class UpdatePersonalInformationFieldEvent extends ProfileEvent {
  final String field;
  final String value;

  const UpdatePersonalInformationFieldEvent({
    required this.field,
    required this.value,
  });
}