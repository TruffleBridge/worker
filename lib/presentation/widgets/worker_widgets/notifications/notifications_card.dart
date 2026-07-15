import 'package:flutter/material.dart';
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
    final profilePicture = notification.profilePicture;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 27,
                backgroundImage:
                    profilePicture != null && profilePicture.isNotEmpty
                    ? NetworkImage(profilePicture)
                    : null,
                child: profilePicture == null || profilePicture.isEmpty
                    ? Text(_getInitials(notification.clientName ?? ''))
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.clientName ?? '',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      notification.jobTitle ?? '',
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 12),
                    DetailRow(
                      icon: Icons.calendar_today_outlined,
                      value: notification.date ?? '',
                    ),
                    const SizedBox(height: 8),
                    DetailRow(
                      icon: Icons.access_time,
                      value:
                          '${notification.time ?? ''} (${notification.duration ?? ''})',
                    ),
                    const SizedBox(height: 8),
                    DetailRow(
                      icon: Icons.location_on_outlined,
                      value: notification.location ?? '',
                    ),
                  ],
                ),
              ),
              Text(
                notification.notificationTime ?? '',
                style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: isUpdating ? null : onDecline,
                  child: const Text('Decline'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: isUpdating ? null : onApprove,
                  child: isUpdating
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Approve'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getInitials(String name) {
    final values = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((value) => value.isNotEmpty)
        .toList();

    return values.map((value) => value[0]).take(2).join().toUpperCase();
  }
}

class DetailRow extends StatelessWidget {
  final IconData icon;
  final String value;

  const DetailRow({super.key, required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 17, color: const Color(0xFF6B7280)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 13, color: Color(0xFF374151)),
          ),
        ),
      ],
    );
  }
}
