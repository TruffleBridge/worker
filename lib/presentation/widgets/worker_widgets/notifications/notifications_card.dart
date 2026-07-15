import 'package:flutter/material.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';
import 'package:nimora_worker/domain/model/response/notification_list_response_model.dart';

class NotificationCard extends StatelessWidget {
  final NotificationListResult notification;
  final bool isUpdating;
  final VoidCallback? onApprove;
  final VoidCallback? onDecline;

  const NotificationCard({
    super.key,
    required this.notification,
    required this.isUpdating,
    required this.onApprove,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildDetails(),
          const SizedBox(height: 16),
          const Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFE5E7EB),
          ),
          const SizedBox(height: 16),
          _buildActions(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ProfileAvatar(
          profilePicture: notification.profilePicture,
          clientName: notification.clientName,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notification.clientName ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: NdisThemeStyle.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                notification.jobTitle ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: NdisThemeStyle.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          notification.notificationTime ?? '',
          style: NdisThemeStyle.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildDetails() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 56,
      ),
      child: Column(
        children: [
          NotificationDetailRow(
            icon: Icons.calendar_today_outlined,
            value: notification.date ?? '',
          ),
          const SizedBox(height: 10),
          NotificationDetailRow(
            icon: Icons.access_time_rounded,
            value: _getTimeValue(),
          ),
          const SizedBox(height: 10),
          NotificationDetailRow(
            icon: Icons.location_on_outlined,
            value: notification.location ?? '',
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 44,
            child: OutlinedButton(
              onPressed: isUpdating ? null : onDecline,
              style: OutlinedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF111827),
                disabledForegroundColor: const Color(0xFF9CA3AF),
                side: const BorderSide(
                  color: Color(0xFFD1D5DB),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: EdgeInsets.zero,
              ),
              child: const Text(
                'Decline',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: 44,
            child: ElevatedButton(
              onPressed: isUpdating ? null : onApprove,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                disabledBackgroundColor: AppColors.primary.withValues(
                  alpha: 0.6,
                ),
                disabledForegroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: EdgeInsets.zero,
              ),
              child: isUpdating
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
                  : const Text(
                'Approve',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _getTimeValue() {
    final time = notification.time?.trim() ?? '';
    final duration = notification.duration?.trim() ?? '';

    if (time.isEmpty) {
      return duration;
    }

    if (duration.isEmpty) {
      return time;
    }

    return '$time  •  $duration';
  }
}

class _ProfileAvatar extends StatelessWidget {
  final String? profilePicture;
  final String? clientName;

  const _ProfileAvatar({
    required this.profilePicture,
    required this.clientName,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = profilePicture?.trim() ?? '';

    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        shape: BoxShape.circle,
        image: imageUrl.isNotEmpty
            ? DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        )
            : null,
      ),
      alignment: Alignment.center,
      child: imageUrl.isEmpty
          ? Text(
        _getInitials(
          clientName ?? '',
        ),
        style: NdisThemeStyle.bodyMedium.copyWith(
          color: AppColors.textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      )
          : null,
    );
  }

  String _getInitials(String name) {
    final nameParts = name
        .trim()
        .split(
      RegExp(r'\s+'),
    )
        .where(
          (value) => value.isNotEmpty,
    )
        .toList();

    if (nameParts.isEmpty) {
      return '';
    }

    return nameParts
        .take(2)
        .map(
          (value) => value.substring(0, 1),
    )
        .join()
        .toUpperCase();
  }
}

class NotificationDetailRow extends StatelessWidget {
  final IconData icon;
  final String value;

  const NotificationDetailRow({
    super.key,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 20,
          child: Icon(
            icon,
            size: 16,
            color: const Color(0xFF6B7280),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: NdisThemeStyle.bodyMedium.copyWith(
              color: const Color(0xFF4B5563),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}