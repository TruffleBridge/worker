import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/client_bloc/job_detail/job_detail_event.dart';
import '../../../../bloc/client_bloc/job_detail/job_detail_bloc.dart';
import '../../../../core/utils/app_dependencies.dart';
import '../../../../data/api/jobs/jobs_api_impl.dart';
import '../../../../domain/repositories/jobs/jobs_repository_impl.dart';
import '../../../views/client_views/job_detail/job_detail_view.dart';

class ClientJobDetailPage extends StatelessWidget {
  final int jobId;

  const ClientJobDetailPage({
    super.key,
    required this.jobId,
  });

  @override
  Widget build(BuildContext context) {
    final repository = JobsRepositoryImpl(
      jobsApi: JobsApiImpl(
        dio: AppDependencies.dio,
      ),
    );

    return BlocProvider(
      create: (_) => ClientJobDetailBloc(
        jobsRepository: repository,
      )..add(
        FetchClientJobDetailEvent(
          jobId: jobId,
          latitude: 13.0827,
          longitude: 80.2707,
        ),
      ),
      child: const ClientJobDetailView(),
    );
  }
}