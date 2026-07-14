part of 'create_profile_bloc.dart';

sealed class CreateProfileEvent extends Equatable {
  const CreateProfileEvent();

  @override
  List<Object?> get props => [];
}

// Step navigation

final class CreateProfileNextStep extends CreateProfileEvent {
  const CreateProfileNextStep();
}

final class CreateProfilePreviousStep extends CreateProfileEvent {
  const CreateProfilePreviousStep();
}

final class CreateProfileGoToStep extends CreateProfileEvent {
  final int step;

  const CreateProfileGoToStep(this.step);

  @override
  List<Object?> get props => [step];
}

// Step 1 - Personal details

final class CreateProfileFullNameChanged extends CreateProfileEvent {
  final String fullName;

  const CreateProfileFullNameChanged(this.fullName);

  @override
  List<Object?> get props => [fullName];
}

final class CreateProfileDateOfBirthChanged extends CreateProfileEvent {
  final String dateOfBirth;

  const CreateProfileDateOfBirthChanged(this.dateOfBirth);

  @override
  List<Object?> get props => [dateOfBirth];
}

final class CreateProfileMobileNumberChanged extends CreateProfileEvent {
  final String mobileNumber;

  const CreateProfileMobileNumberChanged(this.mobileNumber);

  @override
  List<Object?> get props => [mobileNumber];
}

final class CreateProfileEmailChanged extends CreateProfileEvent {
  final String email;

  const CreateProfileEmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

final class CreateProfileGenderChanged extends CreateProfileEvent {
  final String gender;

  const CreateProfileGenderChanged(this.gender);

  @override
  List<Object?> get props => [gender];
}

final class CreateProfileIdProofUpdated extends CreateProfileEvent {
  final String? fileName;

  const CreateProfileIdProofUpdated(this.fileName);

  @override
  List<Object?> get props => [fileName];
}

// Step 2 - Business details

final class CreateProfileBusinessNameChanged extends CreateProfileEvent {
  final String businessName;

  const CreateProfileBusinessNameChanged(this.businessName);

  @override
  List<Object?> get props => [businessName];
}

final class CreateProfileAbnChanged extends CreateProfileEvent {
  final String abn;

  const CreateProfileAbnChanged(this.abn);

  @override
  List<Object?> get props => [abn];
}

final class CreateProfileAcnChanged extends CreateProfileEvent {
  final String acn;

  const CreateProfileAcnChanged(this.acn);

  @override
  List<Object?> get props => [acn];
}

final class CreateProfileAddressChanged extends CreateProfileEvent {
  final String address;

  const CreateProfileAddressChanged(this.address);

  @override
  List<Object?> get props => [address];
}

final class CreateProfileSuburbChanged extends CreateProfileEvent {
  final String suburb;

  const CreateProfileSuburbChanged(this.suburb);

  @override
  List<Object?> get props => [suburb];
}

final class CreateProfileStateChanged extends CreateProfileEvent {
  final String stateValue;

  const CreateProfileStateChanged(this.stateValue);

  @override
  List<Object?> get props => [stateValue];
}

final class CreateProfilePostcodeChanged extends CreateProfileEvent {
  final String postcode;

  const CreateProfilePostcodeChanged(this.postcode);

  @override
  List<Object?> get props => [postcode];
}

// Step 3 - Mandatory documents

final class CreateProfileMandatoryDocumentUpdated
    extends CreateProfileEvent {
  final String documentName;
  final bool uploaded;

  const CreateProfileMandatoryDocumentUpdated({
    required this.documentName,
    required this.uploaded,
  });

  @override
  List<Object?> get props => [
    documentName,
    uploaded,
  ];
}

// Step 4 - Recommended documents

final class CreateProfileRecommendedDocumentUpdated
    extends CreateProfileEvent {
  final String documentName;
  final bool uploaded;

  const CreateProfileRecommendedDocumentUpdated({
    required this.documentName,
    required this.uploaded,
  });

  @override
  List<Object?> get props => [
    documentName,
    uploaded,
  ];
}

// Submit

final class CreateProfileSubmitted extends CreateProfileEvent {
  const CreateProfileSubmitted();
}

final class CreateProfileCompletionReset extends CreateProfileEvent {
  const CreateProfileCompletionReset();
}