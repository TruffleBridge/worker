import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';

class SocialSplashButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;
  final bool isApple;
  final bool isLoading;

  const SocialSplashButton({
    required this.imagePath,
    required this.label,
    required this.onTap,
    this.isApple = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: AppDimensions.buttonHeight,
        decoration: BoxDecoration(
          color: !isApple ? AppColors.white : Colors.black,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          border: Border.all(color: AppColors.white.withValues(alpha: 0.45)),
        ),
        child: /*isLoading
            ? Center(
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: !isApple ? AppColors.black : AppColors.white,
                  ),
                ),
              )
            :*/ Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    imagePath,
                    width: isApple ? 24 : 18,
                    height: isApple ? 24 : 18,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    label,
                    style: NdisThemeStyle.bodyMedium.copyWith(
                      color: !isApple ? AppColors.black : Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
