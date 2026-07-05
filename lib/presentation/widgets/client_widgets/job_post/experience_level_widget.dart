import 'package:flutter/material.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/job_post/job_post_success_widget.dart';

import 'job_post_step_card.dart';
import 'job_post_step_navigation.dart';

class ExperienceLevelWidget extends StatefulWidget {
  const ExperienceLevelWidget({
    super.key,
    required this.onBack,
    this.onPostJob,
  });

  final VoidCallback onBack;
  final VoidCallback? onPostJob;

  @override
  State<ExperienceLevelWidget> createState() => _ExperienceLevelWidgetState();
}

class _ExperienceLevelWidgetState extends State<ExperienceLevelWidget> {
  static const _experienceLevels = [
    ('Entry Level', '0-2 years of Experience'),
    ('Intermediate', '2-5 years of experience'),
    ('Expert', '5+ years of experience'),
  ];

  static const _availableSkills = [
    'Personal Care',
    'Community Access',
    'Meal Preparation',
    'Manual Handling',
    'Hoist Transfers',
    'PEG Feeding',
  ];

  static const _certifications = [
    'First Aid Certificate and CPR',
    "Australia Driver's Licence",
    'Manual Handling',
    'Medication Administration',
  ];

  static const _languages = [
    'English',
    'Mandarin',
    'Arabic',
    'Vietnamese',
    'Spanish',
    'Italian',
  ];

  static const _genderOptions = ['No preference', 'Female', 'Male'];

  String _selectedExperience = 'Intermediate';
  final Set<String> _selectedSkills = {'Community Access'};
  final Map<String, bool> _certificationsChecked = {};
  final Map<String, String?> _certificationPriority = {};
  final Set<String> _selectedLanguages = {'English'};
  String _selectedGender = 'No preference';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        JobPostStepCard(child: _buildExperienceLevelContent()),
        const SizedBox(height: 18),
        JobPostStepCard(child: _buildRequiredSkillsContent()),
        const SizedBox(height: 18),
        JobPostStepCard(child: _buildCertificationsContent()),
        const SizedBox(height: 18),
        JobPostStepCard(child: _buildLanguagePreferenceContent()),
        const SizedBox(height: 18),
        JobPostStepCard(child: _buildGenderPreferenceContent()),
        const SizedBox(height: 18),
        _buildVerificationBanner(),
        const SizedBox(height: 24),
        JobPostFinalNavigation(
          onPostJob: widget.onPostJob ?? ()
          {
            Navigator.push(context, MaterialPageRoute(builder: (_) => JobPostSuccessScreen())
          );
            },
          onBack: widget.onBack,
        ),
      ],
    );
  }

  Widget _buildExperienceLevelContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Experience Level',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ..._experienceLevels.map((level) {
          final label = level.$1;
          final subtitle = level.$2;
          final isSelected = _selectedExperience == label;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap: () => setState(() => _selectedExperience = label),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.teal.withValues(alpha: 0.1)
                      : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isSelected ? Colors.teal : Colors.grey.shade300,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: isSelected
                                  ? Colors.teal.shade800
                                  : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isSelected)
                      Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          color: Colors.teal,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildRequiredSkillsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Required Skills',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            hintText: 'Search for specific skills...',
            prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
        const SizedBox(height: 12),
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
            'Add Custom Skill',
            style: TextStyle(color: Colors.black),
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            const Text(
              'Skills include:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Text(
                '${_selectedSkills.length} Selected',
                style: TextStyle(
                  color: Colors.green.shade700,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ..._availableSkills.map(_buildSkillChip),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.teal.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.teal.shade200),
              ),
              child: Text(
                '+15',
                style: TextStyle(
                  color: Colors.teal.shade800,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSkillChip(String skill) {
    final isSelected = _selectedSkills.contains(skill);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedSkills.remove(skill);
          } else {
            _selectedSkills.add(skill);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.teal : Colors.grey.shade300,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              skill,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 4),
              const Icon(Icons.check, color: Colors.white, size: 16),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCertificationsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Required Certifications',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ..._certifications.map(_buildCertificationRow),
      ],
    );
  }

  Widget _buildCertificationRow(String certification) {
    final isChecked = _certificationsChecked[certification] ?? false;
    final hasPriorityMenu = certification == "Australia Driver's Licence";
    final priority = _certificationPriority[certification];

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Checkbox(
            value: isChecked,
            activeColor: Colors.teal,
            checkColor: Colors.white,
            side: BorderSide(color: Colors.grey.shade400, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            onChanged: (value) {
              setState(() {
                _certificationsChecked[certification] = value ?? false;
              });
            },
          ),
          Expanded(
            child: Text(
              certification,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          if (hasPriorityMenu && priority == null)
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert, color: Colors.grey.shade600),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              position: PopupMenuPosition.under,
              offset: const Offset(0, 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onSelected: (value) {
                setState(() {
                  _certificationPriority[certification] = value;
                });
              },
              itemBuilder: (context) => ['High', 'Medium', 'Low']
                  .map(
                    (level) => PopupMenuItem(
                      value: level,
                      child: Text(level),
                    ),
                  )
                  .toList(),
            ),
          if (hasPriorityMenu && priority != null)
            _buildPriorityBadge(priority),
        ],
      ),
    );
  }

  _PriorityStyle _priorityStyle(String priority) {
    switch (priority) {
      case 'High':
        return _PriorityStyle(
          backgroundColor: Colors.red.shade50,
          textColor: Colors.red.shade700,
          borderColor: Colors.red.shade200,
        );
      case 'Medium':
        return _PriorityStyle(
          backgroundColor: Colors.orange.shade50,
          textColor: Colors.orange.shade800,
          borderColor: Colors.orange.shade200,
        );
      case 'Low':
        return _PriorityStyle(
          backgroundColor: Colors.green.shade50,
          textColor: Colors.green.shade700,
          borderColor: Colors.green.shade200,
        );
      default:
        return _PriorityStyle(
          backgroundColor: Colors.grey.shade50,
          textColor: Colors.grey.shade700,
          borderColor: Colors.grey.shade200,
        );
    }
  }

  Widget _buildPriorityBadge(String priority) {
    final style = _priorityStyle(priority);
    return Container(
      margin: const EdgeInsets.only(left: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: style.borderColor),
      ),
      child: Text(
        priority,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: style.textColor,
        ),
      ),
    );
  }

  Widget _buildLanguagePreferenceContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Language Preference',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.black,
                    width: 1.5
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: const Icon(Icons.add, size: 20),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _languages.map(_buildLanguageChip).toList(),
        ),
      ],
    );
  }

  Widget _buildLanguageChip(String language) {
    final isSelected = _selectedLanguages.contains(language);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedLanguages.remove(language);
          } else {
            _selectedLanguages.add(language);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? Colors.teal : Colors.grey.shade300,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              language,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              const Icon(Icons.check, color: Colors.white, size: 16),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildGenderPreferenceContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Worker Gender Preference',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: List.generate(_genderOptions.length, (index) {
            final option = _genderOptions[index];
            final isSelected = _selectedGender == option;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 0 : 4,
                  right: index == _genderOptions.length - 1 ? 0 : 4,
                ),
                child: GestureDetector(
                  onTap: () => setState(() => _selectedGender = option),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 8,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.teal : Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        color:
                            isSelected ? Colors.teal : Colors.grey.shade300,
                        width: 1.5,
                      ),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        option,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: isSelected ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildVerificationBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.teal.shade100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.verified_user_outlined, color: Colors.teal.shade700),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'All workers are verified',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Every Nimora worker passes NDIS screening and identity '
                  'checks before joining the platform.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.teal.shade800,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PriorityStyle {
  const _PriorityStyle({
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
  });

  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
}
