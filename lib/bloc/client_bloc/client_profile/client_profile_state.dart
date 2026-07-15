import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

class DocumentModel extends Equatable {
  final String name;
  final String type;
  final String path;
  final DateTime uploadDate;
  final int fileSize;
  final String status;

  const DocumentModel({
    required this.name,
    required this.type,
    required this.path,
    required this.uploadDate,
    required this.fileSize,
    this.status = "VERIFIED",
  });

  @override
  List<Object?> get props => [name, type, path, uploadDate, fileSize, status];
}

class PaymentCardModel extends Equatable {
  final String cardName;
  final String expiry;
  final bool isDefault;

  const PaymentCardModel({
    required this.cardName,
    required this.expiry,
    this.isDefault = false,
  });

  @override
  List<Object?> get props => [cardName, expiry, isDefault];
}

class ProfileState extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String dob;
  final String location;
  final String profileImage;
  final bool loading;
  final bool uploadSuccess;
  final bool newMessages;
  final bool jobUpdates;
  final bool paymentAlerts;
  final bool documentAlerts;
  final bool twoFactorEnabled;
  final bool passwordUpdating;
  final String passwordSuccess;
  final String passwordError;
  final bool updatingProfile;
  final String profileSuccess;
  final String profileError;
  final PlatformFile? selectedDocument;
  final List<DocumentModel> documents;
  final List<PaymentCardModel> paymentCards;
  final String? successMessage;
  final String? errorMessage;

  const ProfileState({
    this.name = "Margaret Thatcher",
    this.email = "m.thatcher@email.com",
    this.phone = "+61 400 000 000",
    this.dob = "12/04/1965",
    this.location = "Sydney, NSW",
    this.profileImage = "assets/images/profile.jpg",
    this.loading = false,
    this.uploadSuccess = false,
    this.newMessages = true,
    this.jobUpdates = true,
    this.paymentAlerts = true,
    this.documentAlerts = true,
    this.twoFactorEnabled = false,

    this.passwordUpdating = false,
    this.passwordSuccess = "",
    this.passwordError = "",
    this.updatingProfile = false,
    this.profileSuccess = "",
    this.profileError = "",
    this.selectedDocument,
    this.documents = const [],
    this.paymentCards = const [],
    this.successMessage,
    this.errorMessage,
  });

  ProfileState copyWith({
    String? name,
    String? email,
    String? phone,
    String? dob,
    String? location,
    String? profileImage,
    bool? loading,
    bool? uploadSuccess,
    bool? newMessages,
    bool? jobUpdates,
    bool? paymentAlerts,
    bool? documentAlerts,
    bool? twoFactorEnabled,
    bool? passwordUpdating,
    String? passwordSuccess,
    String? passwordError,
    bool? updatingProfile,
    String? profileSuccess,
    String? profileError,
    PlatformFile? selectedDocument,
    bool clearSelectedDocument = false,
    List<DocumentModel>? documents,
    List<PaymentCardModel>? paymentCards,
    String? successMessage,
    String? errorMessage,
  }) {
    return ProfileState(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      dob: dob ?? this.dob,
      location: location ?? this.location,
      profileImage: profileImage ?? this.profileImage,
      loading: loading ?? this.loading,
      uploadSuccess: uploadSuccess ?? this.uploadSuccess,
      newMessages: newMessages ?? this.newMessages,
      jobUpdates: jobUpdates ?? this.jobUpdates,
      paymentAlerts: paymentAlerts ?? this.paymentAlerts,
      documentAlerts: documentAlerts ?? this.documentAlerts,
      twoFactorEnabled: twoFactorEnabled ?? this.twoFactorEnabled,
      passwordUpdating: passwordUpdating ?? this.passwordUpdating,
      passwordSuccess: passwordSuccess ?? this.passwordSuccess,
      passwordError: passwordError ?? this.passwordError,
      updatingProfile: updatingProfile ?? this.updatingProfile,
      profileSuccess: profileSuccess ?? this.profileSuccess,
      profileError: profileError ?? this.profileError,
      selectedDocument: clearSelectedDocument
          ? null
          : (selectedDocument ?? this.selectedDocument),
      documents: documents ?? this.documents,
      paymentCards: paymentCards ?? this.paymentCards,
      successMessage: successMessage,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    name,
    email,
    phone,
    dob,
    location,
    profileImage,
    loading,
    uploadSuccess,
    newMessages,
    jobUpdates,
    paymentAlerts,
    documentAlerts,
    twoFactorEnabled,
    passwordUpdating,
    passwordSuccess,
    passwordError,
    updatingProfile,
    profileSuccess,
    profileError,
    selectedDocument,
    documents,
    paymentCards,
    successMessage,
    errorMessage,
  ];
}
