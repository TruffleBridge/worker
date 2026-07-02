import 'package:flutter/material.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: AppColors.grey100,
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Icon(
                Icons.work_off_outlined,
                size: 52,
                color: AppColors.grey400,
              ),
            ),

            const SizedBox(height: 28),

            Text('No jobs found', style: NdisThemeStyle.headlineMedium),

            const SizedBox(height: 12),

            Text(
              'Start searching for opportunities that match your skills and interests.',
              textAlign: TextAlign.center,
              style: NdisThemeStyle.bodyMedium,
            ),

            const SizedBox(height: 36),

            SizedBox(
              height: 54,
              child: OutlinedButton(
                onPressed: () {},

                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                ),

                child: const Text(
                  'Browse All Jobs',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
