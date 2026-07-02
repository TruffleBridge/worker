import 'package:flutter/material.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';

class MorePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String actionButton;

  const MorePageAppBar({
    super.key,
    required this.title,
    this.actionButton = '',
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 60,
      backgroundColor: const Color(0xFFE0E0E0),
      elevation: 0,
      surfaceTintColor: Colors.white,
      automaticallyImplyLeading: false,
      leadingWidth: 72,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFFF3F4F6),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),

      title: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),

      actions: [
        if (actionButton.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 8, bottom: 8),
            child: GestureDetector(
              onTap: () {},
              child: SizedBox(
                width: 42,
                height: 42,
                // decoration: const BoxDecoration(
                //   color: Color(0xFFF4F5F7),
                //   shape: BoxShape.circle,
                // ),
                child: Image.asset(actionButton),
              ),
            ),
          ),
      ],
    );
  }
}
