part of 'upload_document_bloc.dart';

abstract class UploadEvent extends Equatable {
  const UploadEvent();

  @override
  List<Object?> get props => [];
}

class UploadFileRequested extends UploadEvent {
  final UploadDocumentType uploadType;
  final String documentName;
  final String filePath;
  final String fileName;

  const UploadFileRequested({
    required this.uploadType,
    required this.documentName,
    required this.filePath,
    required this.fileName,
  });

  @override
  List<Object?> get props => [
    uploadType,
    documentName,
    filePath,
    fileName,
  ];
}