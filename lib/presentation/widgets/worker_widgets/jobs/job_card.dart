import 'package:flutter/material.dart';
import 'package:nimora_worker/core/constants/nimora_colors.dart';
import 'package:nimora_worker/core/enums/job_badge.dart';
import 'package:nimora_worker/core/enums/job_status.dart';
import 'package:nimora_worker/domain/model/view_model/job.dart';

import '../../../../core/theme/app_theme.dart';

class JobCard extends StatelessWidget {
  final Job job;

  final VoidCallback onTap;

  final VoidCallback onSave;

  // final bool isTracker;

  const JobCard({
    super.key,
    required this.job,
    required this.onTap,
    required this.onSave,
    // this.isTracker = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: job.status == JobStatus.inReview
                ? NimoraColors.jobInReviewBorderColor
                : AppColors.grey400,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tracker Status
            // if (isTracker) ...[
            //   Container(
            //     padding:
            //     const EdgeInsets.symmetric(
            //       horizontal: 12,
            //       vertical: 8,
            //     ),
            //     decoration: BoxDecoration(
            //       color: _trackerColor()
            //           .withValues(
            //         alpha: 0.12,
            //       ),
            //       borderRadius:
            //       BorderRadius.circular(
            //         30,
            //       ),
            //     ),
            //     child: Row(
            //       mainAxisSize:
            //       MainAxisSize.min,
            //       children: [
            //         Icon(
            //           _trackerIcon(),
            //           size: 16,
            //           color:
            //           _trackerColor(),
            //         ),
            //
            //         const SizedBox(
            //           width: 6,
            //         ),
            //
            //         Text(
            //           _trackerLabel(),
            //           style: TextStyle(
            //             color:
            //             _trackerColor(),
            //             fontWeight:
            //             FontWeight.w700,
            //             fontSize: 12,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            //
            //   const SizedBox(height: 16),
            // ]

            // Review Badge
            /*else*/ if (job.status == JobStatus.inReview) ...[
              const Row(
                children: [
                  Icon(Icons.info_outline, size: 16, color: Color(0xFF2962FF)),

                  SizedBox(width: 6),

                  Text(
                    'In Review',
                    style: TextStyle(
                      color: NimoraColors.jobInReviewBorderColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),
            ],

            // Tags + Price
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: job.badges.map((badge) {
                      return _BadgeChip(
                        label: _badgeLabel(badge),
                        color: _badgeColor(badge),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(width: 12),

                Text(
                  '\$${job.hourlyRate.toStringAsFixed(2)}/hr',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: NimoraColors.hourlyRateColor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Job Id
            Text(
              'Job #: ${job.id}',
              style: const TextStyle(
                color: NimoraColors.subtitleColor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),

            const SizedBox(height: 6),

            // Title
            Text(
              job.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: NimoraColors.titleColor,
              ),
            ),

            const SizedBox(height: 14),

            // Location
            _MetaRow(
              icon: Icons.location_on_outlined,
              text: '${job.location} • ${job.distanceKm} km away',
            ),

            const SizedBox(height: 8),

            // Posted + Applications
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _MetaRow(
                  icon: Icons.schedule_outlined,
                  text: 'Posted ${job.postedAgo}',
                ),

                const SizedBox(height: 8),

                _MetaRow(
                  icon: Icons.people_outline_rounded,
                  iconColor: const Color(0xFF2962FF),
                  text: '${job.applicationsCount}+ applications',
                  textColor: const Color(0xFF2962FF),
                ),
              ],
            ),

            // Tracker Extra Content
            // if (isTracker) ...[
            //   const SizedBox(height: 18),
            //
            //   Container(
            //     padding:
            //     const EdgeInsets.all(14),
            //     decoration: BoxDecoration(
            //       color: const Color(
            //         0xFFF7F9FC,
            //       ),
            //       borderRadius:
            //       BorderRadius.circular(
            //         16,
            //       ),
            //     ),
            //     child: Column(
            //       children: [
            //         _trackerInfoRow(
            //           icon:
            //           Icons.calendar_today,
            //           title: 'Schedule',
            //           value:
            //           job.scheduleDays,
            //         ),
            //
            //         const SizedBox(
            //           height: 12,
            //         ),
            //
            //         _trackerInfoRow(
            //           icon: Icons.access_time,
            //           title: 'Time',
            //           value:
            //           job.scheduleTime,
            //         ),
            //       ],
            //     ),
            //   ),
            // ],
          ],
        ),
      ),
    );
  }

  Widget _trackerInfoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),

        const SizedBox(width: 10),

        Text('$title : ', style: const TextStyle(fontWeight: FontWeight.w600)),

        Expanded(
          child: Text(value, style: TextStyle(color: Colors.grey.shade700)),
        ),
      ],
    );
  }

  String _badgeLabel(JobBadge badge) {
    switch (badge) {
      case JobBadge.ndis:
        return 'NDIS';

      case JobBadge.agedCare:
        return 'Aged';

      case JobBadge.disability:
        return 'Disability';

      case JobBadge.mentalHealth:
        return 'Mental Health';

      case JobBadge.urgent:
        return 'Urgent';
    }
  }

  Color _badgeColor(JobBadge badge) {
    switch (badge) {
      case JobBadge.urgent:
        return const Color(0xFFE53935);

      case JobBadge.ndis:
      case JobBadge.agedCare:
      case JobBadge.disability:
      case JobBadge.mentalHealth:
        return const Color(0xFF5E6B7A);
    }
  }

  String _trackerLabel() {
    switch (job.status) {
      case JobStatus.inReview:
        return 'In Review';

      case JobStatus.approved:
        return 'Approved';

      case JobStatus.completed:
        return 'Completed';

      case JobStatus.none:
        return 'Applied';
    }
  }

  IconData _trackerIcon() {
    switch (job.status) {
      case JobStatus.inReview:
        return Icons.hourglass_top_rounded;

      case JobStatus.approved:
        return Icons.check_circle_rounded;

      case JobStatus.completed:
        return Icons.task_alt_rounded;

      case JobStatus.none:
        return Icons.work_outline_rounded;
    }
  }

  Color _trackerColor() {
    switch (job.status) {
      case JobStatus.inReview:
        return const Color(0xFF2962FF);

      case JobStatus.approved:
        return const Color(0xFF12A150);

      case JobStatus.completed:
        return const Color(0xFF7B61FF);

      case JobStatus.none:
        return const Color(0xFF5E6B7A);
    }
  }
}

class _BadgeChip extends StatelessWidget {
  final String label;

  final Color color;

  const _BadgeChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 11,
        ),
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  final IconData icon;

  final String text;

  final Color? textColor;
  final Color? iconColor;

  const _MetaRow({
    required this.icon,
    required this.text,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: iconColor ?? Colors.grey.shade500),

        const SizedBox(width: 5),

        Expanded(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textColor ??  NimoraColors.titleColor,
            ),
          ),
        ),
      ],
    );
  }
}
