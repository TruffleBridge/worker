// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:nimora_worker/presentation/widgets/login/auth_widgets.dart';
// import 'package:nimora_worker/routes/app_router.dart';
//
// import '../../../../core/theme/app_theme.dart';
//
// class RegisterPage extends StatelessWidget {
//   const RegisterPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<RegisterBloc, RegisterState>(
//       listener: (context, state) {
//         if (state.status == RegisterStatus.success) {
//           context.go(AppRoutes.home);
//         }
//         if (state.status == RegisterStatus.failure) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(state.errorMessage ?? 'Registration failed'),
//               backgroundColor: Colors.redAccent,
//               behavior: SnackBarBehavior.floating,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10)),
//             ),
//           );
//         }
//       },
//       child: Scaffold(
//         backgroundColor: AppColors.white,
//         body: Column(
//           children: [
//             AuthOrangeHeader(
//               title: 'Register',
//               onBack: () => context.go(AppRoutes.splash),
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.fromLTRB(
//                   AppDimensions.paddingL,
//                   AppDimensions.paddingXL,
//                   AppDimensions.paddingL,
//                   AppDimensions.paddingXL,
//                 ),
//                 child: _RegisterForm(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _RegisterForm extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<RegisterBloc, RegisterState>(
//       builder: (context, state) {
//         final bloc = context.read<RegisterBloc>();
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: AppTextField(
//                     label: 'First Name',
//                     hint: 'john',
//                     textInputAction: TextInputAction.next,
//                     onChanged: (v) => bloc.add(RegisterFirstNameChanged(v)),
//                   ),
//                 ),
//                 const SizedBox(width: AppDimensions.paddingM),
//                 Expanded(
//                   child: AppTextField(
//                     label: 'Last Name',
//                     hint: 'Kim',
//                     textInputAction: TextInputAction.next,
//                     onChanged: (v) => bloc.add(RegisterLastNameChanged(v)),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: AppDimensions.paddingM),
//             AppTextField(
//               label: 'Email',
//               hint: 'johnkim@gmail.com',
//               keyboardType: TextInputType.emailAddress,
//               textInputAction: TextInputAction.next,
//               onChanged: (v) => bloc.add(RegisterEmailChanged(v)),
//             ),
//             const SizedBox(height: AppDimensions.paddingM),
//             AppTextField(
//               label: 'Password',
//               hint: '',
//               obscureText: !state.passwordVisible,
//               textInputAction: TextInputAction.next,
//               onChanged: (v) => bloc.add(RegisterPasswordChanged(v)),
//               suffixIcon: IconButton(
//                 onPressed: () =>
//                     bloc.add(const RegisterPasswordVisibilityToggled()),
//                 icon: Icon(
//                   state.passwordVisible
//                       ? Icons.visibility_off_outlined
//                       : Icons.visibility_outlined,
//                   color: AppColors.grey400,
//                   size: 20,
//                 ),
//               ),
//             ),
//             const SizedBox(height: AppDimensions.paddingM),
//             _PhoneField(onChanged: (v) => bloc.add(RegisterPhoneChanged(v))),
//             const SizedBox(height: AppDimensions.paddingXL),
//             AppPrimaryButton(
//               label: 'Register',
//               isLoading: state.status == RegisterStatus.loading,
//               onPressed: state.isFormValid
//                   ? () => bloc.add(const RegisterSubmitted())
//                   : null,
//             ),
//             const SizedBox(height: AppDimensions.paddingL),
//             Center(
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text('Already have an account? ',
//                       style: NdisThemeStyle.bodyMedium.copyWith(fontSize: 13)),
//                   GestureDetector(
//                     onTap: () => context.go(AppRoutes.login),
//                     child: Text('Sign In',
//                         style: NdisThemeStyle.bodyMedium.copyWith(
//                           fontSize: 13,
//                           color: AppColors.primary,
//                           fontWeight: FontWeight.w700,
//                         )),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
//
// class _PhoneField extends StatelessWidget {
//   final ValueChanged<String> onChanged;
//   const _PhoneField({required this.onChanged});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Phone Number',
//           style: NdisThemeStyle.bodyMedium.copyWith(
//             color: AppColors.textPrimary,
//             fontWeight: FontWeight.w600,
//             fontSize: 13,
//           ),
//         ),
//         const SizedBox(height: 6),
//         Row(
//           children: [
//             // Container(
//             //   height: 50,
//             //   padding: const EdgeInsets.symmetric(horizontal: 10),
//             //   decoration: BoxDecoration(
//             //     color: AppColors.grey100,
//             //     borderRadius: BorderRadius.circular(AppDimensions.radiusM),
//             //     border: Border.all(color: AppColors.grey200),
//             //   ),
//             //   child: Row(children: [
//             //     const Text('🇺🇸', style: TextStyle(fontSize: 18)),
//             //     const SizedBox(width: 4),
//             //     Icon(Icons.keyboard_arrow_down_rounded,
//             //         color: AppColors.grey600, size: 18),
//             //   ]),
//             // ),
//             // const SizedBox(width: 8),
//             Expanded(
//               child: TextFormField(
//                 keyboardType: TextInputType.phone,
//                 textInputAction: TextInputAction.done,
//                 onChanged: onChanged,
//                 style: NdisThemeStyle.bodyMedium
//                     .copyWith(color: AppColors.textPrimary),
//                 decoration: InputDecoration(
//                   hintText: '(454) 720-0592',
//                   hintStyle: NdisThemeStyle.bodyMedium
//                       .copyWith(color: AppColors.textHint),
//                   filled: true,
//                   fillColor: AppColors.grey100,
//                   contentPadding: const EdgeInsets.symmetric(
//                       horizontal: 16, vertical: 14),
//                   border: OutlineInputBorder(
//                     borderRadius:
//                         BorderRadius.circular(AppDimensions.radiusM),
//                     borderSide: BorderSide.none,
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius:
//                         BorderRadius.circular(AppDimensions.radiusM),
//                     borderSide: const BorderSide(color: AppColors.grey200),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius:
//                         BorderRadius.circular(AppDimensions.radiusM),
//                     borderSide: const BorderSide(
//                         color: AppColors.primary, width: 1.5),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
