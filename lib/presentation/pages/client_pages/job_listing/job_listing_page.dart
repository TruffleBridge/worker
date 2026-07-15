import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimora_worker/core/utils/app_dependencies.dart';
import 'package:nimora_worker/presentation/views/client_views/job_listing/job_listing_view.dart';

import '../../../../bloc/client_bloc/job_lisiting/job_listing_bloc.dart';
import '../../../../data/api/jobs/jobs_api_impl.dart';
import '../../../../domain/repositories/jobs/jobs_repository_impl.dart';


class JobListingPage extends StatelessWidget {
  const JobListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = JobsRepositoryImpl(
      jobsApi: JobsApiImpl(
        dio: AppDependencies.dio,
      ),
    );

    return BlocProvider(
      create: (_) => MyJobsListBloc(
        jobsRepository: repository,
      ),
      child: const JobListingView(),
    );
  }
}