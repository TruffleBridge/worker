import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/client_bloc/client_profile/client_profile_bloc.dart';
import '../../../../../bloc/client_bloc/client_profile/client_profile_event.dart';
import '../../../../../bloc/client_bloc/client_profile/client_profile_state.dart';

class ChangePasswordWidget extends StatefulWidget {
  const ChangePasswordWidget({super.key});

  @override
  State<ChangePasswordWidget> createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  static const Color primaryColor = Color(0xff0C8A7B);

  bool hideCurrent = true;
  bool hideNew = true;
  bool hideConfirm = true;

  final currentController = TextEditingController();
  final newController = TextEditingController();
  final confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.passwordError.isNotEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.passwordError)));
        }

        if (state.passwordSuccess.isNotEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.passwordSuccess)));

          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xffF7F8FA),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            surfaceTintColor: Colors.white,
            leadingWidth: 70,
            leading: Center(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Color(0xffF1F3F5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 18,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            title: const Text(
              "Change Password",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.06),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _title("Current Password"),
                  const SizedBox(height: 8),

                  _passwordField(
                    controller: currentController,
                    obscure: hideCurrent,
                    onToggle: () {
                      setState(() {
                        hideCurrent = !hideCurrent;
                      });
                    },
                    hint: "",
                  ),

                  const SizedBox(height: 20),

                  _title("New Password"),
                  const SizedBox(height: 8),

                  _passwordField(
                    controller: newController,
                    obscure: hideNew,
                    onToggle: () {
                      setState(() {
                        hideNew = !hideNew;
                      });
                    },
                    hint: "",
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    "Medium Strength",
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 6),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: .65,
                      minHeight: 4,
                      backgroundColor: Color(0xffE5E7EB),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.orange,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  _title("Confirm New Password"),
                  const SizedBox(height: 8),

                  _passwordField(
                    controller: confirmController,
                    obscure: hideConfirm,
                    onToggle: () {
                      setState(() {
                        hideConfirm = !hideConfirm;
                      });
                    },
                    hint: "",
                  ),

                  const SizedBox(height: 20),

                  _rule(true, "8+ characters"),
                  _rule(true, "Uppercase letter"),
                  _rule(true, "Number"),
                  _rule(false, "Special character"),

                  const SizedBox(height: 28),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: state.passwordUpdating
                          ? null
                          : () {
                        context.read<ProfileBloc>().add(
                          UpdatePasswordEvent(
                            currentPassword: currentController.text,
                            newPassword: newController.text,
                            confirmPassword: confirmController.text,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child:state.passwordUpdating
                          ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                          : const Text(
                        "Update Password",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _title(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xff64748B),
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _passwordField({
    required TextEditingController controller,
    required bool obscure,
    required VoidCallback onToggle,
    required String hint,
  }) {
    return SizedBox(
      height: 48,
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hint.isEmpty ? null : hint,
          hintStyle: const TextStyle(color: Color(0xff94A3B8)),
          filled: true,
          fillColor: const Color(0xffF8FAFC),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
          suffixIcon: IconButton(
            onPressed: onToggle,
            icon: Icon(
              obscure
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: const Color(0xff94A3B8),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xffE5E7EB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primaryColor),
          ),
        ),
      ),
    );
  }

  Widget _rule(bool completed, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            completed ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 16,
            color: completed ? const Color(0xffA7D8C5) : Colors.grey.shade400,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}
