import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimora_worker/bloc/client_bloc/job_post/job_post_bloc.dart';
import 'package:nimora_worker/core/utils/app_dependencies.dart';
import 'package:nimora_worker/data/api/job_post/job_post_api_impl.dart';
import 'package:nimora_worker/domain/repositories/job_post/job_post_repository_impl.dart';
import 'package:nimora_worker/presentation/views/client_views/job_post/job_post_view.dart';

class JobPostPage extends StatelessWidget {
  const JobPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final jobPostApi = JobPostApiImpl(dio: AppDependencies.dio);
    final jobPostRepository = JobPostRepositoryImpl(jobPostApi: jobPostApi);
    return BlocProvider(
      create: (context) =>
          JobPostBloc(jobPostRepository: jobPostRepository)
            ..add(const JobPostOnLoadedEvent()),
      child: const JobPostView(),
    );
  }
}
