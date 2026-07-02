import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nimora_worker/bloc/worker_bloc/login/login_bloc.dart';
import 'package:nimora_worker/presentation/widgets/components/sign_is_success_dialog.dart';
import 'package:nimora_worker/presentation/widgets/worker_widgets/login/auth_widgets.dart';
import 'package:nimora_worker/routes/app_router.dart';

import '../../../../core/theme/app_theme.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkerLoginBloc, WorkerLoginState>(
      listener: (context, state) {
        if (state is LoginOnLoadedState) {
          if (state.status == LoginStatus.success) {
            showSignInSuccessDialog(
              context,
              onComplete: () {
                Navigator.of(context).pop();
                context.go(AppRoutes.home);
              },
            );
          }

          if (state.status == LoginStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Login failed'),
                backgroundColor: Colors.redAccent,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          }
        }
      },
      builder: (context, state) {
        if (state is LoginOnLoadedState) {
          return Scaffold(
            backgroundColor: AppColors.white,
            resizeToAvoidBottomInset: true,
            body: Column(
              children: [
                // ── Header ─────────────────────────────────────────────
                AuthOrangeHeader(
                  title: 'Sign in to your\nAccount',
                  onBack: () => context.go(AppRoutes.splash),
                ),

                // ── Body ───────────────────────────────────────────────
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: const EdgeInsets.fromLTRB(
                          AppDimensions.paddingL,
                          AppDimensions.paddingXL,
                          AppDimensions.paddingL,
                          AppDimensions.paddingXL,
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: IntrinsicHeight(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ── Form Content ───────────────────────
                                Column(
                                  children: [
                                    _LoginForm(),

                                    const SizedBox(
                                      height: AppDimensions.paddingXL,
                                    ),

                                    _RegisterPrompt(),
                                  ],
                                ),

                                // ── Push footer to bottom ─────────────
                                const Spacer(),

                                // ── Footer ────────────────────────────
                                Column(
                                  children: [
                                    _TermsText(),
                                    const SizedBox(height: 70),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Login Form
// ─────────────────────────────────────────────────────────────────────────────

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkerLoginBloc, WorkerLoginState>(
      builder: (context, state) {
        final bloc = context.read<WorkerLoginBloc>();
        if (state is LoginOnLoadedState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Email ─────────────────────────────────────────────
              AppTextField(
                label: 'Email Address',
                hint: '',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onChanged: (v) => bloc.add(LoginEmailChanged(v)),
              ),

              const SizedBox(height: AppDimensions.paddingM),

              // ── Password ─────────────────────────────────────────
              AppTextField(
                label: 'Password',
                hint: '',
                obscureText: !state.passwordVisible,
                textInputAction: TextInputAction.done,
                onChanged: (v) => bloc.add(LoginPasswordChanged(v)),
                suffixIcon: IconButton(
                  onPressed: () =>
                      bloc.add(const LoginPasswordVisibilityToggled()),
                  icon: Icon(
                    state.passwordVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.grey400,
                    size: 20,
                  ),
                ),
              ),

              const SizedBox(height: AppDimensions.paddingM),

              // ── Remember / Forgot ────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          value: state.rememberMe,
                          onChanged: (_) =>
                              bloc.add(const LoginRememberMeToggled()),
                          activeColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          side: const BorderSide(color: AppColors.grey400),
                        ),
                      ),

                      const SizedBox(width: 8),

                      Text(
                        'Remember me',
                        style: NdisThemeStyle.bodyMedium.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  //Todo
                  // GestureDetector(
                  //   onTap: () => context.push(AppRoutes.forgotPassword),
                  //   child: Text(
                  //     'Forgot Password ?',
                  //     style: NdisThemeStyle.bodyMedium.copyWith(
                  //       color: const Color(0xFF4D81E7),
                  //       fontSize: 13,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //   ),
                  // ),
                ],
              ),

              const SizedBox(height: AppDimensions.paddingXL),

              // ── Login Button ────────────────────────────────────
              AppPrimaryButton(
                label: 'Log In',
                isLoading: state.status == LoginStatus.loading,
                onPressed: state.isFormValid
                    ? () => bloc.add(const LoginSubmitted())
                    : null,
              ),

              const SizedBox(height: AppDimensions.paddingM),

              // ── Register ────────────────────────────────────────
              //ToDo
              // Center(
              //   child: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       Text(
              //         "Don't have an account? ",
              //         style: NdisThemeStyle.bodyMedium.copyWith(
              //           fontSize: 14,
              //           color: const Color(0xFF1E1B1B),
              //         ),
              //       ),
              //       const SizedBox(width: 10),
              //       GestureDetector(
              //         onTap: () => context.push(AppRoutes.register),
              //         child: Text(
              //           'Sign Up',
              //           style: NdisThemeStyle.bodyMedium.copyWith(
              //             fontSize: 14,
              //             color: const Color(0xFF092967),
              //             fontWeight: FontWeight.w700,
              //             decoration: TextDecoration.underline,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Register Prompt
// ─────────────────────────────────────────────────────────────────────────────

class _RegisterPrompt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Terms Text
// ─────────────────────────────────────────────────────────────────────────────

class _TermsText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: NdisThemeStyle.bodyMedium.copyWith(fontSize: 12),
          children: const [
            TextSpan(text: 'By signing up, you agree to the '),

            TextSpan(
              text: 'Terms of Service',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),

            TextSpan(text: ' and\n'),

            TextSpan(
              text: 'Data Processing Agreement',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
