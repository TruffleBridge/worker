import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimora_worker/bloc/worker_bloc/notifications/notifications_bloc.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';
import 'package:nimora_worker/presentation/widgets/worker_widgets/notifications/notifications_card.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationBloc, NotificationState>(
      listenWhen: (previous, current) {
        return previous.successMessage != current.successMessage ||
            previous.errorMessage != current.errorMessage;
      },
      listener: (context, state) {
        final successMessage = state.successMessage;
        final errorMessage = state.errorMessage;

        if (successMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(successMessage)));
        }

        if (errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(errorMessage)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF9FAFB),
          appBar: AppBar(
            backgroundColor: const Color(0xFFF3F4F6),
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: AppColors.textPrimary,
              ),
            ),
            title: Text(
              'Notifications',
              style: NdisThemeStyle.headlineMedium.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<NotificationBloc>().add(
                  const NotificationRequested(),
                );
              },
              child: _buildBody(context, state),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, NotificationState state) {
    if (state.isLoading && state.notifications.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.notifications.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          SizedBox(height: 250),
          Center(
            child: Text(
              'No notifications',
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      );
    }

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      children: [
        Text(
          'NEW REQUEST',
          style: NdisThemeStyle.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        ...state.notifications.map((notification) {
          final jobId = notification.id;
          final clientId = notification.clientId;

          // TODO: Replace with actual logged-in worker ID.
          const workerId = 2;

          final isUpdating = state.isUpdating && state.updatingJobId == jobId;

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: NotificationCard(
              notification: notification,
              isUpdating: isUpdating,
              onApprove: jobId == null
                  ? null
                  : () {
                      context.read<NotificationBloc>().add(
                        NotificationBookingApproved(
                          jobId: jobId,
                          workerId: workerId,
                          clientId: clientId ?? 0,
                        ),
                      );
                    },
              onDecline: jobId == null
                  ? null
                  : () {
                      context.read<NotificationBloc>().add(
                        NotificationBookingDeclined(
                          jobId: jobId,
                          workerId: workerId,
                          clientId: clientId ?? 0,
                        ),
                      );
                    },
            ),
          );
        }),
      ],
    );
  }
}
