import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimora_worker/bloc/client_bloc/create_profile/create_profile_bloc.dart';
import 'package:nimora_worker/bloc/common_bloc/upload_document/upload_document_bloc.dart';
import 'package:nimora_worker/core/enums/upload_document_type.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/create_profile/create_profile_widgets.dart';

class Step3MandatoryDocuments extends StatefulWidget {
  final VoidCallback onContinue;
  final VoidCallback onBack;

  const Step3MandatoryDocuments({
    super.key,
    required this.onContinue,
    required this.onBack,
  });

  @override
  State<Step3MandatoryDocuments> createState() =>
      _Step3MandatoryDocumentsState();
}

class _Step3MandatoryDocumentsState extends State<Step3MandatoryDocuments> {
  Future<void> _pickAndUploadFile(String documentName) async {
    final FilePickerResult? result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
      allowMultiple: false,
    );

    if (result == null || result.files.isEmpty) {
      return;
    }

    final PlatformFile file = result.files.single;

    if (file.path == null) {
      return;
    }

    if (!mounted) {
      return;
    }

    context.read<UploadDocumentBloc>().add(
      UploadFileRequested(
        uploadType: UploadDocumentType.mandatoryDocument,
        documentName: documentName,
        filePath: file.path!,
        fileName: file.name,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UploadDocumentBloc, UploadState>(
      listenWhen: (previous, current) {
        return current.uploadType == UploadDocumentType.mandatoryDocument &&
            (previous.uploadResponse != current.uploadResponse ||
                previous.errorMessage != current.errorMessage);
      },
      listener: (context, uploadState) {
        final uploadedFile = uploadState.uploadResponse?.data;
        final documentName = uploadState.uploadedDocumentName;

        if (documentName != null && uploadedFile != null) {
          context.read<CreateProfileBloc>().add(
            CreateProfileMandatoryDocumentUpdated(
              documentName: documentName,
              uploaded: true,
              uploadedFile: uploadedFile,
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Document uploaded successfully')),
          );
        }

        if (uploadState.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(uploadState.errorMessage!)));
        }
      },
      child: BlocBuilder<CreateProfileBloc, CreateProfileState>(
        builder: (context, state) {
          final docs = state.mandatoryDocs;

          return SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: AppPaddings.page,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _DocumentStepHeader(title: 'Document Registration'),
                  const SizedBox(height: AppDimensions.paddingL),
                  Text('Mandatory Documents', style: NdisThemeStyle.label),
                  const SizedBox(height: AppDimensions.paddingS),
                  BlocBuilder<UploadDocumentBloc, UploadState>(
                    builder: (context, uploadState) {
                      return Column(
                        children: docs.entries.map((entry) {
                          final isUploadingMandatoryDocument =
                              uploadState.isUploading &&
                              uploadState.uploadType ==
                                  UploadDocumentType.mandatoryDocument;

                          return UploadRow(
                            label: entry.key,
                            uploaded: entry.value,
                            onUpload: isUploadingMandatoryDocument
                                ? () {}
                                : () {
                                    _pickAndUploadFile(entry.key);
                                  },
                            onRemoved: (){},
                          );
                        }).toList(),
                      );
                    },
                  ),
                  const SizedBox(height: AppDimensions.paddingL),
                  BlocBuilder<UploadDocumentBloc, UploadState>(
                    builder: (context, uploadState) {
                      final isUploadingMandatoryDocument =
                          uploadState.isUploading &&
                          uploadState.uploadType ==
                              UploadDocumentType.mandatoryDocument;

                      return PrimaryButton(
                        label: isUploadingMandatoryDocument
                            ? 'Uploading...'
                            : 'Continue',
                        onPressed: isUploadingMandatoryDocument
                            ? () {}
                            : widget.onContinue,
                      );
                    },
                  ),
                  const SizedBox(height: AppDimensions.paddingM),
                  BlocBuilder<UploadDocumentBloc, UploadState>(
                    builder: (context, uploadState) {
                      final isUploadingMandatoryDocument =
                          uploadState.isUploading &&
                          uploadState.uploadType ==
                              UploadDocumentType.mandatoryDocument;

                      return SecondaryButton(
                        label: 'Back',
                        onPressed: isUploadingMandatoryDocument
                            ? () {}
                            : widget.onBack,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DocumentStepHeader extends StatelessWidget {
  final String title;

  const _DocumentStepHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title, style: NdisThemeStyle.sectionTitle)),
      ],
    );
  }
}
