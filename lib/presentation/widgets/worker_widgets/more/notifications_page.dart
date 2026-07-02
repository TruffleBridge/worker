import 'package:flutter/material.dart';
import 'package:nimora_worker/core/constants/nimora_colors.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';
import 'package:nimora_worker/presentation/widgets/worker_widgets/more/MorePageAppBar.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final List<NotificationPreference> items = [
    NotificationPreference(
      title: 'Job Post',
      description: 'Notify me about new booking requests.',
      enabled: true,
      selectedDistance: 50,
    ),
    NotificationPreference(
      title: 'New Bookings',
      description: 'Notify me about new booking requests.',
      enabled: false,
    ),
    NotificationPreference(
      title: 'Changes to Bookings',
      description: 'Notify me about booking changes.',
      enabled: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: const MorePageAppBar(title: 'Notifications'),

      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          return NotificationCard(
            item: items[index],
            onChanged: (value) {
              setState(() {
                items[index].enabled = value;
              });
            },
            onDistanceChanged: (distance) {
              setState(() {
                items[index].selectedDistance = distance;
              });
            },
          );
        },
      ),
    );
  }
}

class NotificationPreference {
  final String title;
  final String description;
  bool enabled;
  int? selectedDistance;

  NotificationPreference({
    required this.title,
    required this.description,
    required this.enabled,
    this.selectedDistance,
  });
}

class NotificationCard extends StatelessWidget {
  final NotificationPreference item;
  final ValueChanged<bool> onChanged;
  final ValueChanged<int> onDistanceChanged;

  const NotificationCard({
    super.key,
    required this.item,
    required this.onChanged,
    required this.onDistanceChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.description_outlined, size: 18),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style:  TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: NimoraColors.titleColor,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      item.description,
                      style: const TextStyle(
                        color: Color(0xFF4A5565),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),

              border: Border.all(color: const Color(0xFFECEAEA), width: 1),

              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF7E7C7C).withOpacity(0.25),
                  const Color(0xFFE4E0E0).withOpacity(0.25),
                ],
              ),

              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(255, 255, 255, 0.25),
                  offset: Offset(0, 2),
                  blurRadius: 2,
                ),
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                     Text(
                      'SMS',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: NimoraColors.titleColor,
                      ),
                    ),

                    const Spacer(),

                    Switch(
                      value: item.enabled,
                      onChanged: onChanged,
                      activeColor: Colors.white,
                      activeTrackColor: AppColors.primary,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: const Color(0xFFE0E0E0),
                      trackOutlineColor:
                          MaterialStateProperty.resolveWith<Color>((states) {
                            if (states.contains(MaterialState.selected)) {
                              return Colors.transparent;
                            }
                            return const Color(0xFFD0D0D0);
                          }),
                    ),
                  ],
                ),

                const SizedBox(height: 14),
                if (item.selectedDistance != null)
                  const Text(
                    'Tell me about Jobs within (km)...',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4A5565),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                if (item.selectedDistance != null) const SizedBox(height: 12),

                if (item.selectedDistance != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [5, 15, 30, 50, 100].map((distance) {
                      final selected = distance == item.selectedDistance;

                      return GestureDetector(
                        onTap: () => onDistanceChanged(distance),
                        child: Container(
                          width: 42,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: selected
                                ? const Color(0xFF086D63)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: selected
                                  ? const Color(0xFF086D63)
                                  : const Color(0xFFE5E7EB),
                            ),
                          ),
                          child: Text(
                            '$distance',
                            style: TextStyle(
                              color: selected
                                  ? Colors.white
                                  : const Color(0xFF364153),
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
