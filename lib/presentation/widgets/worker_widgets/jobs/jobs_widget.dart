import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimora_worker/bloc/worker_bloc/jobs/jobs_bloc.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';
import 'package:nimora_worker/presentation/pages/worker_pages/jobs/job_detail_page.dart';
import 'package:nimora_worker/presentation/widgets/components/home_app_bar.dart';
import 'package:nimora_worker/presentation/widgets/worker_widgets/jobs/empty_state.dart';
import 'package:nimora_worker/presentation/widgets/worker_widgets/jobs/jobs_list.dart';

class JobsWidget extends StatelessWidget {
  const JobsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const HomeAppBar(),
      body: BlocConsumer<JobsBloc, JobsState>(
        listener: (context, state) {
          if (state is JobsDetailsOnLoadedState) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<JobsBloc>(),
                  child: JobDetailPage(job: state.response),
                ),
              ),
            );
          } else if (state is JobsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is JobsLoading || state is JobsInitial) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state is JobDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state is JobsError) {
            return Center(child: Text(state.message));
          }

          if (state is JobsSuccess) {
            if (state.filteredJobs.isEmpty) {
              return const EmptyState();
            }

            return JobsList(
              jobs: state.filteredJobs,
              total: state.jobs.length,
              selectedTab: state.selectedTab,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
