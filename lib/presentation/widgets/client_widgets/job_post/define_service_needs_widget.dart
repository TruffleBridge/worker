import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimora_worker/bloc/client_bloc/job_post/job_post_bloc.dart';

import 'job_post_step_card.dart';
import 'job_post_step_navigation.dart';

class DefineServiceNeedsWidget extends StatefulWidget {
  const DefineServiceNeedsWidget({
    super.key,
    required this.onNext,
    this.onSaveDraft,
  });

  final VoidCallback onNext;
  final VoidCallback? onSaveDraft;

  @override
  State<DefineServiceNeedsWidget> createState() =>
      _DefineServiceNeedsWidgetState();
}

class _DefineServiceNeedsWidgetState extends State<DefineServiceNeedsWidget> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  final List<String> _serviceCategories = const ['Healthcare'];

  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    final state = context.read<JobPostBloc>().state;

    _titleController = TextEditingController(text: state.title);
    _descriptionController = TextEditingController(text: state.description);
    _selectedCategory = state.category.isNotEmpty ? state.category : null;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  int? _getServiceCategoryId(String? value) {
    if (value == null) return null;

    switch (value) {
      case 'Healthcare':
        return 1;
      case 'Training':
        return 2;
      default:
        return null;
    }
  }

  void _handleNext() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    final category = _selectedCategory ?? '';

    context.read<JobPostBloc>().add(
      JobPostUpdateBasicDetailsEvent(
        title: title,
        description: description,
        category: category,
        serviceCategoryId: _getServiceCategoryId(category),
        serviceId: 2,
      ),
    );

    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        JobPostStepCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Define your service needs',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1C1B1D),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Start by providing the basic information about the support you require.',
                style: TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 24),

              /// Job Title
              const Text(
                'Job Title',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'e.g. Morning Assistance and Meal Prep',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              /// Service Category
              const Text(
                'Service Category',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: _serviceCategories
                    .map(
                      (category) => DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),

              const SizedBox(height: 18),

              /// Description
              const Text(
                'Description',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _descriptionController,
                maxLines: 5,
                maxLength: 1000,
                decoration: InputDecoration(
                  hintText:
                      'Provide details about the routine, any specific needs, or preferences...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintStyle: TextStyle(
                    color: Color(0xFF93A0B2),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                  counterText: '',
                ),
                onChanged: (_) => setState(() {}),
              ),

              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Mention specific mobility aids or routines if applicable.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  Text(
                    '${_descriptionController.text.length} / 1000',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              JobPostStepNavigation(
                onNext: _handleNext,
                onSaveDraft: widget.onSaveDraft,
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8F3),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.orange.shade100),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.lightbulb_outline, color: Color(0xFFE9A620)),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tips for a Great Post',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: Color(0xFF1C1B1D),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Jobs with detailed descriptions receive 40% more applications from qualified workers.',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF594237),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
