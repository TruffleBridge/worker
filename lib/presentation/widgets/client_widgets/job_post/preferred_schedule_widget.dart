import 'package:flutter/material.dart';

import 'job_post_step_card.dart';
import 'job_post_step_navigation.dart';

class PreferredScheduleWidget extends StatefulWidget {
  const PreferredScheduleWidget({
    super.key,
    required this.onNext,
    required this.onSaveDraft,
  });

  final VoidCallback onNext;
  final VoidCallback onSaveDraft;

  @override
  State<PreferredScheduleWidget> createState() =>
      _PreferredScheduleWidgetState();
}

class _PreferredScheduleWidgetState extends State<PreferredScheduleWidget> {
  String _selectedRecurring = 'Weekly';
  final Set<int> _selectedDays = {1, 3, 5};
  double _hourlyBudget = 40.5;

  final Map<int, TimeOfDay> _startTimes = {
    1: const TimeOfDay(hour: 9, minute: 0),
    3: const TimeOfDay(hour: 9, minute: 0),
    5: const TimeOfDay(hour: 9, minute: 0),
  };

  final Map<int, TimeOfDay> _endTimes = {
    1: const TimeOfDay(hour: 14, minute: 0),
    3: const TimeOfDay(hour: 14, minute: 0),
    5: const TimeOfDay(hour: 14, minute: 0),
  };

  static const _dayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  static const _dayNames = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  Future<void> _pickTime(int dayIndex, bool isStart) async {
    final initial = isStart
        ? (_startTimes[dayIndex] ?? const TimeOfDay(hour: 9, minute: 0))
        : (_endTimes[dayIndex] ?? const TimeOfDay(hour: 14, minute: 0));

    final picked = await showTimePicker(
      context: context,
      initialTime: initial,
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startTimes[dayIndex] = picked;
        } else {
          _endTimes[dayIndex] = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        JobPostStepCard(child: _buildScheduleContent()),
        const SizedBox(height: 18),
        JobPostStepCard(child: _buildFinancialsContent()),
        const SizedBox(height: 24),
        JobPostStepNavigation(
          onNext: widget.onNext,
          onSaveDraft: widget.onSaveDraft,
        ),
      ],
    );
  }

  Widget _buildScheduleContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.calendar_month_rounded, color: Colors.teal.shade700),
            const SizedBox(width: 8),
            const Text(
              'Preferred Schedule',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          'Preferred Start Date',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          readOnly: true,
          onTap: () async {
            await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
          },
          decoration: InputDecoration(
            hintText: 'mm/dd/yyyy',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 22),
        const Text(
          'Recurring Needs',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildRecurringOption('Weekly', 'Every week'),
              const SizedBox(width: 8),
              _buildRecurringOption('Fortnightly', 'Every 2 weeks'),
              const SizedBox(width: 8),
              _buildRecurringOption('Monthly', 'Once a month'),
            ],
          ),
        ),
        const SizedBox(height: 22),
        Row(
          children: List.generate(_dayLabels.length, (index) {
            final isSelected = _selectedDays.contains(index);
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: index == 0 ? 0 : 4),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedDays.remove(index);
                          _startTimes.remove(index);
                          _endTimes.remove(index);
                        } else {
                          _selectedDays.add(index);
                          _startTimes[index] =
                              const TimeOfDay(hour: 9, minute: 0);
                          _endTimes[index] =
                              const TimeOfDay(hour: 14, minute: 0);
                        }
                      });
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? Colors.teal.withValues(alpha: 0.12)
                            : Colors.grey.shade100,
                        border: Border.all(
                          color:
                              isSelected ? Colors.teal : Colors.grey.shade300,
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            _dayLabels[index],
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? Colors.teal.shade800
                                  : Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        if (_selectedDays.isNotEmpty) ...[
          const SizedBox(height: 22),
          ...(_selectedDays.toList()..sort()).map(_buildDayTimeRow),
        ],
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
            side: BorderSide(
              color: Colors.grey.shade400,
              style: BorderStyle.solid,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          icon: const Icon(Icons.add, color: Colors.black),
          label: const Text(
            'Add Time Range',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget _buildRecurringOption(String label, String subtitle) {
    final isSelected = _selectedRecurring == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedRecurring = label),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.teal.withValues(alpha: 0.12)
                : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? Colors.teal : Colors.grey.shade300,
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: isSelected ? Colors.teal.shade800 : Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  subtitle,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDayTimeRow(int dayIndex) {
    final start = _startTimes[dayIndex] ?? const TimeOfDay(hour: 9, minute: 0);
    final end = _endTimes[dayIndex] ?? const TimeOfDay(hour: 14, minute: 0);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(
              _dayNames[dayIndex],
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: _buildTimeField(
              _formatTime(start),
              () => _pickTime(dayIndex, true),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('to', style: TextStyle(color: Colors.grey.shade600)),
          ),
          Expanded(
            child: _buildTimeField(
              _formatTime(end),
              () => _pickTime(dayIndex, false),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeField(String time, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Text(
          time,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildFinancialsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.paid_outlined, color: Colors.teal.shade700),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                'Financials',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Text(
                'NDIS Compliant',
                style: TextStyle(
                  color: Colors.green.shade700,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          'HOURLY BUDGET RANGE',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade600,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '\$${_hourlyBudget.toStringAsFixed(2)} /hr',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.teal,
            inactiveTrackColor: Colors.grey.shade300,
            thumbColor: Colors.orange,
            overlayColor: Colors.orange.withValues(alpha: 0.2),
          ),
          child: Slider(
            value: _hourlyBudget,
            min: 40,
            max: 150,
            onChanged: (value) => setState(() => _hourlyBudget = value),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\$40/hr',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
            Text(
              '\$150/hr',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.teal.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, color: Colors.teal.shade700, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Recommended budget for standard community participation is '
                  '\$42.00–\$68.00/hr based on current NDIS Price Guide 2024.',
                  style: TextStyle(
                    color: Colors.teal.shade900,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
