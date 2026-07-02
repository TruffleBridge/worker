import 'package:flutter/material.dart';
import 'package:nimora_worker/core/constants/nimora_colors.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';
import 'package:nimora_worker/presentation/widgets/worker_widgets/more/MorePageAppBar.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: MorePageAppBar(title: 'Security'),

      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            PasswordSection(),
            SizedBox(height: 16),
            TwoFactorSection(),
          ],
        ),
      ),
    );
  }
}

class PasswordSection extends StatelessWidget {
  const PasswordSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password',
            style: NdisThemeStyle.displayLarge.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: NimoraColors.titleColor,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            'Used to login to your account',
            style: NdisThemeStyle.displayLarge.copyWith(
              color: NimoraColors.jobClientSubtitleColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: () {
                /// Navigate to update password
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: NimoraColors.securityUpdatePasswordTextColor,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Update Password',
                style: NdisThemeStyle.displayLarge.copyWith(
                  color: NimoraColors.securityUpdatePasswordTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TwoFactorSection extends StatelessWidget {
  const TwoFactorSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Two-Factor Authentication (2FA)',
            style: NdisThemeStyle.displayLarge.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: NimoraColors.titleColor,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Your account is protected with 2FA SMS Verification.',
            style: NdisThemeStyle.bodyLarge.copyWith(
              color: NimoraColors.moreTitleColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),

          const SizedBox(height: 12),

          GestureDetector(
            onTap: () {
              /// Update phone number
            },
            child: Text(
              'Update phone number.',
              style: NdisThemeStyle.displayLarge.copyWith(
                color: NimoraColors.securityUpdatePasswordTextColor,
                fontSize: 16,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(height: 20),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: NimoraColors.securitySmsContainerBgColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: NimoraColors.securitySmsContainerBorderColor,
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.check, size: 18, color: NimoraColors.titleColor),

                const SizedBox(width: 12),

                Text(
                  '2FA SMS Enabled',
                  style: NdisThemeStyle.displayLarge.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: NimoraColors.moreTitleColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
