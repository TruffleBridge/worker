import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/create_profile/create_profile_data.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/create_profile/create_profile_widgets.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/create_profile/profile_success_screen.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/create_profile/step_1_widget.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/create_profile/step_2_widget.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/create_profile/step_3_widget.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/create_profile/step_4_widget.dart';
import 'package:nimora_worker/routes/app_router.dart';

class CreateProfileFlow extends StatefulWidget {
  const CreateProfileFlow({super.key});

  @override
  State<CreateProfileFlow> createState() => _CreateProfileFlowState();
}

class _CreateProfileFlowState extends State<CreateProfileFlow> {
  late final PageController _pageController;
  final CreateProfileData _data = CreateProfileData();

  int _step = 0;
  bool _completed = false;

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

  void _goTo(int step) {
    if (step < 0 || step >= _totalSteps) return;

    setState(() => _step = step);
    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeInOut,
    );
  }

  void _next() {
    if (_step < _totalSteps - 1) {
      _goTo(_step + 1);
    }
  }

  void _back() {
    if (_step > 0) {
      _goTo(_step - 1);
      return;
    }

    if (context.canPop()) {
      context.pop();
    }
  }

  void _submit() {
    // TODO: integrate API submission here using _data
    setState(() => _completed = true);
  }

  @override
  Widget build(BuildContext context) {
    if (_completed) {
      return ProfileSuccessScreen(
        onFindWorkers: () {
          context.go(AppRoutes.clientHome);
        },
        onPostJob: () {
          context.go(AppRoutes.clientJobPost);
        },
        onGoToDashboard: () {
          context.go(AppRoutes.clientHome);
        },
        onBack: () => setState(() => _completed = false),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFFF1F1F1),
      appBar: CreateProfileAppBar(title: _title, onBack: _back),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            StepProgressBar(currentStep: _step, totalSteps: _totalSteps),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),  color: Colors.white),
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      if (_step != index) {
                        setState(() => _step = index);
                      }
                    },
                    children: [
                      Step1WhoAreYou(data: _data, onContinue: _next),
                      Step2BusinessDetails(
                        data: _data,
                        onContinue: _next,
                        onBack: _back,
                      ),
                      Step3MandatoryDocuments(
                        data: _data,
                        onContinue: _next,
                        onBack: _back,
                      ),
                      Step4RecommendedDocuments(
                        data: _data,
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
  }
}
