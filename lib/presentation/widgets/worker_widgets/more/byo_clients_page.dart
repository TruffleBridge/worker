import 'package:flutter/material.dart';
import 'package:nimora_worker/core/constants/nimora_colors.dart';
import 'package:nimora_worker/presentation/widgets/worker_widgets/more/MorePageAppBar.dart';

class ByoClientsPage extends StatelessWidget {
  const ByoClientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final benefits = [
      const ByoBenefit(
        icon: 'assets/images/dollar_icon.png',
        color: Color(0xFFECFDF5),
        title: 'Workers keep 99% of rates',
      ),
      const ByoBenefit(
        icon: 'assets/images/booking_icon_blue.png',
        color: Color(0xFFEFF6FF),
        title: 'NDIS bookings in one place',
      ),
      const ByoBenefit(
        icon: 'assets/images/automate_icon.png',
        color: Color(0xFFFAF5FF),
        title: 'Automate invoices & payment',
      ),
      const ByoBenefit(
        icon: 'assets/images/safe_gaurd_icon.png',
        color: Color(0xFFFFF7ED),
        title: 'Participant/Provider safeguards',
      ),
      const ByoBenefit(
        icon: 'assets/images/verified_icon_green.png',
        color: Color(0xFFECFEFF),
        title: '\$20M insurance for workers',
      ),
      const ByoBenefit(
        icon: 'assets/images/message_icon.png',
        color: Color(0xFFFDF2F8),
        title: 'Messaging, alerts, and more!',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: const MorePageAppBar(title: 'BYO Clients'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// Header Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFB300),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.group_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),

                    const SizedBox(width: 12),

                     Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Invite Your NDIS Clients',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: NimoraColors.titleColor,
                            ),
                          ),

                          SizedBox(height: 6),

                          Text(
                            'Already supporting NDIS Participants?\nUse Care to provide services.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF4A5565),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// Benefits List
              Expanded(
                child: ListView.separated(
                  itemCount: benefits.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (_, index) {
                    return BenefitTile(benefit: benefits[index]);
                  },
                ),
              ),

              const SizedBox(height: 16),

              /// Bottom Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.send_outlined, size: 18),
                  label: const Text(
                    'Invite Clients',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF086D63),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ByoBenefit {
  final String icon;
  final Color color;
  final String title;

  const ByoBenefit({
    required this.icon,
    required this.color,
    required this.title,
  });
}

class BenefitTile extends StatelessWidget {
  final ByoBenefit benefit;

  const BenefitTile({super.key, required this.benefit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EA)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: benefit.color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(benefit.icon),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              benefit.title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Color(0xFF1E2939),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
