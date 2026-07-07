import 'package:flutter/material.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/create_profile/create_profile_data.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/create_profile/create_profile_widgets.dart';

class Step4RecommendedDocuments extends StatefulWidget {
  final CreateProfileData data;
  final VoidCallback onSubmit;
  final VoidCallback onBack;

  const Step4RecommendedDocuments({
    super.key,
    required this.data,
    required this.onSubmit,
    required this.onBack,
  });

  @override
  State<Step4RecommendedDocuments> createState() =>
      _Step4RecommendedDocumentsState();
}

class _Step4RecommendedDocumentsState
    extends State<Step4RecommendedDocuments> {
  void _toggle(String key) {
    setState(() {
      widget.data.recommendedDocs[key] = true;
    });

    // TODO: integrate actual file picker here
  }

  @override
  Widget build(BuildContext context) {
    final docs = widget.data.recommendedDocs;

    return SafeArea(
      top: false,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: AppPaddings.page,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight - AppDimensions.paddingM,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _DocumentStepHeader(
                      title: 'Document Registration',
                      // badgeText: 'R',
                    ),
                    const SizedBox(height: AppDimensions.paddingL),

                    Text(
                      'Strongly Recommended (Optional)',
                      style: NdisThemeStyle.label,
                    ),
                    const SizedBox(height: AppDimensions.paddingS),

                    ...docs.entries.map(
                          (entry) => UploadRow(
                        label: entry.key,
                        uploaded: entry.value,
                        onUpload: () => _toggle(entry.key),
                      ),
                    ),

                    const Spacer(),

                    PrimaryButton(
                      label: 'Submit',
                      showChevron: false,
                      onPressed: widget.onSubmit,
                    ),
                    const SizedBox(height: AppDimensions.paddingM),

                    SecondaryButton(
                      label: 'Back',
                      onPressed: widget.onBack,
                    ),
                  ],
                ),
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
  // final String badgeText;

  const _DocumentStepHeader({
    required this.title,
    // required this.badgeText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: NdisThemeStyle.sectionTitle,
          ),
        ),
        // Container(
        //   width: 32,
        //   height: 32,
        //   decoration: const BoxDecoration(
        //     color: AppColors.primary,
        //     shape: BoxShape.circle,
        //   ),
        //   alignment: Alignment.center,
        //   child: Text(
        //     badgeText,
        //     style: NdisThemeStyle.bodyMedium.copyWith(
        //       color: AppColors.white,
        //       fontWeight: FontWeight.w700,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}