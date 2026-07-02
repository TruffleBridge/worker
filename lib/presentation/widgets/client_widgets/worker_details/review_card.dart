import 'package:flutter/material.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';

class ReviewCard extends StatelessWidget {
  final String name;
  final String initials;
  final String review;
  final String time;
  final double rating;

  const ReviewCard({
    super.key,
    required this.name,
    required this.initials,
    required this.review,
    required this.time,
    this.rating = 5.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.primary.withOpacity(.12),
                child: Text(
                  initials,
                  style: NdisThemeStyle.bodyMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: NdisThemeStyle.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFF1A233A),
                      ),
                    ),

                    const SizedBox(height: 4),
                  ],
                ),
              ),

              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 18),

                  const SizedBox(width: 4),

                  Text(
                    rating.toStringAsFixed(1),
                    style: NdisThemeStyle.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          Text(
            '"$review"',
            style: NdisThemeStyle.bodyMedium.copyWith(
              color: Color(0xFF594237),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 15),
          Text(
            time,
            style: NdisThemeStyle.bodyMedium.copyWith(
              color: Color(0xFF64748B),
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
