import 'package:flutter/material.dart';
import 'package:nimora_worker/core/constants/nimora_colors.dart';
import 'package:nimora_worker/presentation/widgets/worker_widgets/more/MorePageAppBar.dart';

class SupportWorkerResourcesPage extends StatelessWidget {
  const SupportWorkerResourcesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final resources = [
      const ResourceModel(
        title: 'Work Health & Safety',
        category: 'Induction',
        description:
            'A WorkSafe Australia guide on how to reduce workplace health and safety risks.',
        icon: Icons.shield_outlined,
        iconColor: NimoraColors.supportWorkerIconBgColor1,
      ),
      const ResourceModel(
        title: 'Child Safe e-learning Modules',
        category: 'Training',
        description:
            'Human Rights Commission eLearning about National Principles for Child Safe Organisations.',
        icon: Icons.favorite_border,
        iconColor: NimoraColors.supportWorkerIconBgColor2,
      ),
      const ResourceModel(
        title: 'COVID-19 Infection Control',
        category: 'Training',
        description:
            'Department of Health eLearning to improve COVID-19 infection prevention knowledge.',
        icon: Icons.coronavirus_outlined,
        iconColor: NimoraColors.supportWorkerIconBgColor3,
      ),
      const ResourceModel(
        title: 'Understanding Abuse',
        category: 'Training',
        description:
            'Learn how to identify and report abuse in disability support environments.',
        icon: Icons.menu_book_outlined,
        iconColor: NimoraColors.supportWorkerIconBgColor4,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: const MorePageAppBar(title: 'Support Worker Resources'),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: resources.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ResourceCard(resource: resources[index]),
          );
        },
      ),
    );
  }
}

class ResourceCard extends StatelessWidget {
  final ResourceModel resource;

  const ResourceCard({super.key, required this.resource});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: NimoraColors.moreContainerBgColor),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: resource.iconColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(resource.icon, color: resource.iconColor, size: 18),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  resource.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: NimoraColors.titleColor,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: NimoraColors.securityBgContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              resource.category,
              style: const TextStyle(
                fontSize: 12,
                color: NimoraColors.moreTitleColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          const SizedBox(height: 10),

          Text(
            resource.description,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: NimoraColors.jobClientSubtitleColor,
            ),
          ),

          const SizedBox(height: 12),

          InkWell(
            onTap: () {
              // Launch URL later
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Visit Resource',
                  style: TextStyle(
                    color: NimoraColors.applicantsColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.open_in_new,
                  size: 14,
                  color: NimoraColors.applicantsColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ResourceModel {
  final String title;
  final String category;
  final String description;
  final IconData icon;
  final Color iconColor;

  const ResourceModel({
    required this.title,
    required this.category,
    required this.description,
    required this.icon,
    required this.iconColor,
  });
}
