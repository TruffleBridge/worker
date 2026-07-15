import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimora_worker/bloc/worker_bloc/notifications/notifications_bloc.dart';
import '../../../widgets/worker_widgets/notifications/notifications_card.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationBloc, NotificationState>(
      listenWhen: (previous, current) {
        return previous.successMessage != current.successMessage ||
            previous.errorMessage != current.errorMessage;
      },
      listener: (context, state) {
        if (state.successMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.successMessage!,
              ),
            ),
          );
        }

        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage!,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF9FAFB),
          appBar: AppBar(
            backgroundColor: const Color(0xFFF3F4F6),
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 18,
              ),
            ),
            title: const Text(
              'Notifications',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<NotificationBloc>().add(
                const NotificationRequested(),
              );
            },
            child: _buildBody(
              context,
              state,
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(
      BuildContext context,
      NotificationState state,
      ) {
    if (state.isLoading && state.notifications.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state.notifications.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          SizedBox(
            height: 250,
          ),
          Center(
            child: Text(
              'No notifications',
            ),
          ),
        ],
      );
    }

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'NEW REQUEST',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        ...state.notifications.map(
              (notification) {
            final jobId = notification.id;
            final workerId = 2;

            final isUpdating = state.isUpdating &&
                state.updatingJobId == jobId;

            return Padding(
              padding: const EdgeInsets.only(
                bottom: 14,
              ),
              child: NotificationCard(
                notification: notification,
                isUpdating: isUpdating,
                onApprove: jobId == null || workerId == null
                    ? null
                    : () {
                  context.read<NotificationBloc>().add(
                    NotificationBookingApproved(
                      jobId: jobId,
                      workerId: workerId,
                    ),
                  );
                },
                onDecline: jobId == null || workerId == null
                    ? null
                    : () {
                  context.read<NotificationBloc>().add(
                    NotificationBookingDeclined(
                      jobId: jobId,
                      workerId: workerId,
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}


