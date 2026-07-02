import 'package:flutter/material.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/worker_details/availablity_section.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/worker_details/compliance_section.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/worker_details/language_section.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/worker_details/review_card.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/worker_details/worker_profile_header.dart';

class WorkerDetailWidget extends StatelessWidget {
  const WorkerDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F6F6),
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        title: const Text(
          'Worker Profile',
          style: TextStyle(
            color: Color(0xFF101828),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Profile
            const WorkerProfileHeader(),

            const SizedBox(height: 16),

            /// About
            _sectionCard(
              title: 'About Manoj',
              child: const Text(
                "I'm a dedicated support worker with 4 years of experience helping people live their best lives...",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF364153),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// Languages
            const LanguagesSection(),

            const SizedBox(height: 16),

            /// Compliance
            const ComplianceSection(),

            const SizedBox(height: 16),

            /// Availability
            const AvailabilitySection(),

            const SizedBox(height: 20),

            /// Reviews Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Reviews',
                  style: NdisThemeStyle.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF002045),
                    fontSize: 18,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'View All Reviews',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF13696A),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            const ReviewCard(
              name: 'Michael J.',
              initials: 'MJ',
              review:
                  'Sarah was incredible with my father. Very patient and understanding.',
              time: '2 days ago',
            ),

            const SizedBox(height: 12),

            const ReviewCard(
              name: 'Anna L.',
              initials: 'AL',
              review:
                  'Highly professional and always on time. A real asset to our care team.',
              time: '1 week ago',
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _sectionCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF002045),
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}
