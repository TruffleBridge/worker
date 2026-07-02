import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nimora_worker/core/constants/nimora_colors.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';
import 'package:nimora_worker/routes/app_router.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  // final String title;
  final bool showBack;
  final List<Widget>? actions;

  const HomeAppBar({
    super.key,
    // required this.title,
    this.showBack = false,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(90);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 90,
      backgroundColor: AppColors.appbarBackground,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      titleSpacing: 20,

      title: Row(
        children: [
          // Avatar
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: AssetImage('assets/images/profile.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 14),

          // Greeting
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome',
                  style: NdisThemeStyle.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  'Manoj Rajkumar',
                  style: NdisThemeStyle.headlineMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      actions: [
        GestureDetector(
          onTap: () {
            context.push(AppRoutes.aiAssistant);
          },
          child: Container(
            padding: const EdgeInsets.all(1.2),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  NimoraColors.aiGradientColor1,
                  NimoraColors.aiGradientColor2,
                  NimoraColors.aiGradientColor3,
                  NimoraColors.aiGradientColor4,
                  NimoraColors.aiGradientColor5,
                ],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Row(
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) {
                      return const LinearGradient(
                        colors: [
                          NimoraColors.aiGradientColor1,
                          NimoraColors.aiGradientColor2,
                          NimoraColors.aiGradientColor3,
                          NimoraColors.aiGradientColor4,
                          NimoraColors.aiGradientColor5,
                        ],
                      ).createShader(bounds);
                    },
                    child: const Icon(
                      Icons.auto_awesome,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(width: 6),

                  const Text(
                    'Ask AI',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        // Notification
        Container(
          margin: const EdgeInsets.only(right: 20),
          child: Stack(
            children: [
              SizedBox(
                width: 48,
                height: 48,
                child: IconButton(
                  icon: const Icon(
                    Icons.notifications_none_rounded,
                    color: AppColors.textPrimary,
                  ),
                  onPressed: () {},
                ),
              ),

              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),

        if (actions != null) ...actions!,
      ],

      leading: showBack
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: AppColors.textPrimary,
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
    );
  }
}
