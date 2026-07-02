import 'package:flutter/material.dart';
import 'package:nimora_worker/core/constants/nimora_colors.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';

class OnboardingDotsIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;

  const OnboardingDotsIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.primary
                : NimoraColors.onboardingDotsIndicatorColor,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
