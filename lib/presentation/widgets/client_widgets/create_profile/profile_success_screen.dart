import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nimora_worker/core/constants/assets_images.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/create_profile/create_profile_widgets.dart';

class ProfileSuccessScreen extends StatelessWidget {
  final VoidCallback onFindWorkers;
  final VoidCallback onPostJob;
  final VoidCallback onGoToDashboard;
  final VoidCallback onBack;

  const ProfileSuccessScreen({
    super.key,
    required this.onFindWorkers,
    required this.onPostJob,
    required this.onGoToDashboard,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: AppPaddings.page,
          child: Column(
            children: [
              const SizedBox(height: 32),

              // Container(
              //   width: 84,
              //   height: 84,
              //   decoration: const BoxDecoration(
              //     color: AppColors.successBg,
              //     shape: BoxShape.circle,
              //   ),
              //   child: const Icon(
              //     Icons.check,
              //     color: AppColors.success,
              //     size: 44,
              //   ),
              // ),
              SvgPicture.asset('assets/images/success_tick_icon.svg'),
              const SizedBox(height: AppDimensions.paddingL),

              Text(
                'Profile Successfully Created!',
                style: NdisThemeStyle.headlineLarge.copyWith(
                  color: Color(0xFF101828),
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppDimensions.paddingS),

              Text(
                'Welcome to Nimora. Your profile is ready, and you can now start finding the right support workers for your needs.',
                style: NdisThemeStyle.bodyMedium.copyWith(
                  color: Color(0xFF7F7F7F),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppDimensions.paddingXL),

              _ActionCard(
                icon: AssetSVGImages.needSupport,
                title: 'Find Workers',
                subtitle: 'Browse verified support workers in your area.',
                onTap: onFindWorkers,
              ),

              const SizedBox(height: AppDimensions.paddingS),

              _ActionCard(
                icon: AssetSVGImages.wantToWork,
                title: 'Post a Job',
                subtitle: 'Create a job post to let workers come to you.',
                onTap: onPostJob,
              ),

              const Spacer(),

              PrimaryButton(
                label: 'Go to Dashboard',
                showChevron: false,
                onPressed: onGoToDashboard,
              ),

              const SizedBox(height: AppDimensions.paddingM),

              SecondaryButton(label: 'Back', onPressed: onBack),

              const SizedBox(height: AppDimensions.paddingS),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(4),

              decoration: BoxDecoration(
                color: title == 'Find Workers'
                    ? const Color(0xFFCFF3FF)
                    : const Color(0xFF1F95F2).withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(icon, fit: BoxFit.contain),
            ),
            const SizedBox(width: AppDimensions.paddingM - 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: NdisThemeStyle.label.copyWith(
                      color: Color(0xFF101828),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: NdisThemeStyle.bodyMedium.copyWith(
                      color: Color(0xFF6A7282),
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
