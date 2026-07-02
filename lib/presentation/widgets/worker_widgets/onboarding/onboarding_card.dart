import 'package:flutter/material.dart';
import 'package:nimora_worker/core/constants/nimora_colors.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';
import 'package:nimora_worker/domain/model/view_model/onboarding_item_model.dart';

class OnboardingCard extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildImage(context),
        Transform.translate(
          offset: const Offset(0, -30),
          child: _buildContent(),
        ),
      ],
    );
  }

  Widget _buildImage(BuildContext context) {
    final imageHeight =
        MediaQuery.of(context).size.height * AppDimensions.imageHeightRatio;

    return SizedBox(
      height: imageHeight,
      width: double.infinity,
      child: Image.asset(
        item.imagePath,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return _buildImagePlaceholder(imageHeight);
        },
      ),
    );
  }

  Widget _buildImagePlaceholder(double height) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryLight.withValues(alpha: 0.3),
            AppColors.primary.withValues(alpha: 0.5),
          ],
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.health_and_safety_outlined,
          size: 80,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.paddingL,
        AppDimensions.paddingXL,
        AppDimensions.paddingL,
        AppDimensions.paddingXL,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: NdisThemeStyle.headlineLarge.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: NimoraColors.onboardingCardTitleColor,
            ),
          ),

          const SizedBox(height: AppDimensions.paddingM),

          Text(
            item.subtitle,
            style: NdisThemeStyle.headlineLarge.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: NimoraColors.onboardingCardSubtitleColor,
            ),
          ),
        ],
      ),
    );
  }
}
