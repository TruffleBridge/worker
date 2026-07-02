import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';

class ComplianceSection extends StatelessWidget {
  const ComplianceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final compliances = [
      'First Aid & CPR',
      'Police Check (Current)',
      'WWCC Registered',
      'First Aid Certificate',
      'CPR Certificate',
      'NDIS Worker Screening',
    ];

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
            'Compliance',
            style: NdisThemeStyle.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xFF002045),
            ),
          ),

          const SizedBox(height: 18),

          ...List.generate(compliances.length, (index) {
            final item = compliances[index];

            return Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/images/green_circular_tick.svg'),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Text(
                        item,
                        style: NdisThemeStyle.bodyMedium.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xFF181C1E),
                        ),
                      ),
                    ),
                    // const Icon(Icons.verified, color: Colors.green, size: 20),
                  ],
                ),
                SizedBox(height: 15),

                // if (index != compliances.length - 1) ...[
                //   const SizedBox(height: 14),
                //   Divider(color: Colors.grey.shade200, thickness: 1),
                //   const SizedBox(height: 14),
                // ],
              ],
            );
          }),
        ],
      ),
    );
  }
}
