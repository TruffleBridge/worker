import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimora_worker/bloc/client_bloc/create_profile/create_profile_bloc.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/create_profile/create_profile_widgets.dart';

class Step2BusinessDetails extends StatefulWidget {
  final VoidCallback onContinue;
  final VoidCallback onBack;

  const Step2BusinessDetails({
    super.key,
    required this.onContinue,
    required this.onBack,
  });

  @override
  State<Step2BusinessDetails> createState() =>
      _Step2BusinessDetailsState();
}

class _Step2BusinessDetailsState
    extends State<Step2BusinessDetails> {
  static const List<String> _states = [
    'NSW',
    'VIC',
    'QLD',
    'WA',
    'SA',
    'TAS',
    'ACT',
    'NT',
  ];

  late final TextEditingController _businessNameController;
  late final TextEditingController _abnController;
  late final TextEditingController _acnController;
  late final TextEditingController _addressController;
  late final TextEditingController _suburbController;
  late final TextEditingController _postcodeController;

  @override
  void initState() {
    super.initState();

    final state = context.read<CreateProfileBloc>().state;

    _businessNameController = TextEditingController(
      text: state.businessName,
    );

    _abnController = TextEditingController(
      text: state.abn,
    );

    _acnController = TextEditingController(
      text: state.acn,
    );

    _addressController = TextEditingController(
      text: state.address,
    );

    _suburbController = TextEditingController(
      text: state.suburb,
    );

    _postcodeController = TextEditingController(
      text: state.postcode,
    );
  }

  @override
  void dispose() {
    _businessNameController.dispose();
    _abnController.dispose();
    _acnController.dispose();
    _addressController.dispose();
    _suburbController.dispose();
    _postcodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        AppDimensions.radiusM,
      ),
      borderSide: const BorderSide(
        color: AppColors.cardBorder,
      ),
    );

    return BlocBuilder<CreateProfileBloc, CreateProfileState>(
      builder: (context, state) {
        return SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: AppPaddings.page,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter your Registered NDIS Business Name',
                  style: NdisThemeStyle.sectionTitle,
                ),
                const SizedBox(
                  height: AppDimensions.paddingXS,
                ),
                Text(
                  'Please provide your official registered business name as it appears on your NDIS provider registration documents.',
                  style: NdisThemeStyle.bodyMedium,
                ),
                const SizedBox(
                  height: AppDimensions.paddingL,
                ),

                LabeledField(
                  label: 'Registered Business Name',
                  hint: 'e.g. Care Solutions Pty. Ltd',
                  icon: Icons.apartment_outlined,
                  controller: _businessNameController,
                  onChanged: (value) {
                    context.read<CreateProfileBloc>().add(
                      CreateProfileBusinessNameChanged(value),
                    );
                  },
                ),
                const SizedBox(
                  height: AppDimensions.paddingM,
                ),

                LabeledField(
                  label: 'Active ABN',
                  hint: '11-digit ABN',
                  keyboardType: TextInputType.number,
                  controller: _abnController,
                  onChanged: (value) {
                    context.read<CreateProfileBloc>().add(
                      CreateProfileAbnChanged(value),
                    );
                  },
                ),
                const SizedBox(
                  height: AppDimensions.paddingM,
                ),

                LabeledField(
                  label: 'ACN',
                  hint: '9-digit ACN',
                  keyboardType: TextInputType.number,
                  controller: _acnController,
                  onChanged: (value) {
                    context.read<CreateProfileBloc>().add(
                      CreateProfileAcnChanged(value),
                    );
                  },
                ),

                const SizedBox(
                  height: AppDimensions.paddingL,
                ),

                Text(
                  'Business Address',
                  style: NdisThemeStyle.sectionTitle,
                ),
                const SizedBox(
                  height: AppDimensions.paddingM,
                ),

                LabeledField(
                  label: 'Enter your business address',
                  hint: '123 Example Street',
                  icon: Icons.location_on_outlined,
                  controller: _addressController,
                  onChanged: (value) {
                    context.read<CreateProfileBloc>().add(
                      CreateProfileAddressChanged(value),
                    );
                  },
                ),
                const SizedBox(
                  height: AppDimensions.paddingM,
                ),

                LabeledField(
                  label: 'Suburb',
                  hint: 'Enter suburb',
                  controller: _suburbController,
                  onChanged: (value) {
                    context.read<CreateProfileBloc>().add(
                      CreateProfileSuburbChanged(value),
                    );
                  },
                ),
                const SizedBox(
                  height: AppDimensions.paddingM,
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            'State',
                            style: NdisThemeStyle.label,
                          ),
                          const SizedBox(height: 6),
                          DropdownButtonFormField<String>(
                            value: state.stateValue.isEmpty
                                ? null
                                : state.stateValue,
                            items: _states.map((stateValue) {
                              return DropdownMenuItem<String>(
                                value: stateValue,
                                child: Text(
                                  stateValue,
                                  style: NdisThemeStyle.bodyMedium
                                      .copyWith(
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              context
                                  .read<CreateProfileBloc>()
                                  .add(
                                CreateProfileStateChanged(
                                  value ?? '',
                                ),
                              );
                            },
                            style: NdisThemeStyle.bodyMedium.copyWith(
                              color: AppColors.textPrimary,
                            ),
                            dropdownColor: AppColors.white,
                            decoration: InputDecoration(
                              hintText: 'Select',
                              hintStyle: NdisThemeStyle.hint,
                              filled: true,
                              fillColor: AppColors.white,
                              contentPadding:
                              const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                              border: baseBorder,
                              enabledBorder: baseBorder,
                              focusedBorder: baseBorder.copyWith(
                                borderSide: const BorderSide(
                                  color: AppColors.primary,
                                  width: 1.4,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: AppDimensions.paddingM,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          LabeledField(
                            label: 'Postal Code',
                            hint: '0000',
                            keyboardType: TextInputType.number,
                            controller: _postcodeController,
                            onChanged: (value) {
                              context
                                  .read<CreateProfileBloc>()
                                  .add(
                                CreateProfilePostcodeChanged(
                                  value,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: AppDimensions.paddingL,
                ),

                PrimaryButton(
                  label: 'Continue',
                  onPressed: widget.onContinue,
                ),

                const SizedBox(
                  height: AppDimensions.paddingM,
                ),

                SecondaryButton(
                  label: 'Back',
                  onPressed: widget.onBack,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}