import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _items = [
    _NavItem(icon: 'assets/images/jobs_icon.svg', label: 'Jobs'),
    _NavItem(icon: 'assets/images/bookings_icon.svg', label: 'Bookings'),
    _NavItem(icon: 'assets/images/messages_icon.svg', label: 'Messages'),
    _NavItem(icon: 'assets/images/profile_icon.svg', label: 'My Profile'),
    _NavItem(icon: 'assets/images/more_icon.svg', label: 'More'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
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
            children: List.generate(_items.length, (i) {
              final isActive = i == currentIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(i),
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          _items[i].icon,
                          colorFilter: ColorFilter.mode(
                            isActive
                                ? AppColors.primary
                                : AppColors.grey400,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          _items[i].label,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: isActive
                                ? FontWeight.w700
                                : FontWeight.w400,
                            color: isActive
                                ? AppColors.primary
                                : AppColors.grey400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final String icon;
  final String label;

  const _NavItem({required this.icon, required this.label});
}
