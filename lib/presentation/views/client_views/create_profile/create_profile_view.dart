import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nimora_worker/bloc/client_bloc/create_profile/create_profile_bloc.dart';
import 'package:nimora_worker/core/enums/create_profile_status.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/create_profile/create_profile_widgets.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/create_profile/profile_success_screen.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/create_profile/step_1_widget.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/create_profile/step_2_widget.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/create_profile/step_3_widget.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/create_profile/step_4_widget.dart';
import 'package:nimora_worker/routes/app_router.dart';

class CreateProfileView extends StatefulWidget {
  const CreateProfileView({super.key});

  @override
  State<CreateProfileView> createState() => _CreateProfileViewState();
}

class _CreateProfileViewState extends State<CreateProfileView> {
  late final PageController _pageController;

  static const int _totalSteps = 4;
  static const String _title = 'Create Profile';

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  void _next() {
    context.read<CreateProfileBloc>().add(
      const CreateProfileNextStep(),
    );
  }

  void _back() {
    final bloc = context.read<CreateProfileBloc>();

    if (bloc.state.currentStep > 0) {
      bloc.add(
        const CreateProfilePreviousStep(),
      );

      return;
    }

    if (context.canPop()) {
      context.pop();
    }
  }

  void _submit() {
    final bloc = context.read<CreateProfileBloc>();

    if (bloc.state.status == CreateProfileStatus.loading) {
      return;
    }

    bloc.add(
      const CreateProfileSubmitted(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateProfileBloc, CreateProfileState>(
      listenWhen: (previous, current) {
        return previous.currentStep != current.currentStep ||
            previous.status != current.status;
      },
      listener: (context, state) {
        if (_pageController.hasClients &&
            _pageController.page?.round() != state.currentStep) {
          _pageController.animateToPage(
            state.currentStep,
            duration: const Duration(
              milliseconds: 280,
            ),
            curve: Curves.easeInOut,
          );
        }

        if (state.status == CreateProfileStatus.failure &&
            state.errorMessage.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.completed) {
          return ProfileSuccessScreen(
            onFindWorkers: () {
              context.go(
                AppRoutes.clientHome,
              );
            },
            onPostJob: () {
              context.go(
                AppRoutes.clientJobPost,
              );
            },
            onGoToDashboard: () {
              context.go(
                AppRoutes.clientHome,
              );
            },
            onBack: () {
              context.read<CreateProfileBloc>().add(
                const CreateProfileCompletionReset(),
              );
            },
          );
        }

        return Scaffold(
          backgroundColor: const Color(
            0xFFF1F1F1,
          ),
          appBar: CreateProfileAppBar(
            title: _title,
            onBack: _back,
          ),
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                StepProgressBar(
                  currentStep: state.currentStep,
                  totalSteps: _totalSteps,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          7,
                        ),
                        color: Colors.white,
                      ),
                      child: PageView(
                        controller: _pageController,
                        physics:
                        const NeverScrollableScrollPhysics(),
                        onPageChanged: (index) {
                          if (state.currentStep != index) {
                            context
                                .read<CreateProfileBloc>()
                                .add(
                              CreateProfileGoToStep(
                                index,
                              ),
                            );
                          }
                        },
                        children: [
                          Step1WhoAreYou(
                            onContinue: _next,
                          ),
                          Step2BusinessDetails(
                            onContinue: _next,
                            onBack: _back,
                          ),
                          Step3MandatoryDocuments(
                            onContinue: _next,
                            onBack: _back,
                          ),
                          Step4RecommendedDocuments(
                            onSubmit: _submit,
                            onBack: _back,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}