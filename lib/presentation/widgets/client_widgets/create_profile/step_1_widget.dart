import 'package:flutter/material.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/create_profile/create_profile_data.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/create_profile/create_profile_widgets.dart';

class Step1WhoAreYou extends StatefulWidget {
  final CreateProfileData data;
  final VoidCallback onContinue;

  const Step1WhoAreYou({
    super.key,
    required this.data,
    required this.onContinue,
  });

  @override
  State<Step1WhoAreYou> createState() => _Step1WhoAreYouState();
}

class _Step1WhoAreYouState extends State<Step1WhoAreYou> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _dobController;
  late final TextEditingController _mobileController;
  late final TextEditingController _emailController;

  static const List<String> _genders = [
    'Male',
    'Female',
    'Non-binary',
    'Prefer not to say',
  ];

  @override
  void initState() {
    super.initState();
    final data = widget.data;
    _fullNameController = TextEditingController(text: data.fullName);
    _dobController = TextEditingController(text: data.dateOfBirth);
    _mobileController = TextEditingController(text: data.mobileNumber);
    _emailController = TextEditingController(text: data.email);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _dobController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: AppPaddings.page,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Who are you?',
              style: NdisThemeStyle.sectionTitle,
            ),
            const SizedBox(height: AppDimensions.paddingXS),
            Text(
              'Just the basics — takes 30 seconds.',
              style: NdisThemeStyle.bodyMedium,
            ),
            const SizedBox(height: AppDimensions.paddingL),

            LabeledField(
              label: 'Full Name',
              hint: 'Your full name',
              icon: Icons.person_outline,
              controller: _fullNameController,
              onChanged: (value) => data.fullName = value,
            ),
            const SizedBox(height: AppDimensions.paddingM),

            LabeledField(
              label: 'Date of Birth',
              hint: 'DD/MM/YYYY',
              icon: Icons.calendar_today_outlined,
              controller: _dobController,
              readOnly: true,
              onTap: _pickDate,
              onChanged: (value) => data.dateOfBirth = value,
            ),
            const SizedBox(height: AppDimensions.paddingM),

            LabeledField(
              label: 'Mobile Number',
              hint: '+61 400 000 000',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              controller: _mobileController,
              onChanged: (value) => data.mobileNumber = value,
            ),
            const SizedBox(height: AppDimensions.paddingM),

            LabeledField(
              label: 'Email Address',
              hint: 'you@example.com',
              optional: true,
              icon: Icons.mail_outline,
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              onChanged: (value) => data.email = value,
            ),
            const SizedBox(height: AppDimensions.paddingM),

            Text(
              'Gender',
              style: NdisThemeStyle.label,
            ),
            const SizedBox(height: AppDimensions.paddingS),

            Wrap(
              spacing: AppDimensions.paddingS,
              runSpacing: AppDimensions.paddingS,
              children: _genders.map((gender) {
                return _GenderChip(
                  label: gender,
                  selected: data.gender == gender,
                  onTap: () {
                    setState(() {
                      data.gender = gender;
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: AppDimensions.paddingL),

            Text(
              'Upload your ID Proof',
              style: NdisThemeStyle.label,
            ),
            const SizedBox(height: AppDimensions.paddingS),

            _IdUploadArea(
              fileName: data.idProofFileName,
              onPickFile: () {
                // TODO: replace with actual file picker
                setState(() {
                  data.idProofFileName = 'Photo ID Proof';
                });
              },
              onRemove: () {
                setState(() {
                  data.idProofFileName = null;
                });
              },
            ),

            const SizedBox(height: AppDimensions.paddingL),

            PrimaryButton(
              label: 'Continue',
              onPressed: widget.onContinue,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final initialDate = DateTime(now.year - 25, now.month, now.day);

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: AppColors.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final formatted =
          '${picked.day.toString().padLeft(2, '0')}/'
          '${picked.month.toString().padLeft(2, '0')}/'
          '${picked.year}';

      _dobController.text = formatted;
      widget.data.dateOfBirth = formatted;
      setState(() {});
    }
  }
}

class _GenderChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _GenderChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingM,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
          border: Border.all(color: Color(0xFFE5E7EB))
        ),
        child: Text(
          label,
          style: NdisThemeStyle.bodyMedium.copyWith(
            fontWeight: FontWeight.w500,
            color: selected ? AppColors.white : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

class _IdUploadArea extends StatelessWidget {
  final String? fileName;
  final VoidCallback onPickFile;
  final VoidCallback onRemove;

  const _IdUploadArea({
    required this.fileName,
    required this.onPickFile,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onPickFile,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          child: SizedBox(
            width: double.infinity,
            child: DottedBorderBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 28),
                child: Column(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: AppColors.chipBg,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.upload_outlined,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Upload your Id proof',
                      style: NdisThemeStyle.label.copyWith(fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Supported formats: PDF, JPG, PNG',
                      style: NdisThemeStyle.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (fileName != null) ...[
          const SizedBox(height: AppDimensions.paddingM),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.description_outlined,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(fileName!, style: NdisThemeStyle.label),
                      const SizedBox(height: 2),
                      Text(
                        'Uploaded just now',
                        style: NdisThemeStyle.bodyMedium,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onRemove,
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.redAccent,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class DottedBorderBox extends StatelessWidget {
  final Widget child;

  const DottedBorderBox({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(),
      child: child,
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;

    final rRect = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(AppDimensions.radiusM),
    );

    const dashWidth = 6.0;
    const dashSpace = 4.0;

    final path = Path()..addRRect(rRect);

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final double end = (distance + dashWidth).clamp(0.0, metric.length).toDouble();
        canvas.drawPath(
          metric.extractPath(distance, end),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}