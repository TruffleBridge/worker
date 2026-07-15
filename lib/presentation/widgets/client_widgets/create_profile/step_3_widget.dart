import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimora_worker/bloc/client_bloc/create_profile/create_profile_bloc.dart';
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

class _Step3MandatoryDocumentsState
    extends State<Step3MandatoryDocuments> {
  void _toggle(String key) {
    context.read<CreateProfileBloc>().add(
      CreateProfileMandatoryDocumentUpdated(
        documentName: key,
        uploaded: true,
      ),
    );

    // TODO: integrate actual file picker here
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProfileBloc, CreateProfileState>(
      builder: (context, state) {
        final docs = state.mandatoryDocs;

        return SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: AppPaddings.page,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _DocumentStepHeader(
                  title: 'Document Registration',
                  // badgeText: 'M',
                ),
                const SizedBox(height: AppDimensions.paddingL),

                Text(
                  'Mandatory Documents',
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

                const SizedBox(height: AppDimensions.paddingL),

                PrimaryButton(
                  label: 'Continue',
                  onPressed: widget.onContinue,
                ),

                const SizedBox(height: AppDimensions.paddingM),

                SecondaryButton(
                  label: 'Back',
                  onPressed: widget.onBack,
                ),
              ],
            ),
          ),
        );
      },
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