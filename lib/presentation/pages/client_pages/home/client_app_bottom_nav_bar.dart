import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';

class ClientAppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onAddTap;

  const ClientAppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.07),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              _navItem(
                index: 0,
                label: 'Workers',
                icon: 'assets/images/worker_icon.svg',
              ),
              _navItem(
                index: 1,
                label: 'My Jobs',
                icon: 'assets/images/jobs_icon.svg',
              ),

              /// Center Add Button
              Expanded(
                child: InkWell(
                  onTap: onAddTap,
                  borderRadius: BorderRadius.circular(30),
                  child: Transform.translate(
                    offset: const Offset(0, -12),
                    child: Center(
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(.35),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              _navItem(
                index: 2,
                label: 'Messages',
                icon: 'assets/images/messages_icon.svg',
              ),
              _navItem(
                index: 3,
                label: 'Profile',
                icon: 'assets/images/profile_icon.svg',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem({
    required int index,
    required String label,
    required String icon,
  }) {
    final isActive = currentIndex == index;

    final color = isActive
        ? AppColors.primary
        : AppColors.grey400;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              width: 22,
              height: 22,
              colorFilter: ColorFilter.mode(
                color,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight:
                isActive ? FontWeight.w700 : FontWeight.w400,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}