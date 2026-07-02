import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nimora_worker/core/constants/nimora_colors.dart';
import 'package:nimora_worker/presentation/widgets/components/home_app_bar.dart';
import 'package:nimora_worker/routes/app_router.dart';
import '../../../../core/theme/app_theme.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const HomeAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Accounts
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: NimoraColors.moreContainerBgColor),
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: const BoxDecoration(
                    color: NimoraColors.moreContainerHeaderBgColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Accounts',
                    style: NdisThemeStyle.displayLarge.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: NimoraColors.moreContainerTitleColor,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.push(AppRoutes.account);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: NimoraColors.accountSettingsBgContainer,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SvgPicture.asset(
                            'assets/images/profile_icon_blue.svg',
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Text(
                            'Account Settings',
                            style: NdisThemeStyle.headlineLarge.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: NimoraColors.moreTitleColor,
                            ),
                          ),
                        ),

                        const Icon(
                          Icons.chevron_right,
                          size: 20,
                          color: NimoraColors.chevronIconColor,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.push(AppRoutes.security);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: NimoraColors.securityBgContainer,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SvgPicture.asset(
                            'assets/images/security_icon.svg',
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Text(
                            'Security',
                            style: NdisThemeStyle.headlineLarge.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: NimoraColors.moreTitleColor,
                            ),
                          ),
                        ),

                        const Icon(
                          Icons.chevron_right,
                          size: 20,
                          color: NimoraColors.chevronIconColor,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.push(AppRoutes.notifications);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: NimoraColors.notificationBgContainer,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SvgPicture.asset(
                            'assets/images/notification_icon.svg',
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Text(
                            'Notifications',
                            style: NdisThemeStyle.headlineLarge.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: NimoraColors.moreTitleColor,
                            ),
                          ),
                        ),

                        const Icon(
                          Icons.chevron_right,
                          size: 20,
                          color: NimoraColors.chevronIconColor,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.push(AppRoutes.paymentInfo);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: NimoraColors.paymentInfoBgContainer,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SvgPicture.asset(
                            'assets/images/payment_icon.svg',
                            fit: BoxFit.contain,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Text(
                            'Payment Info',
                            style: NdisThemeStyle.headlineLarge.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: NimoraColors.moreTitleColor,
                            ),
                          ),
                        ),

                        const Icon(
                          Icons.chevron_right,
                          size: 20,
                          color: NimoraColors.chevronIconColor,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.push(AppRoutes.payslips);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: NimoraColors.payslipBgContainer,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SvgPicture.asset(
                            'assets/images/payslip_icon.svg',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Payslips',
                            style: NdisThemeStyle.headlineLarge.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: NimoraColors.moreTitleColor,
                            ),
                          ),
                        ),

                        const Icon(
                          Icons.chevron_right,
                          size: 20,
                          color: NimoraColors.chevronIconColor,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.push(AppRoutes.verifications);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: NimoraColors.paymentInfoBgContainer,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SvgPicture.asset(
                            'assets/images/circular_tick.svg',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Verifications',
                            style: NdisThemeStyle.headlineLarge.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: NimoraColors.moreTitleColor,
                            ),
                          ),
                        ),

                        const Icon(
                          Icons.chevron_right,
                          size: 20,
                          color: NimoraColors.chevronIconColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          //Resources
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: NimoraColors.moreContainerBgColor),
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: const BoxDecoration(
                    color: NimoraColors.moreContainerHeaderBgColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Resources',
                    style: NdisThemeStyle.displayLarge.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: NimoraColors.moreContainerTitleColor,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.push(AppRoutes.supportWorkerResources);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: NimoraColors.supportWorkerBgContainer,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SvgPicture.asset(
                            'assets/images/support_icon.svg',
                            fit: BoxFit.contain,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Text(
                            'Support Worker Resources',
                            style: NdisThemeStyle.headlineLarge.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: NimoraColors.moreTitleColor,
                            ),
                          ),
                        ),

                        const Icon(
                          Icons.chevron_right,
                          size: 20,
                          color: NimoraColors.chevronIconColor,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.push(AppRoutes.serviceNotes);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: NimoraColors.securityBgContainer,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SvgPicture.asset(
                            'assets/images/service_icon.svg',
                            fit: BoxFit.contain,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Text(
                            'Service Notes',
                            style: NdisThemeStyle.headlineLarge.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: NimoraColors.moreTitleColor,
                            ),
                          ),
                        ),

                        const Icon(
                          Icons.chevron_right,
                          size: 20,
                          color: NimoraColors.chevronIconColor,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.push(AppRoutes.incidentReports);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: NimoraColors.incidentReportBgContainer,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SvgPicture.asset(
                            'assets/images/caution_icon.svg',
                            fit: BoxFit.contain,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Text(
                            'Incident Report',
                            style: NdisThemeStyle.headlineLarge.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: NimoraColors.moreTitleColor,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          size: 20,
                          color: NimoraColors.chevronIconColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          //Benefits
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: NimoraColors.moreContainerBgColor),
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: const BoxDecoration(
                    color: NimoraColors.moreContainerHeaderBgColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Benefits',
                    style: NdisThemeStyle.headlineLarge.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: NimoraColors.moreContainerTitleColor,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.push(AppRoutes.myRewards);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: NimoraColors.myRewardsBgContainer,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SvgPicture.asset(
                            'assets/images/rewards_icon.svg',
                            fit: BoxFit.contain,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Text(
                            'My Rewards',
                            style: NdisThemeStyle.headlineLarge.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: NimoraColors.moreTitleColor,
                            ),
                          ),
                        ),

                        const Icon(
                          Icons.chevron_right,
                          size: 20,
                          color: NimoraColors.chevronIconColor,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.push(AppRoutes.byoClients);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: NimoraColors.byoClientsBgContainer,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SvgPicture.asset(
                            'assets/images/byo_icon.svg',
                            fit: BoxFit.contain,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Text(
                            'BYO Clients',
                            style: NdisThemeStyle.headlineLarge.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: NimoraColors.moreTitleColor,
                            ),
                          ),
                        ),

                        const Icon(
                          Icons.chevron_right,
                          size: 20,
                          color: NimoraColors.chevronIconColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
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
          const SizedBox(height: 12),
        ],
      ),
    );
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
}
