import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimora_worker/bloc/worker_bloc/notifications/notifications_bloc.dart';
import 'package:nimora_worker/core/utils/app_dependencies.dart';
import 'package:nimora_worker/data/api/jobs/jobs_api_impl.dart';
import 'package:nimora_worker/data/api/notifications/notifications_api_impl.dart';
import 'package:nimora_worker/domain/repositories/jobs/jobs_repository_impl.dart';
import 'package:nimora_worker/domain/repositories/notifications/notifications_repository_impl.dart';
import 'package:nimora_worker/presentation/views/worker_views/notifications/notifications_view.dart';

class WorkerNotificationsPage extends StatelessWidget {
  const WorkerNotificationsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotificationBloc(
        notificationRepository: NotificationRepositoryImpl(
          notificationApi: NotificationApiImpl(
            dio: AppDependencies.dio,
          ),
        ),
        jobsRepository: JobsRepositoryImpl(
          jobsApi: JobsApiImpl(
            dio: AppDependencies.dio,
          ),
        ),
      )..add(
        const NotificationRequested(),
      ),
      child: const NotificationsView(),
    );
  }
}