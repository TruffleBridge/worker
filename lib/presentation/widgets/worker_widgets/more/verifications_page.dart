import 'package:flutter/material.dart';
import 'package:nimora_worker/core/constants/nimora_colors.dart';
import 'package:nimora_worker/presentation/widgets/worker_widgets/more/MorePageAppBar.dart';

class VerificationsPage extends StatefulWidget {
  const VerificationsPage({super.key});

  @override
  State<VerificationsPage> createState() => _VerificationsPageState();
}

class _VerificationsPageState extends State<VerificationsPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: const MorePageAppBar(title: 'Verifications'),

      body: Column(
        children: [
          TabBar(
            controller: controller,
            labelColor: const Color(0xFF086D63),
            tabs: const [
              Tab(text: 'Current'),
              Tab(text: 'Archive'),
            ],
          ),

          Expanded(
            child: TabBarView(
              controller: controller,
              children: const [
                CurrentVerificationTab(),
                ArchiveVerificationTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CurrentVerificationTab extends StatelessWidget {
  const CurrentVerificationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        VerificationCard(
          title: 'NDIS Worker Orientation Certificate',
          verified: true,
        ),

        SizedBox(height: 12),

        VerificationCard(title: 'Children WWCC - QLD', verified: false),

        SizedBox(height: 12),

        VerificationCard(title: 'Worker Screening ID', verified: true),
      ],
    );
  }
}

class VerificationCard extends StatelessWidget {
  final String title;
  final bool verified;

  const VerificationCard({
    super.key,
    required this.title,
    required this.verified,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),

      child: Column(
        children: [
          Row(
            children: [
              Icon(
                verified ? Icons.check_circle : Icons.warning,
                size: 14,
                color: verified
                    ? const Color(0xFF00A63E)
                    : const Color(0xFFA60000),
              ),

              const SizedBox(width: 4),

              Text(
                verified ? 'Verified' : 'Pending',
                style: TextStyle(
                  color: verified
                      ? const Color(0xFF00A63E)
                      : const Color(0xFFA60000),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),
          Row(
            children: [
              // Container(
              //   width: 60,
              //   height: 60,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(8),
              //     color: Colors.grey.shade200,
              //   ),
              //   child: const Icon(Icons.image),
              // ),
              Image.asset('assets/images/verification_document.jpg'),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: NimoraColors.titleColor,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Row(
                      spacing: 8,
                      children: [
                        Image.asset('assets/images/calendar_symbol.png'),
                        const Text(
                          '07/21/2025 - 07/21/2026',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF7F7F7F),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ArchiveVerificationTab extends StatelessWidget {
  const ArchiveVerificationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/archive_icon.jpg'),
          const SizedBox(height: 12),

          const Text(
            'No archived verifications',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class AddVerificationPage extends StatefulWidget {
  const AddVerificationPage({super.key});

  @override
  State<AddVerificationPage> createState() => _AddVerificationPageState();
}

class _AddVerificationPageState extends State<AddVerificationPage> {
  bool hasExpiry = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Verification')),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Verification Type'),
              items: const [],
              onChanged: (_) {},
            ),

            const SizedBox(height: 16),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Reference/Card Number',
              ),
            ),

            const SizedBox(height: 16),

            SwitchListTile(
              value: hasExpiry,
              title: const Text('This verification expires'),
              onChanged: (v) {
                setState(() {
                  hasExpiry = v;
                });
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              decoration: const InputDecoration(labelText: 'Start Date'),
            ),

            const SizedBox(height: 16),

            if (hasExpiry)
              TextFormField(
                decoration: const InputDecoration(labelText: 'Expiry Date'),
              ),

            const SizedBox(height: 16),

            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(child: Text('Upload Document')),
            ),

            const SizedBox(height: 16),

            TextFormField(
              maxLines: 4,
              decoration: const InputDecoration(labelText: 'Notes'),
            ),

            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Verification pending: Once submitted it will be reviewed.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
