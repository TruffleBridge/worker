import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';
import 'package:nimora_worker/routes/app_router.dart';

class ClientLoginWidget extends StatefulWidget {
  const ClientLoginWidget({super.key});

  @override
  State<ClientLoginWidget> createState() => _ClientLoginWidgetState();
}

class _ClientLoginWidgetState extends State<ClientLoginWidget> {
  final TextEditingController _phoneController = TextEditingController();

  bool _receiveWhatsappUpdates = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              top: 56,
              bottom: 28,
            ),
            decoration: const BoxDecoration(color: AppColors.primary),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 16,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                Text(
                  'Welcome!',
                  style: NdisThemeStyle.displayMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingL,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 26),

                  Text(
                    'Enter Mobile Number',
                    style: NdisThemeStyle.bodyMedium.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF6C7278),
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: AppColors.primary,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          value: _receiveWhatsappUpdates,
                          activeColor: AppColors.primary,
                          onChanged: (value) {
                            setState(() {
                              _receiveWhatsappUpdates = value ?? false;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Receive updates and reminders on Whatsapp',
                          style: NdisThemeStyle.bodyMedium.copyWith(
                            color: Color(0xFF364153),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 26),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Navigate to OTP Page
                        context.push(AppRoutes.clientOtpScreen);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Log In',
                        style: NdisThemeStyle.labelLarge.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  // const Spacer(),
                  SizedBox(height: 20),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: NdisThemeStyle.bodyMedium.copyWith(
                          color: Color(0xFF364153),
                          height: 1.5,
                        ),
                        children: [
                          const TextSpan(
                            text: 'By signing up, I agree to the ',
                          ),
                          TextSpan(
                            text: 'Terms of Service',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF364153),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          const TextSpan(text: ' and\n'),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF364153),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          const TextSpan(text: ' including usage of Cookies'),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
