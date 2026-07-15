import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimora_worker/core/enums/upload_document_type.dart';
import 'package:nimora_worker/domain/repositories/upload_document/upload_document_repository.dart';
import 'package:nimora_worker/domain/model/response/upload_response_model.dart';

part 'upload_document_event.dart';
part 'upload_document_state.dart';

class UploadDocumentBloc extends Bloc<UploadEvent, UploadState> {
  final UploadRepository uploadRepository;

  UploadDocumentBloc({
    required this.uploadRepository,
  }) : super(const UploadState()) {
    on<UploadFileRequested>(_onUploadFileRequested);
  }

  Future<void> _onUploadFileRequested(
      UploadFileRequested event,
      Emitter<UploadState> emit,
      ) async {
    emit(
      state.copyWith(
        isUploading: true,
        uploadType: event.uploadType,
        uploadingDocumentName: event.documentName,
        clearUploadedDocumentName: true,
        clearUploadedFileName: true,
        clearUploadResponse: true,
        clearErrorMessage: true,
      ),
    );

    try {
      final response = await uploadRepository.uploadFile(
        filePath: event.filePath,
        fileName: event.fileName,
      );

      debugPrint(
        'UPLOAD RESPONSE: ${response.toJson()}',
      );

      if (response.status != true || response.data == null) {
        throw Exception(
          response.message ?? 'Failed to upload file',
        );
      }

      emit(
        state.copyWith(
          isUploading: false,
          uploadType: event.uploadType,
          uploadedDocumentName: event.documentName,
          uploadedFileName: event.fileName,
          uploadResponse: response,
          clearUploadingDocumentName: true,
          clearErrorMessage: true,
        ),
      );
    } catch (e) {
      debugPrint(
        'UPLOAD ERROR: $e',
      );

      emit(
        state.copyWith(
          isUploading: false,
          uploadType: event.uploadType,
          errorMessage: e
              .toString()
              .replaceFirst(
            'Exception: ',
            '',
          ),
          clearUploadingDocumentName: true,
          clearUploadedDocumentName: true,
          clearUploadedFileName: true,
          clearUploadResponse: true,
        ),
      );
    }
  }
}