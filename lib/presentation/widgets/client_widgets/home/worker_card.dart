import 'package:flutter/material.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';

class WorkerCard extends StatelessWidget {
  final String name;
  final String role;
  final double rating;
  final int reviews;
  final double distance;
  final String imageUrl;
  final bool isOnline;
  final bool isVerified;
  final List<String> badges;
  final VoidCallback? onTap;

  const WorkerCard({
    super.key,
    this.name = 'Manoj Rajkumar',
    this.role = 'Senior Care Specialist',
    this.rating = 4.9,
    this.reviews = 128,
    this.distance = 1.2,
    this.imageUrl = '',
    this.isOnline = true,
    this.isVerified = true,
    this.badges = const ['Pet Friendly', 'Non-Smoker'],
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Avatar
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: imageUrl.isNotEmpty
                          ? NetworkImage(imageUrl)
                          : null,
                      child: imageUrl.isEmpty
                          ? Image.asset('assets/images/profile_image.jpg')
                          : null,
                    ),

                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: isOnline ? Colors.green : Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Name
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              name,
                              overflow: TextOverflow.ellipsis,
                              style: NdisThemeStyle.bodyLarge.copyWith(
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1C1B1D),
                                fontSize: 15,
                              ),
                            ),
                          ),
                          if (isVerified) ...[
                            const SizedBox(width: 6),
                            const Icon(
                              Icons.verified_outlined,
                              color: Color(0xFF086D63),
                              size: 18,
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),

                      Text(
                        role,
                        style: NdisThemeStyle.bodyMedium.copyWith(
                          color: Color(0xFF64748B),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),

                          const SizedBox(width: 3),

                          Text(
                            rating.toString(),
                            style: NdisThemeStyle.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1C1B1D),
                              fontSize: 12,
                            ),
                          ),

                          Text(
                            ' ($reviews)',
                            style: NdisThemeStyle.bodyMedium.copyWith(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF64748B),
                            ),
                          ),

                          const SizedBox(width: 12),

                          const Icon(
                            Icons.location_on_outlined,
                            size: 15,
                            color: Colors.grey,
                          ),

                          Text(
                            '$distance km',
                            style: NdisThemeStyle.bodyMedium.copyWith(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: badges
                  .map(
                    (badge) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: badge == 'Pet Friendly'
                            ? const Color(0xffE4FBF4)
                            : const Color(0xffF2F2F2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        badge,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: badge == 'Pet Friendly'
                              ? Colors.teal
                              : Colors.black87,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
