import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimora_worker/core/utils/app_dependencies.dart';

import '../../../bloc/client_bloc/job_lisiting/job_listing_bloc.dart';
import '../../../data/api/jobs/jobs_api_impl.dart';
import '../../../domain/repositories/jobs/jobs_repository_impl.dart';
import '../../widgets/client_widgets/job_listing/job_listing_widget.dart';

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
      child: const JobListingWidget(),
    );
  }
}