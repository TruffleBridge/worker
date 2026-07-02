import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nimora_worker/core/constants/nimora_colors.dart';
import 'package:nimora_worker/presentation/widgets/worker_widgets/more/MorePageAppBar.dart';
import 'package:nimora_worker/routes/app_router.dart';

class IncidentReportsPage extends StatelessWidget {
  const IncidentReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),

      appBar: const MorePageAppBar(title: 'Incident Reports'),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF5E6),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: const Icon(
                    Icons.shield_outlined,
                    size: 30,
                    color: Color(0xFFD97706),
                  ),
                ),
                const SizedBox(width: 20),
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Incident Report',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: NimoraColors.titleColor,
                      ),
                    ),

                    SizedBox(height: 6),

                    Text(
                      'Record of incident for review',
                      style: TextStyle(
                        color: Color(0xFF364153),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Text(
              'If the incident is a Reportable Incident you must immediately submit a report to the NDIS Quality and Safeguards Commission and alert Kynd via the below form.\n\n'
              'As per the NDIS Code of Conduct, you must manage all incidents as an NDIS Service Provider. To help you manage incidents, we have a form on our website.',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF364153),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  context.push(AppRoutes.incidentForm);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF086D63),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Incident Form'),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF086D63)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Learn More',
                  style: TextStyle(color: Color(0xFF086D63)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IncidentFormPage extends StatefulWidget {
  const IncidentFormPage({super.key});

  @override
  State<IncidentFormPage> createState() => _IncidentFormPageState();
}

class _IncidentFormPageState extends State<IncidentFormPage> {
  bool hasExpiry = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),

      appBar: const MorePageAppBar(title: 'Incident Form'),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Verification Type *',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: const [],
              onChanged: (_) {},
            ),

            const SizedBox(height: 20),

            TextFormField(
              decoration: InputDecoration(
                labelText: 'Reference/Card Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                const Expanded(
                  child: Text(
                    'This verification expires',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),

                Switch(
                  value: hasExpiry,
                  onChanged: (value) {
                    setState(() {
                      hasExpiry = value;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            TextFormField(
              decoration: InputDecoration(
                labelText: 'Start Date',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            if (hasExpiry)
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Expiry Date *',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

            const SizedBox(height: 24),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFD1D5DB)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: const [
                  Icon(Icons.upload_file, size: 36, color: Color(0xFF9CA3AF)),

                  SizedBox(height: 8),

                  Text(
                    'Upload Document',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),

                  SizedBox(height: 4),

                  Text(
                    'Supported formats: PDF, JPG, PNG (Max 10MB)',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF086D63),
                ),
                child: const Text('Submit Incident'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
