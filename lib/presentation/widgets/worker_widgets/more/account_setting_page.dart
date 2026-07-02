import 'package:flutter/material.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';
import 'package:nimora_worker/presentation/widgets/worker_widgets/more/MorePageAppBar.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final accountItems = [
      {
        'title': 'Name',
        'value': 'Manoj Rajkumar',
        'icon': Icons.person_outline,
      },
      {
        'title': 'Phone Number',
        'value': '+61 416 397 125',
        'icon': Icons.phone_outlined,
      },
      {
        'title': 'Email ID',
        'value': 'manojrajasu10050@email.com',
        'icon': Icons.email_outlined,
      },
      {'title': 'Gender', 'value': 'Male', 'icon': Icons.badge_outlined},
      {
        'title': 'Age/DOB',
        'value': '10/05/2003',
        'icon': Icons.calendar_month_outlined,
      },
      {
        'title': 'Address',
        'value': '1 Fernshaw Street, Macgregor, QLD 4109',
        'icon': Icons.location_on_outlined,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MorePageAppBar(
        title: 'Account',
        actionButton: 'assets/images/edit_icon.png',
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                const SizedBox(height: 10),
                /// Profile Image
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/profile.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 34,
                            height: 34,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                /// Info Card
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Column(
                    children: List.generate(accountItems.length, (index) {
                      final item = accountItems[index];

                      return Column(
                        children: [
                          _AccountInfoTile(
                            title: item['title'] as String,
                            value: item['value'] as String,
                            icon: item['icon'] as IconData,
                          ),
                          if (index != accountItems.length - 1)
                            const Divider(
                              height: 1,
                              indent: 60,
                              endIndent: 16,
                              color: Color(0xFFF1F5F9),
                            ),
                        ],
                      );
                    }),
                  ),
                ),

                const SizedBox(height: 30),

                Center(
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    label: Text(
                      'Delete Account',
                      style: NdisThemeStyle.displayLarge.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
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

class _AccountInfoTile extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _AccountInfoTile({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: const Color(0xFF6B7280)),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
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
