import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nimora_worker/core/constants/assets_images.dart';
import 'package:nimora_worker/core/enums/user_roles.dart';
import 'package:nimora_worker/routes/app_router.dart';
import '../../../../core/theme/app_theme.dart';

class ChooseRolePage extends StatefulWidget {
  const ChooseRolePage({super.key});

  @override
  State<ChooseRolePage> createState() => _ChooseRolePageState();
}

class _ChooseRolePageState extends State<ChooseRolePage> {
  UserRole? _selected;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Stack(
        children: [
          // ── Hero Image — full top portion ────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.33,
            child: Image.asset(AssetJPGImages.onboarding4, fit: BoxFit.cover),
          ),

          // ── Floating white card — centered with 24px margins ──────────
          Positioned(
            top: screenHeight * 0.27,
            left: 24,
            right: 24,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFC5F8FF)),
              ),
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title
                  const Text(
                    'How would you like to use the app?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF262626),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Select your role to get started.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height: 20),

                  _RoleCard(
                    selected: _selected,
                    value: UserRole.client,
                    image: AssetSVGImages.needSupport,
                    title: 'I need support',
                    subtitle:
                        'Find the right care and services for your needs.',
                    onTap: () => setState(() => _selected = UserRole.client),
                  ),
                  const SizedBox(height: 12),
                  _RoleCard(
                    selected: _selected,
                    value: UserRole.worker,
                    image: AssetSVGImages.wantToWork,
                    title: 'I want to work',
                    subtitle:
                        'Join our team of dedicated support professionals.',
                    onTap: () => setState(() => _selected = UserRole.worker),
                  ),
                ],
              ),
            ),
          ),

          // ── Continue button — pinned to bottom ────────────────────────
          Positioned(
            bottom: 36,
            left: 24,
            right: 24,
            child: ElevatedButton(
              onPressed: _selected == null
                  ? null
                  : () {
                switch (_selected) {
                  case UserRole.worker:
                    context.push(AppRoutes.signInSplash);
                    break;

                  case UserRole.client:
                    context.push(AppRoutes.clientSignInSplash);
                    break;

                  case null:
                    break;
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                disabledBackgroundColor: AppColors.primary.withOpacity(0.35),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }
}

//─── Role Card ────────────────────────────────────────────────────────────────

class _RoleCard extends StatelessWidget {
  final UserRole value;
  final UserRole? selected;
  final String image;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _RoleCard({
    super.key,
    required this.value,
    required this.selected,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  bool get _isSelected => selected == value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: _isSelected
              ? AppColors.primary.withOpacity(0.05)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isSelected ? AppColors.primary : Colors.grey.shade200,
            width: _isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 56,
              height: 56,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: value == UserRole.client
                    ? const Color(0xFFCFF3FF)
                    : const Color(0xFF1F95F2).withOpacity(0.15),
              ),
              child: SvgPicture.asset(image, fit: BoxFit.contain),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF191C1E),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF5B4039),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _isSelected ? AppColors.primary : Colors.transparent,
                border: Border.all(
                  color: _isSelected ? AppColors.primary : Colors.grey.shade300,
                  width: 2,
                ),
              ),
              child: _isSelected
                  ? const Icon(Icons.check, size: 13, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
