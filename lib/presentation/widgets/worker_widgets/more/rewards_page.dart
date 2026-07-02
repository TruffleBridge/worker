import 'package:flutter/material.dart';
import 'package:nimora_worker/core/constants/nimora_colors.dart';
import 'package:nimora_worker/presentation/widgets/worker_widgets/more/MorePageAppBar.dart';

class MyRewardsPage extends StatelessWidget {
  const MyRewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final rewards = [
      const RewardModel(
        title: 'nib Health Insurance',
        imageLabel: 'nib Health Insurance Image',
        description:
            'Access an exclusive discount of up to 8% off your health cover and skip the 2 & 6 month wait on extras.',
      ),
      const RewardModel(
        title: 'nib Green Pass',
        imageLabel: 'nib Green Pass Image',
        description:
            'Get access to health and wellbeing benefits designed to help you stay active and healthy.',
      ),
      const RewardModel(
        title: 'Lifestyle Discounts',
        imageLabel: 'Lifestyle Rewards Image',
        description:
            'Unlock discounts on shopping, travel, entertainment and more.',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: const MorePageAppBar(title: 'My Rewards'),

      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Access rewards and discounts from Kynd, part of the nib Thrive family.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF364153),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          ...rewards.map(
            (reward) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: RewardCard(reward: reward),
            ),
          ),
        ],
      ),
    );
  }
}

class RewardModel {
  final String title;
  final String description;
  final String imageLabel;

  const RewardModel({
    required this.title,
    required this.description,
    required this.imageLabel,
  });
}

class RewardCard extends StatelessWidget {
  final RewardModel reward;

  const RewardCard({super.key, required this.reward});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 140,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFE5E7EB),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    reward.imageLabel,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: NimoraColors.subtitleColor,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reward.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: NimoraColors.titleColor,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  reward.description,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF364153),
                  ),
                ),

                const SizedBox(height: 14),

                Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      SizedBox(width: 14),

                      Text(
                        'Learn More',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: NimoraColors.titleColor,
                        ),
                      ),

                      Spacer(),

                      Icon(Icons.chevron_right, color: Color(0xFF6B7280)),

                      SizedBox(width: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
