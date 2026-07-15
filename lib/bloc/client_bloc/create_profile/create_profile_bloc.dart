import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimora_worker/core/enums/create_profile_status.dart';
import 'package:nimora_worker/domain/model/request/register_request_model.dart'
as register_request;
import 'package:nimora_worker/domain/model/response/register_response_model.dart';
import 'package:nimora_worker/domain/model/response/upload_response_model.dart';
import 'package:nimora_worker/domain/repositories/create_profile/create_profile_repository.dart';

part 'create_profile_event.dart';
part 'create_profile_state.dart';

class CreateProfileBloc
    extends Bloc<CreateProfileEvent, CreateProfileState> {
  final CreateProfileRepository createProfileRepository;

  static const int _totalSteps = 4;

  CreateProfileBloc({
    required this.createProfileRepository,
  }) : super(const CreateProfileState()) {
    // Navigation
    on<CreateProfileNextStep>(_onNextStep);
    on<CreateProfilePreviousStep>(_onPreviousStep);
    on<CreateProfileGoToStep>(_onGoToStep);

    // Step 1
    on<CreateProfileFullNameChanged>(_onFullNameChanged);
    on<CreateProfileDateOfBirthChanged>(_onDateOfBirthChanged);
    on<CreateProfileMobileNumberChanged>(_onMobileNumberChanged);
    on<CreateProfileEmailChanged>(_onEmailChanged);
    on<CreateProfileGenderChanged>(_onGenderChanged);
    on<CreateProfileIdProofUpdated>(_onIdProofUpdated);

    // Step 2
    on<CreateProfileBusinessNameChanged>(
      _onBusinessNameChanged,
    );
    on<CreateProfileAbnChanged>(_onAbnChanged);
    on<CreateProfileAcnChanged>(_onAcnChanged);
    on<CreateProfileAddressChanged>(_onAddressChanged);
    on<CreateProfileSuburbChanged>(_onSuburbChanged);
    on<CreateProfileStateChanged>(_onStateChanged);
    on<CreateProfilePostcodeChanged>(_onPostcodeChanged);

    // Step 3
    on<CreateProfileMandatoryDocumentUpdated>(
      _onMandatoryDocumentUpdated,
    );

    // Step 4
    on<CreateProfileRecommendedDocumentUpdated>(
      _onRecommendedDocumentUpdated,
    );

    // Submit
    on<CreateProfileSubmitted>(_onSubmitted);

    // Reset
    on<CreateProfileCompletionReset>(
      _onCompletionReset,
    );
  }

  // ---------------------------------------------------------------------------
  // Navigation
  // ---------------------------------------------------------------------------

  void _onNextStep(
      CreateProfileNextStep event,
      Emitter<CreateProfileState> emit,
      ) {
    if (state.currentStep >= _totalSteps - 1) {
      return;
    }

    emit(
      state.copyWith(
        currentStep: state.currentStep + 1,
      ),
    );
  }

  void _onPreviousStep(
      CreateProfilePreviousStep event,
      Emitter<CreateProfileState> emit,
      ) {
    if (state.currentStep <= 0) {
      return;
    }

    emit(
      state.copyWith(
        currentStep: state.currentStep - 1,
      ),
    );
  }

  void _onGoToStep(
      CreateProfileGoToStep event,
      Emitter<CreateProfileState> emit,
      ) {
    if (event.step < 0 ||
        event.step >= _totalSteps) {
      return;
    }

    emit(
      state.copyWith(
        currentStep: event.step,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Step 1
  // ---------------------------------------------------------------------------

  void _onFullNameChanged(
      CreateProfileFullNameChanged event,
      Emitter<CreateProfileState> emit,
      ) {
    emit(
      state.copyWith(
        fullName: event.fullName,
      ),
    );
  }

  void _onDateOfBirthChanged(
      CreateProfileDateOfBirthChanged event,
      Emitter<CreateProfileState> emit,
      ) {
    emit(
      state.copyWith(
        dateOfBirth: event.dateOfBirth,
      ),
    );
  }

  void _onMobileNumberChanged(
      CreateProfileMobileNumberChanged event,
      Emitter<CreateProfileState> emit,
      ) {
    emit(
      state.copyWith(
        mobileNumber: event.mobileNumber,
      ),
    );
  }

  void _onEmailChanged(
      CreateProfileEmailChanged event,
      Emitter<CreateProfileState> emit,
      ) {
    emit(
      state.copyWith(
        email: event.email,
      ),
    );
  }

  void _onGenderChanged(
      CreateProfileGenderChanged event,
      Emitter<CreateProfileState> emit,
      ) {
    emit(
      state.copyWith(
        gender: event.gender,
      ),
    );
  }

  void _onIdProofUpdated(
      CreateProfileIdProofUpdated event,
      Emitter<CreateProfileState> emit,
      ) {
    emit(
      state.copyWith(
        idProofFileName: event.fileName,
        idProof: event.uploadedFile,
        clearIdProofFileName:
        event.fileName == null,
        clearIdProof:
        event.uploadedFile == null,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Step 2
  // ---------------------------------------------------------------------------

  void _onBusinessNameChanged(
      CreateProfileBusinessNameChanged event,
      Emitter<CreateProfileState> emit,
      ) {
    emit(
      state.copyWith(
        businessName: event.businessName,
      ),
    );
  }

  void _onAbnChanged(
      CreateProfileAbnChanged event,
      Emitter<CreateProfileState> emit,
      ) {
    emit(
      state.copyWith(
        abn: event.abn,
      ),
    );
  }

  void _onAcnChanged(
      CreateProfileAcnChanged event,
      Emitter<CreateProfileState> emit,
      ) {
    emit(
      state.copyWith(
        acn: event.acn,
      ),
    );
  }

  void _onAddressChanged(
      CreateProfileAddressChanged event,
      Emitter<CreateProfileState> emit,
      ) {
    emit(
      state.copyWith(
        address: event.address,
      ),
    );
  }

  void _onSuburbChanged(
      CreateProfileSuburbChanged event,
      Emitter<CreateProfileState> emit,
      ) {
    emit(
      state.copyWith(
        suburb: event.suburb,
      ),
    );
  }

  void _onStateChanged(
      CreateProfileStateChanged event,
      Emitter<CreateProfileState> emit,
      ) {
    emit(
      state.copyWith(
        stateValue: event.stateValue,
      ),
    );
  }

  void _onPostcodeChanged(
      CreateProfilePostcodeChanged event,
      Emitter<CreateProfileState> emit,
      ) {
    emit(
      state.copyWith(
        postcode: event.postcode,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Step 3
  // ---------------------------------------------------------------------------

  void _onMandatoryDocumentUpdated(
      CreateProfileMandatoryDocumentUpdated event,
      Emitter<CreateProfileState> emit,
      ) {
    final mandatoryDocs =
    Map<String, bool>.from(
      state.mandatoryDocs,
    );

    final mandatoryUploadedDocs =
    Map<String, UploadedFileData>.from(
      state.mandatoryUploadedDocs,
    );

    mandatoryDocs[event.documentName] =
        event.uploaded;

    if (event.uploaded &&
        event.uploadedFile != null) {
      mandatoryUploadedDocs[event.documentName] =
      event.uploadedFile!;
    } else {
      mandatoryUploadedDocs.remove(
        event.documentName,
      );
    }

    emit(
      state.copyWith(
        mandatoryDocs: mandatoryDocs,
        mandatoryUploadedDocs:
        mandatoryUploadedDocs,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Step 4
  // ---------------------------------------------------------------------------

  void _onRecommendedDocumentUpdated(
      CreateProfileRecommendedDocumentUpdated event,
      Emitter<CreateProfileState> emit,
      ) {
    final recommendedDocs =
    Map<String, bool>.from(
      state.recommendedDocs,
    );

    final recommendedUploadedDocs =
    Map<String, UploadedFileData>.from(
      state.recommendedUploadedDocs,
    );

    recommendedDocs[event.documentName] =
        event.uploaded;

    if (event.uploaded &&
        event.uploadedFile != null) {
      recommendedUploadedDocs[event.documentName] =
      event.uploadedFile!;
    } else {
      recommendedUploadedDocs.remove(
        event.documentName,
      );
    }

    emit(
      state.copyWith(
        recommendedDocs: recommendedDocs,
        recommendedUploadedDocs:
        recommendedUploadedDocs,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Submit
  // ---------------------------------------------------------------------------

  Future<void> _onSubmitted(
      CreateProfileSubmitted event,
      Emitter<CreateProfileState> emit,
      ) async {
    if (state.status ==
        CreateProfileStatus.loading) {
      return;
    }

    emit(
      state.copyWith(
        status: CreateProfileStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final nameParts = state.fullName
          .trim()
          .split(
        RegExp(r'\s+'),
      )
          .where(
            (value) => value.isNotEmpty,
      )
          .toList();

      final firstName = nameParts.isNotEmpty
          ? nameParts.first
          : '';

      final lastName = nameParts.length > 1
          ? nameParts.sublist(1).join(' ')
          : '';

      final uploadedDocuments =
      <register_request.Documents>[
        ...state.mandatoryUploadedDocs.entries.map(
              (entry) => _mapUploadedDocument(
            documentName: entry.key,
            uploadedFile: entry.value,
          ),
        ),
        ...state.recommendedUploadedDocs.entries.map(
              (entry) => _mapUploadedDocument(
            documentName: entry.key,
            uploadedFile: entry.value,
          ),
        ),
      ];

      final request =
      register_request.RegisterRequestModel(
        firstName: firstName,
        lastName: lastName,
        email: state.email.trim(),
        password: 'Test@123',
        phoneNumber: state.mobileNumber.trim(),
        countryCode: '+61',
        type: 'client',
        dateOfBirth: state.dateOfBirth,
        gender: state.gender.toUpperCase(),
        idProof: _mapIdProof(
          state.idProof,
        ),
        businessInfo:
        register_request.BusinessInfo(
          businessName:
          state.businessName.trim(),
          activeABN: state.abn.trim(),
          acn: state.acn.trim(),
          street1: state.address.trim(),
          suburb: state.suburb.trim(),
          state: state.stateValue,
          zipcode: state.postcode.trim(),
        ),
        documents: uploadedDocuments,
      );

      final response =
      await createProfileRepository
          .registerRequest(
        registerRequestModel: request,
      );

      if (response.status == true) {
        emit(
          state.copyWith(
            status: CreateProfileStatus.success,
            completed: true,
            response: response,
            errorMessage: '',
          ),
        );

        return;
      }

      emit(
        state.copyWith(
          status: CreateProfileStatus.failure,
          errorMessage:
          response.message ??
              'Failed to create profile',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CreateProfileStatus.failure,
          errorMessage: e
              .toString()
              .replaceFirst(
            'Exception: ',
            '',
          ),
        ),
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Upload mapping
  // ---------------------------------------------------------------------------

  register_request.IdProof? _mapIdProof(
      UploadedFileData? uploadedFile,
      ) {
    if (uploadedFile == null) {
      return null;
    }

    return register_request.IdProof(
      name: uploadedFile.name,
      url: uploadedFile.url,
      size: uploadedFile.size,
      type: _getMimeType(
        uploadedFile.fileType,
      ),
      createdAt: uploadedFile.createdAt,
    );
  }

  register_request.Documents _mapUploadedDocument({
    required String documentName,
    required UploadedFileData uploadedFile,
  }) {
    final documentTypeId =
    _getDocumentTypeId(documentName);

    if (documentTypeId == null) {
      throw Exception(
        'Document type ID not found for $documentName',
      );
    }

    return register_request.Documents(
      documentType: documentName,
      documentTypeId: documentTypeId,
      documentUrls: [
        register_request.DocumentUrls(
          name: uploadedFile.name,
          url: uploadedFile.url,
          size: uploadedFile.size,
          type: _getMimeType(
            uploadedFile.fileType,
          ),
          createdAt: uploadedFile.createdAt,
        ),
      ],
    );
  }

  String _getMimeType(
      String? fileType,
      ) {
    switch (fileType?.toLowerCase()) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';

      case 'png':
        return 'image/png';

      case 'pdf':
        return 'application/pdf';

      case 'doc':
        return 'application/msword';

      case 'docx':
        return 'application/vnd.openxmlformats-officedocument'
            '.wordprocessingml.document';

      default:
        return fileType ?? '';
    }
  }

  int? _getDocumentTypeId(
      String documentName,
      ) {
    const documentTypeIds = <String, int>{
      'NDIS Certificate of Registration': 1,
      'NDIS Audit Certificate': 2,
      'Public Liability Insurance': 3,
      'Professional Indemnity Insurance': 4,
      'Workers Compensation Insurance': 5,
      'Incident Management Policy': 6,
      'Complaints Management Policy': 7,
      'Privacy Policy': 8,
      'WHS Policy': 9,
      'Annual Compliance Declaration': 10,
      'Risk Management Policy': 11,
      'Infection Control Policy': 12,
      'Restrictive Practice Policy': 13,
    };

    return documentTypeIds[documentName];
  }

  // ---------------------------------------------------------------------------
  // Reset
  // ---------------------------------------------------------------------------

  void _onCompletionReset(
      CreateProfileCompletionReset event,
      Emitter<CreateProfileState> emit,
      ) {
    emit(
      const CreateProfileState(),
    );
  }
}