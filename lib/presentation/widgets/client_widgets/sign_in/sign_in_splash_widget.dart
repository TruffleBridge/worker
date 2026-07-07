// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:nimora_worker/core/constants/assets_images.dart';
// import 'package:nimora_worker/core/theme/app_theme.dart';
// import 'package:nimora_worker/presentation/widgets/components/sign_is_success_dialog.dart';
// import 'package:nimora_worker/presentation/widgets/worker_widgets/sign_in_splash/social_buttons.dart';
// import 'package:nimora_worker/routes/app_router.dart';

// class ClientSignInSplashWidget extends StatelessWidget {
//   const ClientSignInSplashWidget({super.key});
//
//   static const _email = 'lokesh@gmail.com';
//   static const _password = 'Test@123';
//
//   void _onSocialButtonTap(BuildContext context) {
//     final bloc = context.read<ClientLoginBloc>();
//     bloc.add(const LoginEmailChanged(_email));
//     bloc.add(const LoginPasswordChanged(_password));
//     bloc.add(const LoginSubmitted());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ClientLoginBloc, ClientLoginState>(
//       listener: (context, state) {
//         if (state is LoginOnLoadedState) {
//           if (state.status == LoginStatus.success) {
//             showSignInSuccessDialog(
//               context,
//               onComplete: () {
//                 Navigator.of(context).pop();
//                 context.go(AppRoutes.home);
//               },
//             );
//           }
//           if (state.status == LoginStatus.failure) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.errorMessage ?? 'Login failed'),
//                 backgroundColor: Colors.redAccent,
//                 behavior: SnackBarBehavior.floating,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             );
//           }
//         }
//       },
//       builder: (context, state) {
//         final isLoading =
//             state is LoginOnLoadedState && state.status == LoginStatus.loading;
//
//         return Scaffold(
//           body: Stack(
//             fit: StackFit.expand,
//             children: [
//               Image.asset(AssetJPGImages.splashBackground, fit: BoxFit.cover),
//               Container(color: const Color(0xFF0C4F5A).withValues(alpha: 0.55)),
//               SafeArea(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: AppDimensions.paddingL,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       // const Spacer(flex: 3),
//                       const SizedBox(height: 14),
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 120),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             SvgPicture.asset(
//                               AssetSVGImages.nimoraLogo,
//                               width: 140,
//                               height: 140,
//                             ),
//                             const SizedBox(height: 20),
//                             const Text(
//                               'Care Support',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 32,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const Spacer(flex: 4),
//                       // Social buttons
//                       SocialSplashButton(
//                         imagePath: AssetSVGImages.googleLogo,
//                         label: 'Sign In Using Google',
//                         isLoading: isLoading,
//                         onTap: isLoading
//                             ? () {}
//                             : () => _onSocialButtonTap(context),
//                       ),
//                       const SizedBox(height: 12),
//                       SocialSplashButton(
//                         imagePath: AssetSVGImages.facebookLogo,
//                         label: 'Sign in Using Facebook',
//                         isLoading: isLoading,
//                         onTap: isLoading
//                             ? () {}
//                             : () => _onSocialButtonTap(context),
//                       ),
//                       const SizedBox(height: 48),
//                       SocialSplashButton(
//                         imagePath: AssetSVGImages.appleLogo,
//                         label: 'Sign In Using Apple ID',
//                         isApple: true,
//                         isLoading: isLoading,
//                         onTap: isLoading
//                             ? () {}
//                             : () => _onSocialButtonTap(context),
//                       ),
//                       const SizedBox(height: 20),
//                       // Black Log In button
//                       SizedBox(
//                         width: double.infinity,
//                         height: AppDimensions.buttonHeight,
//                         child: ElevatedButton(
//                           onPressed: () => context.go(AppRoutes.login),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.textPrimary,
//                             foregroundColor: AppColors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(
//                                 AppDimensions.radiusM,
//                               ),
//                             ),
//                             elevation: 0,
//                           ),
//                           child: Text(
//                             'Log In',
//                             style: NdisThemeStyle.labelLarge,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       //ToDo
//                       // Register link
//                       // GestureDetector(
//                       //   onTap: () {
//                       //     context.go(AppRoutes.register);
//                       //   },
//                       //   child: RichText(
//                       //     text: TextSpan(
//                       //       style: NdisThemeStyle.bodyMedium.copyWith(
//                       //         color: AppColors.white,
//                       //         fontSize: 13,
//                       //       ),
//                       //       children: const [
//                       //         TextSpan(text: "Don't have an account? "),
//                       //         TextSpan(
//                       //           text: 'Register',
//                       //           style: TextStyle(
//                       //             decoration: TextDecoration.underline,
//                       //             fontWeight: FontWeight.w700,
//                       //           ),
//                       //         ),
//                       //       ],
//                       //     ),
//                       //   ),
//                       // ),
//                       const SizedBox(height: AppDimensions.paddingXXL),
//                     ],
//                   ),
//                 ),
//               ),
//               if (isLoading)
//                 const ColoredBox(
//                   color: Colors.transparent,
//                   child: Center(child: CircularProgressIndicator()),
//                 ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nimora_worker/bloc/worker_bloc/login/login_bloc.dart';
import 'package:nimora_worker/core/constants/assets_images.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';
import 'package:nimora_worker/presentation/widgets/components/sign_is_success_dialog.dart';
import 'package:nimora_worker/presentation/widgets/worker_widgets/sign_in_splash/social_buttons.dart';
import 'package:nimora_worker/routes/app_router.dart';

class ClientSignInSplashWidget extends StatelessWidget {
  const ClientSignInSplashWidget({super.key});

  static const _email = 'lokesh@gmail.com';
  static const _password = 'Test@123';

  // void _onSignInButtonTap(BuildContext context) {
  //   final bloc = context.read<LoginBloc>();
  //   bloc.add(const ClientLoginEmailChanged(_email) as LoginEvent);
  //   bloc.add(const ClientLoginPasswordChanged(_password) as LoginEvent);
  //   bloc.add(const ClientLoginSubmitted() as LoginEvent);
  // }
  void _onSocialButtonTap(BuildContext context) {
    final bloc = context.read<WorkerLoginBloc>();
    bloc.add(const LoginEmailChanged(_email));
    bloc.add(const LoginPasswordChanged(_password));
    bloc.add(const LoginSubmitted());
  }

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
                context.go(AppRoutes.clientCreateProfile);
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
        final isLoading =
            state is LoginOnLoadedState && state.status == LoginStatus.loading;
        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(AssetJPGImages.splashBackground, fit: BoxFit.cover),
              Container(color: const Color(0xFF0C4F5A).withOpacity(0.55)),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingL,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 14),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 120),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              AssetSVGImages.nimoraLogo,
                              width: 140,
                              height: 140,
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Care Support',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(flex: 4),

                      SocialSplashButton(
                        imagePath: AssetSVGImages.googleLogo,
                        label: 'Sign In Using Google',
                        isLoading: isLoading,
                        onTap: isLoading
                            ? () {}
                            : () => _onSocialButtonTap(context),
                      ),

                      const SizedBox(height: 12),

                      SocialSplashButton(
                        imagePath: AssetSVGImages.facebookLogo,
                        label: 'Sign in Using Facebook',
                        isLoading: isLoading,
                        onTap: isLoading
                            ? () {}
                            : () => _onSocialButtonTap(context),
                      ),

                      const SizedBox(height: 48),

                      SocialSplashButton(
                        imagePath: AssetSVGImages.appleLogo,
                        label: 'Sign In Using Apple ID',
                        isApple: true,
                        isLoading: isLoading,
                        onTap: isLoading
                            ? () {}
                            : () => _onSocialButtonTap(context),
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: AppDimensions.buttonHeight,
                        child: ElevatedButton(
                          onPressed: () {
                            context.go(AppRoutes.clientLogin);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.textPrimary,
                            foregroundColor: AppColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppDimensions.radiusM,
                              ),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Log In',
                            style: NdisThemeStyle.labelLarge,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // TODO: Register
                      // GestureDetector(
                      //   onTap: () => context.go(AppRoutes.clientRegister),
                      //   child: RichText(
                      //     text: TextSpan(
                      //       style: NdisThemeStyle.bodyMedium.copyWith(
                      //         color: AppColors.white,
                      //         fontSize: 13,
                      //       ),
                      //       children: const [
                      //         TextSpan(text: "Don't have an account? "),
                      //         TextSpan(
                      //           text: 'Register',
                      //           style: TextStyle(
                      //             decoration: TextDecoration.underline,
                      //             fontWeight: FontWeight.w700,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: AppDimensions.paddingXXL),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
