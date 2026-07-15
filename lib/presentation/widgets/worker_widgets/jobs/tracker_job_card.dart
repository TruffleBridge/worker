import 'package:flutter/material.dart';
import 'package:nimora_worker/core/constants/nimora_colors.dart';
import 'package:nimora_worker/core/enums/job_badge.dart';
import 'package:nimora_worker/core/enums/job_status.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';
import 'package:nimora_worker/domain/model/view_model/job.dart';

class TrackerJobCard extends StatelessWidget {
  final Job job;
  final VoidCallback onTap;
  final VoidCallback onSave;

  const TrackerJobCard({
    super.key,
    required this.job,
    required this.onTap,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final Color statusColor = _statusColor(job.status);
    final String statusText = _statusText(job.status);
    final IconData statusIcon = _statusIcon(job.status);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: statusColor.withValues(alpha: 0.55),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top status chip
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    statusIcon,
                    size: 15,
                    color: statusColor,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            /// Tags + Price
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

            /// Job Id
            Text(
              'Job #: ${job.id}',
              style: const TextStyle(
                color: NimoraColors.subtitleColor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),

            const SizedBox(height: 6),

            /// Title
            Text(
              job.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: NimoraColors.titleColor,
              ),
            ),

            const SizedBox(height: 14),

            /// Location
            _MetaRow(
              icon: Icons.location_on_outlined,
              text: '${job.location} • ${job.distanceKm} km away',
            ),

            const SizedBox(height: 8),

            /// Tracker footer info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F9FC),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  _MetaRow(
                    icon: Icons.schedule_outlined,
                    text: 'Applied ${job.postedAgo}',
                    iconColor: Colors.grey.shade600,
                    textColor: NimoraColors.titleColor,
                  ),
                  const SizedBox(height: 8),
                  _MetaRow(
                    icon: statusIcon,
                    text: _trackerSubText(job.status),
                    iconColor: statusColor,
                    textColor: statusColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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

  String _statusText(JobStatus status) {
    switch (status) {
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

  String _trackerSubText(JobStatus status) {
    switch (status) {
      case JobStatus.inReview:
        return 'Your application is currently under review';
      case JobStatus.approved:
        return 'Your application has been approved';
      case JobStatus.completed:
        return 'This tracked job has been completed';
      case JobStatus.none:
        return 'Application submitted successfully';
    }
  }

  IconData _statusIcon(JobStatus status) {
    switch (status) {
      case JobStatus.inReview:
        return Icons.info_outline;
      case JobStatus.approved:
        return Icons.check_circle_outline;
      case JobStatus.completed:
        return Icons.task_alt_outlined;
      case JobStatus.none:
        return Icons.work_outline_rounded;
    }
  }

  Color _statusColor(JobStatus status) {
    switch (status) {
      case JobStatus.inReview:
        return NimoraColors.jobInReviewBorderColor;
      case JobStatus.approved:
        return const Color(0xFF12A150);
      case JobStatus.completed:
        return const Color(0xFF7B61FF);
      case JobStatus.none:
        return AppColors.primary;
    }
  }
}

class _BadgeChip extends StatelessWidget {
  final String label;
  final Color color;

  const _BadgeChip({
    required this.label,
    required this.color,
  });

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
              color: textColor ?? NimoraColors.titleColor,
            ),
          ),
        ),
      ],
    );
  }
}