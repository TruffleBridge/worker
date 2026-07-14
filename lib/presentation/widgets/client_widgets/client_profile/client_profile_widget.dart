import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/client_profile/client_profile_account_settings/client_profile_account_settings_widget.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/client_profile/client_profile_documents/client_profile_documents_widget.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/client_profile/client_profile_help_&_support/help_and_support_widget.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/client_profile/client_profile_notification/client_profile_notification_widget.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/client_profile/profile_menu_item.dart';

import '../../../../bloc/client_bloc/client_profile/client_profile_bloc.dart';
import '../../../../bloc/client_bloc/client_profile/client_profile_event.dart';
import '../../../../bloc/client_bloc/client_profile/client_profile_state.dart';
import 'client_profile_payment/client_profile_payment_widget.dart';

class ClientProfileWidget extends StatelessWidget {
  const ClientProfileWidget({super.key});

  static const Color primaryColor = Color(0xff0C8A7B);
  static const Color bgColor = Color(0xffF7F8FA);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: bgColor,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "My Profile",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 20),

                  _buildProfileCard(context, state),

                  const SizedBox(height: 22),

                  Material(
                    color: Colors.white,
                    elevation: 2,
                    shadowColor: Colors.black12,
                    borderRadius: BorderRadius.circular(22),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        ProfileMenuItem(
                          icon: Icons.credit_card_outlined,
                          title: "Payment Methods",
                          subtitle:
                          "${state.paymentCards.length} card(s) saved",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: context.read<ProfileBloc>(),
                                  child: const ClientProfilePaymentWidget(),
                                ),
                              ),
                            );
                          },
                        ),

                        const Divider(height: 1),

                        ProfileMenuItem(
                          icon: Icons.notifications_none,
                          title: "Notifications",
                          subtitle: "Manage notifications",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: context.read<ProfileBloc>(),
                                  child: const ClientProfileNotificationWidget(),
                                ),
                              ),
                            );
                          },
                        ),

                        const Divider(height: 1),

                        ProfileMenuItem(
                          icon: Icons.shield_outlined,
                          title: "NDIS Documents",
                          subtitle:
                          "${state.documents.length} document(s) uploaded",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: context.read<ProfileBloc>(),
                                  child: const ClientProfileDocumentsWidget(),
                                ),
                              ),
                            );
                          },
                        ),

                        const Divider(height: 1),

                        ProfileMenuItem(
                          icon: Icons.help_outline,
                          title: "Help & Support",
                          subtitle: "FAQ, Chat with us",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                const HelpAndSupportWidget(),
                              ),
                            );
                          },
                        ),

                        const Divider(height: 1),

                        ProfileMenuItem(
                          icon: Icons.settings_outlined,
                          title: "Account Settings",
                          subtitle: "Privacy, Security",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: context.read<ProfileBloc>(),
                                  child: const ClientProfileAccountSettingsWidget(),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        context.read<ProfileBloc>().add(
                          SignOutEvent(),
                        );
                      },
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      label: const Text(
                        "Sign Out",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: Colors.red.shade200,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Center(
                    child: Column(
                      children: [
                        const Text(
                          "Nimora v1.0",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            "Privacy Policy",
                            style: TextStyle(
                              color: primaryColor,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildProfileCard(
      BuildContext context,
      ProfileState state,
      ) {
    return Material(
      color: Colors.white,
      elevation: 2,
      borderRadius: BorderRadius.circular(22),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 34,
                  backgroundImage: AssetImage(
                    state.profileImage,
                  ),
                ),

                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "NDIS Participant • ${state.location}",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "NDIS Verified",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      const Icon(
                        Icons.verified,
                        color: primaryColor,
                        size: 18,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
