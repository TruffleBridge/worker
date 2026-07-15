import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';
import 'package:nimora_worker/routes/app_router.dart';

class CreateProfileAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBack;

  const CreateProfileAppBar({
    super.key,
    required this.title,
    required this.onBack,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF1F1F1),
      surfaceTintColor: AppColors.background,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      leadingWidth: 56,
      leading: Padding(
        padding: const EdgeInsets.only(
          left: AppDimensions.paddingS,
        ),
        child: IconButton(
          onPressed: onBack,
          padding: EdgeInsets.zero,
          icon: Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: AppColors.chipBg,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.arrow_back,
              size: 18,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
      title: Text(
        title,
        style: NdisThemeStyle.headlineMedium,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: InkWell(
            onTap: () {
              context.go(AppRoutes.clientHome);
            },
            child: const Text('Skip'),
          ),
        ),
      ],
    );
  }
}

class StepProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepProgressBar({
    super.key,
    required this.currentStep,
    this.totalSteps = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingM,
        vertical: 10,
      ),
      child: Row(
        children: List.generate(totalSteps, (index) {
          final bool isActive = index <= currentStep;

          return Expanded(
            child: Container(
              margin: EdgeInsets.only(
                right: index == totalSteps - 1
                    ? 0
                    : AppDimensions.paddingXS + 2,
              ),
              height: 4,
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.primary
                    : AppColors.trackInactive,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class LabeledField extends StatelessWidget {
  final String label;
  final String hint;
  final bool optional;
  final IconData? icon;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Widget? suffix;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final VoidCallback? onTap;
  final int maxLines;

  const LabeledField({
    super.key,
    required this.label,
    required this.hint,
    this.optional = false,
    this.icon,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.suffix,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        AppDimensions.radiusM,
      ),
      borderSide: const BorderSide(
        color: AppColors.cardBorder,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: NdisThemeStyle.label,
            children: [
              TextSpan(text: label),
              if (optional)
                TextSpan(
                  text: ' (Optional)',
                  style: NdisThemeStyle.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          onChanged: onChanged,
          readOnly: readOnly,
          onTap: onTap,
          maxLines: maxLines,
          style: NdisThemeStyle.bodyMedium.copyWith(
            color: const Color(0xFF99A1AF),
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: NdisThemeStyle.hint,
            prefixIcon: icon != null
                ? Icon(
              icon,
              size: 18,
              color: AppColors.textHint,
            )
                : null,
            suffixIcon: suffix,
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            border: baseBorder,
            enabledBorder: baseBorder,
            focusedBorder: baseBorder.copyWith(
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.4,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class UploadRow extends StatelessWidget {
  final String label;
  final bool uploaded;
  final VoidCallback onUpload;

  const UploadRow({
    super.key,
    required this.label,
    required this.onUpload,
    this.uploaded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: AppDimensions.paddingS,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.cardBorder,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: NdisThemeStyle.bodyMedium.copyWith(
                color: uploaded
                    ? AppColors.textPrimary
                    : AppColors.textHint,
              ),
            ),
          ),
          InkWell(
            onTap: onUpload,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFFE5E7EB),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/upload_icon.svg',
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Upload',
                      style: NdisThemeStyle.bodyMedium.copyWith(
                        color: const Color(0xFF4A5565),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool showChevron;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.showChevron = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.buttonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label),
            if (showChevron) ...[
              const SizedBox(width: 6),
              const Icon(
                Icons.chevron_right,
                size: 18,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.buttonHeight,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          side: const BorderSide(
            color: AppColors.cardBorder,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.radiusM,
            ),
          ),
        ),
        child: Text(
          label,
          style: NdisThemeStyle.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}