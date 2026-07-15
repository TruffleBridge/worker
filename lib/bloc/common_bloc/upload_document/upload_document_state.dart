part of 'upload_document_bloc.dart';

class UploadState extends Equatable {
  final bool isUploading;
  final UploadDocumentType? uploadType;
  final String? uploadingDocumentName;
  final String? uploadedDocumentName;
  final String? uploadedFileName;
  final UploadFileResponseModel? uploadResponse;
  final String? errorMessage;

  const UploadState({
    this.isUploading = false,
    this.uploadType,
    this.uploadingDocumentName,
    this.uploadedDocumentName,
    this.uploadedFileName,
    this.uploadResponse,
    this.errorMessage,
  });

  UploadState copyWith({
    bool? isUploading,
    UploadDocumentType? uploadType,
    String? uploadingDocumentName,
    String? uploadedDocumentName,
    String? uploadedFileName,
    UploadFileResponseModel? uploadResponse,
    String? errorMessage,
    bool clearUploadType = false,
    bool clearUploadingDocumentName = false,
    bool clearUploadedDocumentName = false,
    bool clearUploadedFileName = false,
    bool clearUploadResponse = false,
    bool clearErrorMessage = false,
  }) {
    return UploadState(
      isUploading: isUploading ?? this.isUploading,
      uploadType: clearUploadType
          ? null
          : uploadType ?? this.uploadType,
      uploadingDocumentName: clearUploadingDocumentName
          ? null
          : uploadingDocumentName ?? this.uploadingDocumentName,
      uploadedDocumentName: clearUploadedDocumentName
          ? null
          : uploadedDocumentName ?? this.uploadedDocumentName,
      uploadedFileName: clearUploadedFileName
          ? null
          : uploadedFileName ?? this.uploadedFileName,
      uploadResponse: clearUploadResponse
          ? null
          : uploadResponse ?? this.uploadResponse,
      errorMessage: clearErrorMessage
          ? null
          : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isUploading,
    uploadType,
    uploadingDocumentName,
    uploadedDocumentName,
    uploadedFileName,
    uploadResponse,
    errorMessage,
  ];
}