import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:nimora_worker/bloc/client_bloc/job_post/job_post_bloc.dart';

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
  final Set<int> _selectedDays = {0, 2, 4};
  double _hourlyBudget = 40.5;

  DateTime? _preferredStartDate;

  final TextEditingController _serviceRequirementController =
      TextEditingController();
  final TextEditingController _street1Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _hoursPerDayController = TextEditingController();

  String? _selectedShift = 'Morning';

  // String? _selectedState = 'Tamil Nadu';
  int _hoursPerDay = 8;
  double? _latitude = 13.0827;
  double? _longitude = 80.2707;

  final Map<int, TimeOfDay> _startTimes = {
    0: const TimeOfDay(hour: 9, minute: 0),
    2: const TimeOfDay(hour: 9, minute: 0),
    4: const TimeOfDay(hour: 9, minute: 0),
  };

  final Map<int, TimeOfDay> _endTimes = {
    0: const TimeOfDay(hour: 14, minute: 0),
    2: const TimeOfDay(hour: 14, minute: 0),
    4: const TimeOfDay(hour: 14, minute: 0),
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

  // static const _shiftOptions = ['Morning', 'Afternoon', 'Evening', 'Night'];
  // static const _stateOptions = [
  //   'Tamil Nadu',
  //   'Kerala',
  //   'Karnataka',
  //   'Andhra Pradesh',
  //   'Telangana',
  // ];

  @override
  void initState() {
    super.initState();
    final state = context.read<JobPostBloc>().state;

    if (state.hourlyRate != null) {
      _hourlyBudget = state.hourlyRate!.toDouble();
    }

    if (state.startDate.isNotEmpty) {
      try {
        _preferredStartDate = DateTime.parse(state.startDate);
      } catch (_) {}
    }

    if (state.shift.isNotEmpty) {
      _selectedShift = state.shift;
    }

    if (state.hoursPerDay != null) {
      _hoursPerDay = state.hoursPerDay!;
    }

    _hoursPerDayController.text = _hoursPerDay.toString();
    _serviceRequirementController.text = state.serviceRequirement;
    _street1Controller.text = state.street1;
    _stateController.text = state.stateName;
    _cityController.text = state.city;
    _zipCodeController.text = state.zipCode;

    // if (state.stateName.isNotEmpty) {
    //   _selectedState = state.stateName;
    // }

    _latitude = state.latitude ?? 13.0827;
    _longitude = state.longitude ?? 80.2707;
  }

  @override
  void dispose() {
    _serviceRequirementController.dispose();
    _street1Controller.dispose();
    _cityController.dispose();
    _zipCodeController.dispose();
    _hoursPerDayController.dispose();
    super.dispose();
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  String _formatDateForUi(DateTime date) {
    return DateFormat('MM/dd/yyyy').format(date);
  }

  String _formatDateForApi(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  String _formatTimeForApi(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Future<void> _pickTime(int dayIndex, bool isStart) async {
    final initial = isStart
        ? (_startTimes[dayIndex] ?? const TimeOfDay(hour: 9, minute: 0))
        : (_endTimes[dayIndex] ?? const TimeOfDay(hour: 14, minute: 0));

    final picked = await showTimePicker(context: context, initialTime: initial);

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

  Future<void> _pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _preferredStartDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        _preferredStartDate = picked;
      });
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _handleNext() {
    if (_preferredStartDate == null) {
      _showError('Please select preferred start date');
      return;
    }

    if (_selectedDays.isEmpty) {
      _showError('Please select at least one day');
      return;
    }

    if ((_selectedShift ?? '').isEmpty) {
      _showError('Please select shift');
      return;
    }

    if (_street1Controller.text.trim().isEmpty ||
        _cityController.text.trim().isEmpty ||
        _zipCodeController.text.trim().isEmpty) {
      _showError('Please fill location details');
      return;
    }

    final sortedDays = _selectedDays.toList()..sort();
    final firstSelectedDay = sortedDays.first;

    final startTime =
        _startTimes[firstSelectedDay] ?? const TimeOfDay(hour: 9, minute: 0);
    final endTime =
        _endTimes[firstSelectedDay] ?? const TimeOfDay(hour: 14, minute: 0);

    final formattedDate = _formatDateForApi(_preferredStartDate!);

    context.read<JobPostBloc>().add(
      JobPostUpdateScheduleEvent(
        hourlyRate: _hourlyBudget.round(),
        shift: _selectedShift ?? '',
        hoursPerDay: int.tryParse(_hoursPerDayController.text.trim()) ?? 0,
        serviceRequirement: _serviceRequirementController.text.trim(),
        street1: _street1Controller.text.trim(),
        city: _cityController.text.trim(),
        stateName: _stateController.text.trim(),
        zipCode: _zipCodeController.text.trim(),
        latitude: _latitude,
        longitude: _longitude,
        startDate: formattedDate,
        endDate: formattedDate,
        startTime: _formatTimeForApi(startTime),
        endTime: _formatTimeForApi(endTime),
        timeSlotStartTime: _formatTimeForApi(startTime),
        timeSlotEndTime: _formatTimeForApi(endTime),
      ),
    );

    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        JobPostStepCard(child: _buildScheduleContent()),
        const SizedBox(height: 18),
        JobPostStepCard(child: _buildLocationContent()),
        const SizedBox(height: 18),
        JobPostStepCard(child: _buildFinancialsContent()),
        const SizedBox(height: 24),
        JobPostStepNavigation(
          onNext: _handleNext,
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
            Icon(Icons.calendar_month_outlined, color: Colors.teal.shade700),
            const SizedBox(width: 8),
            const Text(
              'Preferred Schedule',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1C1B1D),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          'Preferred Start Date',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1C1B1D),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          readOnly: true,
          controller: TextEditingController(
            text: _preferredStartDate != null
                ? _formatDateForUi(_preferredStartDate!)
                : '',
          ),
          onTap: _pickStartDate,
          decoration: InputDecoration(
            hintText: 'mm/dd/yyyy',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 22),
        const Text(
          'Recurring Needs',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1C1B1D),
          ),
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
                          _startTimes[index] = const TimeOfDay(
                            hour: 9,
                            minute: 0,
                          );
                          _endTimes[index] = const TimeOfDay(
                            hour: 14,
                            minute: 0,
                          );
                        }
                      });
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? Colors.teal.withOpacity(0.12)
                            : Colors.grey.shade100,
                        border: Border.all(
                          color: isSelected
                              ? Colors.teal
                              : Colors.grey.shade300,
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
      ],
    );
  }

  Widget _buildLocationContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Location',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1C1B1D),
          ),
        ),
        const SizedBox(height: 20),

        const Text(
          'Street Address',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1C1B1D),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _street1Controller,
          decoration: InputDecoration(
            hintText: 'Enter street address',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),

        const SizedBox(height: 18),

        const Text(
          'City',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1C1B1D),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _cityController,
          decoration: InputDecoration(
            hintText: 'Enter city',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),

        const SizedBox(height: 18),

        const Text(
          'State',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1C1B1D),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _stateController,
          decoration: InputDecoration(
            hintText: 'Enter state',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),

        const SizedBox(height: 18),

        const Text(
          'Zip Code',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1C1B1D),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _zipCodeController,
          keyboardType: TextInputType.number,
          maxLength: 6,
          decoration: InputDecoration(
            hintText: 'Enter zip code',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
                ? Colors.teal.withOpacity(0.12)
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
                  // style: TextStyle(
                  //   fontWeight: FontWeight.w600,
                  //   fontSize: 13,
                  //   color: isSelected ? Colors.teal.shade800 : Colors.black87,
                  // ),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1C1B1D),
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
                  style: TextStyle(fontSize: 10, color: Color(0xFF64748B)),
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
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Color(0xFF1C1B1D),
                fontSize: 14,
              ),
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
            // child: Text('to', style: TextStyle(color: Colors.grey.shade600)),
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
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Color(0xFF1C1B1D),
          ),
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
            // Icon(Icons.paid_outlined, color: Colors.teal.shade700),
            SvgPicture.asset('assets/images/financial_icon.svg'),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                'Financials',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1C1B1D),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xFFE6FAF4),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Text(
                'NDIS Compliant',
                style: TextStyle(
                  color: Color(0xFF10B981),
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
            color: Color(0xFF64748B),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '\$${_hourlyBudget.toStringAsFixed(2)} /hr',
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1C1B1D),
          ),
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.teal,
            inactiveTrackColor: Colors.grey.shade300,
            thumbColor: Color(0xFFF56B0C),
            overlayColor: Color(0xFFF56B0C).withOpacity(0.2),
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
      ],
    );
  }
}
