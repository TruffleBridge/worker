part of 'create_profile_bloc.dart';

class CreateProfileState extends Equatable {
  final int currentStep;
  final bool completed;
  final CreateProfileStatus status;

  // ---------------------------------------------------------------------------
  // Step 1 - Personal details
  // ---------------------------------------------------------------------------

  final String fullName;
  final String dateOfBirth;
  final String mobileNumber;
  final String email;
  final String gender;
  final String? idProofFileName;
  final UploadedFileData? idProof;

  // ---------------------------------------------------------------------------
  // Step 2 - Business details
  // ---------------------------------------------------------------------------

  final String businessName;
  final String abn;
  final String acn;
  final String address;
  final String suburb;
  final String stateValue;
  final String postcode;

  // ---------------------------------------------------------------------------
  // Step 3 - Mandatory documents
  // ---------------------------------------------------------------------------

  final Map<String, bool> mandatoryDocs;
  final Map<String, UploadedFileData> mandatoryUploadedDocs;

  // ---------------------------------------------------------------------------
  // Step 4 - Recommended documents
  // ---------------------------------------------------------------------------

  final Map<String, bool> recommendedDocs;
  final Map<String, UploadedFileData> recommendedUploadedDocs;

  // ---------------------------------------------------------------------------
  // API
  // ---------------------------------------------------------------------------

  final RegisterResponseModel? response;
  final String errorMessage;

  const CreateProfileState({
    this.currentStep = 0,
    this.completed = false,
    this.status = CreateProfileStatus.initial,

    // Step 1
    this.fullName = '',
    this.dateOfBirth = '',
    this.mobileNumber = '',
    this.email = '',
    this.gender = '',
    this.idProofFileName,
    this.idProof,

    // Step 2
    this.businessName = '',
    this.abn = '',
    this.acn = '',
    this.address = '',
    this.suburb = '',
    this.stateValue = '',
    this.postcode = '',

    // Step 3
    this.mandatoryDocs = const {
      'NDIS Certificate of Registration': false,
      'NDIS Audit Certificate': false,
      'Public Liability Insurance': false,
      'Professional Indemnity Insurance': false,
      'Workers Compensation Insurance': false,
      'Incident Management Policy': false,
      'Complaints Management Policy': false,
      'Privacy Policy': false,
      'WHS Policy': false,
    },
    this.mandatoryUploadedDocs = const {},

    // Step 4
    this.recommendedDocs = const {
      'Annual Compliance Declaration': false,
      'Risk Management Policy': false,
      'Infection Control Policy': false,
      'Restrictive Practice Policy': false,
    },
    this.recommendedUploadedDocs = const {},

    // API
    this.response,
    this.errorMessage = '',
  });

  CreateProfileState copyWith({
    int? currentStep,
    bool? completed,
    CreateProfileStatus? status,

    // Step 1
    String? fullName,
    String? dateOfBirth,
    String? mobileNumber,
    String? email,
    String? gender,
    String? idProofFileName,
    UploadedFileData? idProof,
    bool clearIdProofFileName = false,
    bool clearIdProof = false,

    // Step 2
    String? businessName,
    String? abn,
    String? acn,
    String? address,
    String? suburb,
    String? stateValue,
    String? postcode,

    // Step 3
    Map<String, bool>? mandatoryDocs,
    Map<String, UploadedFileData>? mandatoryUploadedDocs,

    // Step 4
    Map<String, bool>? recommendedDocs,
    Map<String, UploadedFileData>? recommendedUploadedDocs,

    // API
    RegisterResponseModel? response,
    String? errorMessage,
    bool clearResponse = false,
  }) {
    return CreateProfileState(
      currentStep: currentStep ?? this.currentStep,
      completed: completed ?? this.completed,
      status: status ?? this.status,

      // Step 1
      fullName: fullName ?? this.fullName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      idProofFileName: clearIdProofFileName
          ? null
          : idProofFileName ?? this.idProofFileName,
      idProof: clearIdProof
          ? null
          : idProof ?? this.idProof,

      // Step 2
      businessName: businessName ?? this.businessName,
      abn: abn ?? this.abn,
      acn: acn ?? this.acn,
      address: address ?? this.address,
      suburb: suburb ?? this.suburb,
      stateValue: stateValue ?? this.stateValue,
      postcode: postcode ?? this.postcode,

      // Step 3
      mandatoryDocs: mandatoryDocs ?? this.mandatoryDocs,
      mandatoryUploadedDocs:
      mandatoryUploadedDocs ?? this.mandatoryUploadedDocs,

      // Step 4
      recommendedDocs: recommendedDocs ?? this.recommendedDocs,
      recommendedUploadedDocs:
      recommendedUploadedDocs ?? this.recommendedUploadedDocs,

      // API
      response: clearResponse
          ? null
          : response ?? this.response,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    currentStep,
    completed,
    status,

    // Step 1
    fullName,
    dateOfBirth,
    mobileNumber,
    email,
    gender,
    idProofFileName,
    idProof,

    // Step 2
    businessName,
    abn,
    acn,
    address,
    suburb,
    stateValue,
    postcode,

    // Step 3
    mandatoryDocs,
    mandatoryUploadedDocs,

    // Step 4
    recommendedDocs,
    recommendedUploadedDocs,

    // API
    response,
    errorMessage,
  ];
}