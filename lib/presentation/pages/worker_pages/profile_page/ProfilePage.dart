import 'package:flutter/material.dart';
import 'package:nimora_worker/core/constants/nimora_colors.dart';
import 'package:nimora_worker/presentation/widgets/components/home_app_bar.dart';
import '../../../../core/theme/app_theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int selectedTab = 0;

  final tabs = ['About Me', 'Services', 'Credentials'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: const HomeAppBar(),

      body: Column(
        children: [
          const SizedBox(height: 14),

          // Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 44,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.grey200,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: List.generate(tabs.length, (index) {
                  final selected = selectedTab == index;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTab = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: selected
                              ? AppColors.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          tabs[index],
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: selected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          const SizedBox(height: 18),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
              child: [
                const _AboutTab(),
                const _ServicesTab(),
                const _CredentialsTab(),
              ][selectedTab],
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutTab extends StatelessWidget {
  const _AboutTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 34,
                    backgroundColor: AppColors.primary,
                    backgroundImage: AssetImage(
                      'assets/images/profile_image.jpg',
                    ),
                    // child: Text(
                    //   'MR',
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontWeight: FontWeight.w700,
                    //   ),
                    // ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Manoj Rajkumar',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: NimoraColors.profileTitleTextColor,
                              ),
                            ),

                            const SizedBox(width: 6),

                            Image.asset('assets/images/verified_icon.png'),
                          ],
                        ),

                        const SizedBox(height: 4),

                        const Text(
                          'CMO at Singultra',
                          style: TextStyle(
                            color: NimoraColors.jobClientSubtitleColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              const _ProfileInfoRow(
                icon: 'assets/images/location_icon.png',
                text: 'Macgregor',
              ),

              const _ProfileInfoRow(
                icon: 'assets/images/experience_icon.png',
                text: '4 Years Experience',
              ),

              const _ProfileInfoRow(
                icon: 'assets/images/language_icon.png',
                text: 'English, Indonesian, Malay, Tamil',
              ),

              const _ProfileInfoRow(
                icon: 'assets/images/pet_friendly_icon.png',
                text: 'Pet Friendly',
              ),

              const _ProfileInfoRow(
                icon: 'assets/images/smoking_icon.png',
                text: 'Non-Smoker',
              ),

              const SizedBox(height: 22),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hi',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: NimoraColors.profileTitleTextColor,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'I\'m a dedicated support worker with 4 years of experience helping people live their best lives. I\'m passionate about providing compassionate care and building meaningful relationships with the people I support.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: NimoraColors.moreTitleColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ServicesTab extends StatelessWidget {
  const _ServicesTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Support Services',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: NimoraColors.black,
            ),
          ),
        ),
        const _ServiceItems(
          title: 'Help in the Home',
          icon: 'assets/images/home_icon.png',
          noOfServices: 3,
          colorHex: 0xFFFFEDD4,
        ),
        const _ServiceItems(
          title: 'Social Assistance',
          icon: 'assets/images/handshake_icon.png',
          noOfServices: 4,
          colorHex: 0xFFFEF9C2,
        ),
        const _ServiceItems(
          title: 'Mentor & Life Skills',
          icon: 'assets/images/lightbulb_icon.png',
          noOfServices: 4,
          colorHex: 0xFFDBEAFE,
        ),
        const _ServiceItems(
          title: 'Travel & Transport',
          icon: 'assets/images/car_icon.png',
          noOfServices: 4,
          colorHex: 0xFFFFEDD4,
        ),
        const _ServiceItems(
          title: 'Health & Wellbeing',
          icon: 'assets/images/yoga_icon.png',
          noOfServices: 3,
          colorHex: 0xFFCBFBF1,
        ),
        const _ServiceItems(
          title: 'Personal Care',
          icon: 'assets/images/purple_heart_icon.png',
          noOfServices: 1,
          colorHex: 0xFFF3E8FF,
        ),
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(
                    color: Colors.grey, // Your border color
                    width: 1,
                  ),
                ),
              ),
              child: const Text(
                'Show All 27 Services',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ServiceItems extends StatelessWidget {
  final String title;
  final String icon;
  final int noOfServices;
  final int colorHex;

  const _ServiceItems({
    required this.icon,
    required this.title,
    required this.noOfServices,
    required this.colorHex,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Color(colorHex),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(icon),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: NimoraColors.titleColor,
                  ),
                ),
                Text(
                  '$noOfServices Services',
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: NimoraColors.subtitleColor,
                  ),
                ),
              ],
            ),
          ),
          Image.asset('assets/images/tick_icon.png'),
        ],
      ),
    );
  }
}

class _CredentialsTab extends StatelessWidget {
  const _CredentialsTab();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Credentials',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: NimoraColors.titleColor,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Declared by Manoj. Not verified  by app',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: NimoraColors.jobClientSubtitleColor,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Health Science',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: NimoraColors.titleColor,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Degree',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: NimoraColors.jobClientSubtitleColor,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Physiotherapy',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: NimoraColors.titleColor,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Certificate 2A',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: NimoraColors.jobClientSubtitleColor,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(
                      color: NimoraColors.switchToEditTitleTextColor,
                      // Your border color
                      width: 1,
                    ),
                  ),
                ),
                child: const Text(
                  'Switch to Edit',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: NimoraColors.switchToEditTitleTextColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  final String icon;
  final String text;

  const _ProfileInfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Image.asset(icon),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: NimoraColors.moreTitleColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
