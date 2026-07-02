import 'package:flutter/material.dart';
import 'package:nimora_worker/core/constants/nimora_colors.dart';
import 'package:nimora_worker/presentation/widgets/worker_widgets/more/MorePageAppBar.dart';

class ServiceNotesPage extends StatelessWidget {
  const ServiceNotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notes = [
      const ServiceNote(
        date: '24 Feb 2026',
        participants: 'Manoj R. • Kallem C.',
        note:
            'Kallem just went to the local park to do light exercises there was decent. We went for a short walk.',
      ),
      const ServiceNote(
        date: '19 Feb 2026',
        participants: 'Manoj R. • Oliver H.',
        note:
            'Picked up Oli from his workplace. We went straight home as his mum wanted to take him.',
      ),
      const ServiceNote(
        date: '3 Feb 2026',
        participants: 'Manoj R. • Oliver H.',
        note:
            'Picked up Jim from his workplace at 1pm. We went home for a quick bath.',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),

      appBar: const MorePageAppBar(title: 'Service Notes'),

      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(child: _FilterWidget(title: 'All Dates')),

                SizedBox(width: 10),

                Expanded(child: _FilterWidget(title: 'All Participants')),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8E6),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFF2D98D)),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, size: 18, color: Color(0xFFC28A00)),

                  SizedBox(width: 8),

                  Expanded(
                    child: Text(
                      'Use the desktop version to download your Service Notes',
                      style: TextStyle(fontSize: 14, color: Color(0xFF7B3306)),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: notes.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ServiceNoteCard(note: notes[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceNote {
  final String date;
  final String participants;
  final String note;

  const ServiceNote({
    required this.date,
    required this.participants,
    required this.note,
  });
}

class _FilterWidget extends StatelessWidget {
  final String title;

  const _FilterWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          const Icon(Icons.filter_list, size: 16, color: Color(0xFF6B7280)),

          const SizedBox(width: 6),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: NimoraColors.titleColor,
              ),
            ),
          ),

          const Icon(Icons.keyboard_arrow_down, size: 18),
        ],
      ),
    );
  }
}

class ServiceNoteCard extends StatelessWidget {
  final ServiceNote note;

  const ServiceNoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  note.date,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: NimoraColors.titleColor,
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {},
                child: const Row(
                  children: [
                    Text(
                      'View',
                      style: TextStyle(
                        color: Color(0xFF155DFC),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right,
                      size: 16,
                      color: Color(0xFF155DFC),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          Text(
            note.participants,
            style: const TextStyle(
              color: Color(0xFF4A5565),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            note.note,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF364153),
            ),
          ),
        ],
      ),
    );
  }
}
