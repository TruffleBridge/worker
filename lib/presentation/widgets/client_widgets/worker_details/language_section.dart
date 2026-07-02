import 'package:flutter/material.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';

class LanguagesSection extends StatelessWidget {
  const LanguagesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final languages = [
      'English',
      'Hindi',
      'Tamil',
      'Malayalam',
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
            'Languages',
            style: NdisThemeStyle.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xFF1A233A),
            ),
          ),

          const SizedBox(height: 18),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: languages
                .map(
                  (language) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEBE7E9),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  language,
                  style: NdisThemeStyle.bodyMedium.copyWith(
                    color: Color(0xFF594237),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
                .toList(),
          ),
        ],
      ),
    );
  }
}