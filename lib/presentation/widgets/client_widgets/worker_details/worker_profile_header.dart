import 'package:flutter/material.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';

class WorkerProfileHeader extends StatelessWidget {
  const WorkerProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          /// Avatar
          Stack(
            children: [
              const CircleAvatar(
                radius: 48,
                backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
              ),

              Positioned(
                right: 4,
                bottom: 4,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          /// Name + Verified
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Manoj Rajkumar',
                style: NdisThemeStyle.bodyMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Color(0xFF1C1B1D),
                ),
              ),

              const SizedBox(width: 6),

              const Icon(
                Icons.verified_outlined,
                color: Color(0xFF086D63),
                size: 18,
              ),
            ],
          ),

          const SizedBox(height: 4),

          Text(
            'Senior Care Specialist',
            style: NdisThemeStyle.bodyMedium.copyWith(
              color: Color(0xFF64748B),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),

          const SizedBox(height: 22),

          Row(
            children: [
              Expanded(
                child: _InfoTile(
                  title: '1.2 Km',
                  subtitle: 'Distance',
                  backgroundColor: const Color(0xFFEFF6FF),
                  titleColor: const Color(0xFF155DFC),
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: _InfoTile(
                  title: '4.9 ⭐',
                  subtitle: 'Ratings (128)',
                  backgroundColor: const Color(0xFFFFFAE3),
                  titleColor: const Color(0xFF222524),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color backgroundColor;
  final Color titleColor;

  const _InfoTile({
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
    required this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
