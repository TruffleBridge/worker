import 'package:flutter/material.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';

class AvailabilitySection extends StatelessWidget {
  const AvailabilitySection({super.key});

  // Each day: [morning, afternoon, allDay]
  // 'allDay' is true when both morning & afternoon are available
  static const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  final List<AvailabilityDay> availability = const [
    AvailabilityDay(day: 'Mon', morning: true, afternoon: false),
    AvailabilityDay(day: 'Tue', morning: false, afternoon: true),
    AvailabilityDay(day: 'Wed', morning: true, afternoon: true),
    AvailabilityDay(day: 'Thu', morning: true, afternoon: false),
    AvailabilityDay(day: 'Fri', morning: false, afternoon: true),
    AvailabilityDay(day: 'Sat', morning: false, afternoon: false),
    AvailabilityDay(day: 'Sun', morning: false, afternoon: false),
  ];

  @override
  Widget build(BuildContext context) {
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
          // ── Header ──────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Availability',
                style: NdisThemeStyle.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF002045),
                  fontSize: 18,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF10B981),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Available',
                    style: NdisThemeStyle.bodyMedium.copyWith(
                      color: const Color(0xFF74777F),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ── Day-column headers ───────────────────────────────
          Row(
            children: availability
                .map(
                  (day) => Expanded(
                    child: Center(
                      child: Text(
                        day.day,
                        style: NdisThemeStyle.bodyMedium.copyWith(
                          color: Color(0xFF706767),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),

          const SizedBox(height: 10),

          // ── AM row ───────────────────────────────────────────
          _SlotRow(
            label: 'AM',
            slots: availability.map((d) => d.morning).toList(),
          ),

          const SizedBox(height: 8),

          // ── PM row ───────────────────────────────────────────
          _SlotRow(
            label: 'PM',
            slots: availability.map((d) => d.afternoon).toList(),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// One horizontal row of chips (AM / PM / ALL)
// ─────────────────────────────────────────────────────────────
class _SlotRow extends StatelessWidget {
  final String label;
  final List<bool> slots; // length == 7, one per day

  const _SlotRow({required this.label, required this.slots});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(slots.length, (i) {
        return Expanded(
          child: Center(
            child: _SlotChip(label: label, available: slots[i]),
          ),
        );
      }),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Individual chip — teal when available, grey dash otherwise
// ─────────────────────────────────────────────────────────────
class _SlotChip extends StatelessWidget {
  final String label;
  final bool available;

  const _SlotChip({required this.label, required this.available});

  static const _teal = Color(0xFF10B981);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: available ? _teal : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        available ? label : '—',
        style: TextStyle(
          color: available ? Colors.white : Colors.grey.shade400,
          fontWeight: FontWeight.w600,
          fontSize: 11,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Data model
// ─────────────────────────────────────────────────────────────
class AvailabilityDay {
  final String day;
  final bool morning;
  final bool afternoon;

  const AvailabilityDay({
    required this.day,
    required this.morning,
    required this.afternoon,
  });
}
