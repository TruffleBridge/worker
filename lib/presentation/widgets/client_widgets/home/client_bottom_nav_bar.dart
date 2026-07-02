import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';

class ClientBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const ClientBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 82,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade200,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            _item(
              index: 0,
              label: 'Workers',
              icon: 'assets/images/worker_icon.svg',
            ),
            _item(
              index: 1,
              label: 'My Jobs',
              icon: 'assets/images/jobs_icon.svg',
            ),
            _item(
              index: 2,
              label: '',
              isCenter: true,
            ),
            _item(
              index: 3,
              label: 'Messages',
              icon: 'assets/images/messages_icon.svg',
            ),
            _item(
              index: 4,
              label: 'Profile',
              icon: 'assets/images/profile_icon.svg',
            ),
          ],
        ),
      ),
    );
  }

  Widget _item({
    required int index,
    required String label,
    String? icon,
    bool isCenter = false,
  }) {
    final isSelected = currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        child: isCenter
            ? Transform.translate(
          offset: const Offset(0, -14),
          child: Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.35),
                  blurRadius: 14,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 34,
            ),
          ),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon!,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                isSelected
                    ? AppColors.primary
                    : Colors.grey.shade500,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected
                    ? FontWeight.w600
                    : FontWeight.w500,
                color: isSelected
                    ? AppColors.primary
                    : Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}