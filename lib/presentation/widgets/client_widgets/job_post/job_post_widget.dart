import 'package:flutter/material.dart';

import 'define_service_needs_widget.dart';
import 'experience_level_widget.dart';
import 'preferred_schedule_widget.dart';

class JobPostWidget extends StatefulWidget {
  const JobPostWidget({super.key});

  @override
  State<JobPostWidget> createState() => _JobPostWidgetState();
}

class _JobPostWidgetState extends State<JobPostWidget> {
  static const int _totalSteps = 3;

  int _currentStep = 1;

  void _goToNextStep() {
    if (_currentStep < _totalSteps) {
      setState(() => _currentStep++);
    }
  }

  void _goToPreviousStep() {
    if (_currentStep > 1) {
      setState(() => _currentStep--);
    }
  }

  void _handleBack() {
    if (_currentStep > 1) {
      _goToPreviousStep();
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildProgressBar(),
              const SizedBox(height: 22),
              if (_currentStep == 1)
                DefineServiceNeedsWidget(onNext: _goToNextStep)
              else if (_currentStep == 2)
                PreferredScheduleWidget(
                  onNext: _goToNextStep,
                  onSaveDraft: _goToPreviousStep,
                )
              else
                ExperienceLevelWidget(
                  onBack: _goToPreviousStep,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 18,
            ),
            onPressed: _handleBack,
          ),
        ),
        const SizedBox(width: 14),
        const Text(
          'Job Post',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Text(
          'Step $_currentStep of $_totalSteps',
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar() {
    return Row(
      children: List.generate(_totalSteps * 2 - 1, (index) {
        if (index.isOdd) {
          return const SizedBox(width: 4);
        }
        final stepIndex = index ~/ 2;
        final isFilled = stepIndex < _currentStep;
        return Expanded(
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: isFilled ? Colors.teal : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      }),
    );
  }
}
