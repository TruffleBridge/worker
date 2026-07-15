import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/client_bloc/client_profile/client_profile_bloc.dart';
import '../../../../../bloc/client_bloc/client_profile/client_profile_event.dart';
import '../../../../../bloc/client_bloc/client_profile/client_profile_state.dart';
import 'client_profile_document_detail_widget.dart';

class ClientProfileUploadDocumentWidget extends StatelessWidget {
  const ClientProfileUploadDocumentWidget({super.key});

  static const Color primaryColor = Color(0xff0C8A7B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        leadingWidth: 70,
        leading: Center(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Color(0xffF1F3F5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: Colors.black87,
              ),
            ),
          ),
        ),
        title: const Text(
          "Upload Document",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),

      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {

          if (state.uploadSuccess) {

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Document uploaded successfully."),
              ),
            );

            final document = state.documents.last;

            context.read<ProfileBloc>().add(
              const ResetUploadSuccessEvent(),
            );

            final profileBloc = context.read<ProfileBloc>();

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: profileBloc,
                  child: ClientProfileDocumentDetailsWidget(
                    document: document,
                    index: state.documents.length - 1,
                  ),
                ),
              ),
            );
          }

          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.errorMessage!),
              ),
            );
          }
        },

        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// Document Type
                const Text(
                  "Document Type",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  height: 52,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: const Color(0xffE4E7EC),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: "NDIS Plan",
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: const [
                        DropdownMenuItem(
                          value: "NDIS Plan",
                          child: Text("NDIS Plan"),
                        ),
                        DropdownMenuItem(
                          value: "Passport",
                          child: Text("Passport"),
                        ),
                        DropdownMenuItem(
                          value: "Driver License",
                          child: Text("Driver License"),
                        ),
                      ],
                      onChanged: (_) {},
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                /// Upload Area
                Container(
                  width: double.infinity,
                  height: 230,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: primaryColor,
                      width: 1.2,
                    ),
                  ),

                  child: GestureDetector(
                    onTap: () {
                      context.read<ProfileBloc>().add(
                        PickDocumentEvent(),
                      );
                    },
                    child: state.selectedDocument == null
                        ? _uploadPlaceholder(context)
                        : _selectedDocument(context, state),
                  ),
                ),

                const SizedBox(height: 20),

                /// Camera & Files Buttons
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // TODO: Camera picker
                          },
                          icon: const Icon(
                            Icons.photo_camera_outlined,
                            color: primaryColor,
                            size: 20,
                          ),
                          label: const Text(
                            "Camera",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(
                              color: Color(0xffE3E7EC),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            context.read<ProfileBloc>().add(
                              PickDocumentEvent(),
                            );
                          },
                          icon: const Icon(
                            Icons.insert_drive_file_outlined,
                            color: primaryColor,
                            size: 20,
                          ),
                          label: const Text(
                            "Files",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(
                              color: Color(0xffE3E7EC),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                /// Upload Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: state.selectedDocument == null
                        ? null
                        : () {
                      context.read<ProfileBloc>().add(
                        UploadDocumentEvent(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      disabledBackgroundColor: Colors.grey.shade300,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: state.loading
                        ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                        : const Text(
                      "Upload Document",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _uploadPlaceholder(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: Color(0xffEAF7F5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.cloud_upload_outlined,
                color: primaryColor,
                size: 30,
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              "Tap to upload or take a photo",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Supported formats: PDF, JPG, PNG",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _selectedDocument(BuildContext context,
      ProfileState state,) {
    final PlatformFile file = state.selectedDocument!;

    final extension = (file.extension ?? "").toLowerCase();

    final bool isImage =
        extension == "jpg" ||
            extension == "jpeg" ||
            extension == "png";

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(14),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: isImage && file.path != null
                ? Image.file(
              File(file.path!),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            )
                : Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.picture_as_pdf,
                    size: 70,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    file.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        Positioned(
          top: 10,
          right: 10,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              context.read<ProfileBloc>().add(
                const RemoveSelectedDocumentEvent(),
              );
            },
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.close,
                color: Colors.black87,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}