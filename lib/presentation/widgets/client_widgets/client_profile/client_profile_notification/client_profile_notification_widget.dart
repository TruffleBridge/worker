import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../bloc/client_bloc/client_profile/client_profile_bloc.dart';
import '../../../../../bloc/client_bloc/client_profile/client_profile_event.dart';
import '../../../../../bloc/client_bloc/client_profile/client_profile_state.dart';


class ClientProfileNotificationWidget extends StatelessWidget {
  const ClientProfileNotificationWidget({super.key});

  static const Color primaryColor = Color(0xff0C8A7B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
          "Notifications",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Material(
              color: Colors.white,
              elevation: 3,
              shadowColor: Colors.black12,
              borderRadius: BorderRadius.circular(18),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _notificationTile(
                    context: context,
                    icon: Icons.chat_bubble_outline,
                    title: "New Messages",
                    subtitle: "Chat from workers and clients",
                    value: state.newMessages,
                    onChanged: (value) {
                      context.read<ProfileBloc>().add(
                        ToggleNewMessagesEvent(value),
                      );
                    },
                  ),

                  const Divider(height: 1),

                  _notificationTile(
                    context: context,
                    icon: Icons.work_outline,
                    title: "Job Updates",
                    subtitle: "Status changes and reminders",
                    value: state.jobUpdates,
                    onChanged: (value) {
                      context.read<ProfileBloc>().add(
                        ToggleJobUpdatesEvent(value),
                      );
                    },
                  ),

                  const Divider(height: 1),

                  _notificationTile(
                    context: context,
                    icon: Icons.credit_card_outlined,
                    title: "Payment Alerts",
                    subtitle: "Payment status notifications",
                    value: state.paymentAlerts,
                    onChanged: (value) {
                      context.read<ProfileBloc>().add(
                        TogglePaymentAlertsEvent(value),
                      );
                    },
                  ),

                  const Divider(height: 1),

                  _notificationTile(
                    context: context,
                    icon: Icons.description_outlined,
                    title: "Document Alerts",
                    subtitle: "Document upload notifications",
                    value: state.documentAlerts,
                    onChanged: (value) {
                      context.read<ProfileBloc>().add(
                        ToggleDocumentAlertsEvent(value),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _notificationTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14,
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: const Color(0xffEAF7F5),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: primaryColor,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            activeColor: Colors.white,
            activeTrackColor: primaryColor,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey.shade300,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}