import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nimora_worker/bloc/worker_bloc/onboarding/onboarding_bloc.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';
import 'package:nimora_worker/presentation/widgets/worker_widgets/onboarding/onboarding_card.dart';
import 'package:nimora_worker/presentation/widgets/worker_widgets/onboarding/onboarding_dots_indicator.dart';
import 'package:nimora_worker/routes/app_router.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late PageController _pageController;

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

  void _animateToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingCompleted) {
          context.go(AppRoutes.chooseRole);
        }
        if (state is OnboardingLoaded) {
          // Sync controller when bloc updates page
          if (_pageController.hasClients &&
              _pageController.page?.round() != state.currentPage) {
            _animateToPage(state.currentPage);
          }
        }
      },
      builder: (context, state) {
        if (state is OnboardingLoading || state is OnboardingInitial) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        }

        if (state is OnboardingError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: AppColors.primary,
                    size: 48,
                  ),
                  const SizedBox(height: AppDimensions.paddingM),
                  Text(state.message, style: NdisThemeStyle.bodyMedium),
                  const SizedBox(height: AppDimensions.paddingM),
                  ElevatedButton(
                    onPressed: () => context.read<OnboardingBloc>().add(
                      const OnboardingStarted(),
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is OnboardingLoaded) {
          return Scaffold(
            backgroundColor: AppColors.white,
            body: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: state.items.length,
                    onPageChanged: (index) {
                      context.read<OnboardingBloc>().add(
                        OnboardingPageChanged(index),
                      );
                    },
                    itemBuilder: (context, index) {
                      return OnboardingCard(item: state.items[index]);
                    },
                  ),
                ),
                _buildBottomSection(context, state),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
  Widget _buildBottomSection(BuildContext context, OnboardingLoaded state) {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.only(
        left: AppDimensions.paddingL,
        right: AppDimensions.paddingL,
        top: AppDimensions.paddingL,
        bottom: MediaQuery.of(context).padding.bottom + AppDimensions.paddingL,
      ),
      child: Column(
        children: [
          // Dots Indicator
          Center(
            child: OnboardingDotsIndicator(
              count: state.items.length,
              currentIndex: state.currentPage,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingXL),

          // Actions
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.1),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
            child: state.isLastPage
                ? _buildGetStartedButton(context, state)
                : _buildSkipNextRow(context, state),
          ),
        ],
      ),
    );
  }

  Widget _buildSkipNextRow(BuildContext context, OnboardingLoaded state) {
    return Row(
      key: const ValueKey('skip_next'),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            context.read<OnboardingBloc>().add(
              const OnboardingSkipPressed(),
            );
          },
          child: Text(
            'Skip',
            style: NdisThemeStyle.labelLarge.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.skipText,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            context.read<OnboardingBloc>().add(
              const OnboardingNextPressed(),
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Next',
                style: NdisThemeStyle.labelLarge.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.skipText,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 24,
                color: AppColors.skipText,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGetStartedButton(BuildContext context, OnboardingLoaded state) {
    return SizedBox(
      key: const ValueKey('get_started'),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => context.read<OnboardingBloc>().add(
          const OnboardingGetStartedPressed(),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          minimumSize: const Size(double.infinity, AppDimensions.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
          elevation: 0,
        ),
        child: Text('Get Started', style: NdisThemeStyle.labelLarge),
      ),
    );
  }
}
