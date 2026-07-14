import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/client_profile/client_profile_account_settings/change_password_widget.dart';

import '../../../../../bloc/client_bloc/client_profile/client_profile_bloc.dart';
import '../../../../../bloc/client_bloc/client_profile/client_profile_event.dart';
import '../../../../../bloc/client_bloc/client_profile/client_profile_state.dart';


class ClientProfileAccountSettingsWidget extends StatefulWidget {
  const ClientProfileAccountSettingsWidget({super.key});

  @override
  State<ClientProfileAccountSettingsWidget> createState() =>
      _ClientProfileAccountSettingsWidgetState();
}

class _ClientProfileAccountSettingsWidgetState
    extends State<ClientProfileAccountSettingsWidget> {
  static const Color primaryColor = Color(0xff0C8A7B);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
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
              "Account",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [

                /// Profile Image
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.08),
                            blurRadius: 10,
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage(state.profileImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 2,
                      right: -2,
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                /// Personal Information
                _sectionCard(
                  title: "Personal Information",
                  child: Column(
                    children: [
                      _infoTile(
                        context,
                        title: "Full Name",
                        value: state.name,
                        field: "name",
                      ),

                      _divider(),

                      _infoTile(
                        context,
                        title: "Email Address",
                        value: state.email,
                        field: "email",
                      ),

                      _divider(),

                      _infoTile(
                        context,
                        title: "Phone Number",
                        value: state.phone,
                        field: "phoneNumber",
                      ),

                      _divider(),

                      _infoTile(
                        context,
                        title: "Date of Birth",
                        value: state.dob,
                        field: "dateOfBirth",
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                /// Security Card
                /// Security Card
                _sectionCard(
                  title: "Security",
                  child: Column(
                    children: [
                      _menuTile(
                        icon: Icons.lock_outline,
                        title: "Change Password",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  BlocProvider.value(
                                    value: context.read<ProfileBloc>(),
                                    child: const ChangePasswordWidget(),
                                  ),
                            ),
                          );
                        },
                      ),

                      _divider(),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xffEAF7F5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.info_outline,
                                color: primaryColor,
                                size: 20,
                              ),
                            ),

                            const SizedBox(width: 14),

                            const Expanded(
                              child: Text(
                                "Two-Factor Authentication",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),

                            CupertinoSwitch(
                              value: state.twoFactorEnabled,
                              activeColor: primaryColor,
                              onChanged: (value) {
                                context.read<ProfileBloc>().add(
                                  ToggleTwoFactorEvent(value),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                /// Privacy & Data Card
                _sectionCard(
                  title: "Privacy & Data",
                  child: Column(
                    children: [
                      _menuTile(
                        icon: Icons.shield_outlined,
                        title: "Privacy Settings",
                        onTap: () {},
                      ),

                      _divider(),

                      _menuTile(
                        icon: Icons.download_outlined,
                        title: "Download My Data",
                        onTap: () {},
                      ),

                      _divider(),

                      _menuTile(
                        icon: Icons.warning_amber_rounded,
                        title: "Delete Account",
                        titleColor: Colors.red,
                        iconColor: Colors.red,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _sectionCard({
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xff3A3A3A),
                ),
              ),
            ),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }

  Widget _infoTile(BuildContext context, {
    required String title,
    required String value,
    required String field,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xff3A3A3A),
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xff94A3B8),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              _showEditDialog(
                context,
                title,
                field,
                value,
              );
            },
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: const Color(0xffF5F7FA),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.mode_edit_outlined,
                size: 18,
                color: Color(0xff94A3B8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context,
      String title,
      String field,
      String currentValue,) {
    final controller = TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Text(
            "Edit $title",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: primaryColor,
                          width: 1.5,
                        ),
                        foregroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<ProfileBloc>().add(
                          UpdatePersonalInformationFieldEvent(
                            field: field,
                            value: controller.text.trim(),
                          ),
                        );

                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Save",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _divider() {
    return const Divider(
      height: 1,
      color: Color(0xffECECEC),
      indent: 16,
      endIndent: 16,
    );
  }

  Widget _menuTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color iconColor = primaryColor,
    Color titleColor = Colors.black87,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: title == "Delete Account"
                    ? const Color(0xffFEECEC)
                    : const Color(0xffEAF7F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: titleColor,
                ),
              ),
            ),

            if (title != "Delete Account")
              const Icon(
                Icons.chevron_right,
                color: Color(0xff94A3B8),
              ),
          ],
        ),
      ),
    );
  }
}