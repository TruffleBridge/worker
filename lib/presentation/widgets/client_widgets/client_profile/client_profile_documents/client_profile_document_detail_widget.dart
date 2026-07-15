import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/client_bloc/client_profile/client_profile_bloc.dart';
import '../../../../../bloc/client_bloc/client_profile/client_profile_event.dart';
import '../../../../../bloc/client_bloc/client_profile/client_profile_state.dart';

class ClientProfileDocumentDetailsWidget extends StatelessWidget {
  const ClientProfileDocumentDetailsWidget({
    super.key,
    required this.document,
    required this.index,
  });

  final DocumentModel document;
  final int index;

  static const Color primaryColor = Color(0xff0C8A7B);

  String get formattedDate {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];

    return "${document.uploadDate.day} "
        "${months[document.uploadDate.month - 1]} "
        "${document.uploadDate.year}";
  }

  String get formattedSize {
    return "${(document.fileSize / 1024 / 1024).toStringAsFixed(2)} MB";
  }

  bool get isImage {
    return document.path.toLowerCase().endsWith(".jpg") ||
        document.path.toLowerCase().endsWith(".jpeg") ||
        document.path.toLowerCase().endsWith(".png");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
        title: Text(
          document.type,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Column(
          children: [
            // Document Preview
            Container(
              width: double.infinity,

              height: 220,

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(18),
              ),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),

                child: isImage
                    ? Image.file(File(document.path), fit: BoxFit.cover)
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          const Icon(
                            Icons.picture_as_pdf,

                            color: Colors.red,

                            size: 80,
                          ),

                          const SizedBox(height: 10),

                          Text(
                            "PDF",

                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
              ),
            ),

            const SizedBox(height: 22),

            // Details Card
            Container(
              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(18),
              ),

              child: Column(
                children: [
                  _tile("Document Type", document.type),

                  _divider(),

                  _tile("Upload Date", formattedDate),

                  _divider(),

                  _tile("File Size", formattedSize),

                  _divider(),

                  Padding(
                    padding: const EdgeInsets.all(18),

                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Status",

                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,

                            vertical: 6,
                          ),

                          decoration: BoxDecoration(
                            color: const Color(0xffE9F7F5),

                            borderRadius: BorderRadius.circular(20),
                          ),

                          child: Text(
                            document.status,

                            style: const TextStyle(
                              color: primaryColor,
                               fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 52,
                    child: OutlinedButton.icon(
                      onPressed: () {},

                      icon: const Icon(
                        Icons.download_outlined,
                        color: primaryColor,
                        size: 20,
                      ),

                      label: const Text(
                        "Download",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        side: const BorderSide(
                          color: primaryColor,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: SizedBox(
                    height: 52,
                    child: OutlinedButton.icon(
                      onPressed: () {},

                      icon: const Icon(
                        Icons.share_outlined,
                        color: primaryColor,
                        size: 20,
                      ),

                      label: const Text(
                        "Share",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        side: const BorderSide(
                          color: primaryColor,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            TextButton(
              onPressed: () {
                context.read<ProfileBloc>().add(RemoveDocumentEvent(index));

                Navigator.pop(context);
              },

              child: const Text(
                "Remove Document",

                style: TextStyle(
                  color: Colors.red,

                  fontSize: 17,

                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Divider(height: 1, color: Colors.grey.shade300);
  }

  Widget _tile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),

      child: Row(
        children: [
          Expanded(
            child: Text(
              title,

              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ),

          Text(
            value,

            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
