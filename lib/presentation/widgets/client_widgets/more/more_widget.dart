import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nimora_worker/core/constants/nimora_colors.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';
import 'package:nimora_worker/routes/app_router.dart';

class MoreWidget extends StatelessWidget {
  const MoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
      child: Center(
        child: GestureDetector(
          onTap: () => _showLogoutDialog(context),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: NimoraColors.logoutButtonBgColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: NimoraColors.logoutButtonBorderColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.logout_rounded,
                  color: NimoraColors.logoutButtonTextColor,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  'Logout',
                  style: NdisThemeStyle.headlineLarge.copyWith(
                    color: NimoraColors.logoutButtonTextColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
      ),
      title: Text('Logout', style: NdisThemeStyle.headlineMedium),
      content: Text(
        'Are you sure you want to logout?',
        style: NdisThemeStyle.bodyMedium,
      ),
      actions: [
        // TextButton(
        //   onPressed: () => Navigator.of(ctx).pop(),
        //   child: const Text('Cancel'),
        // ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(ctx).pop();
            context.go(AppRoutes.splash);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            ),
            elevation: 0,
          ),
          child: Text(
            'Logout',
            style: NdisThemeStyle.labelLarge.copyWith(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
