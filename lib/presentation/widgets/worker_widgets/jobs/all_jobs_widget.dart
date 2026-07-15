import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimora_worker/bloc/worker_bloc/jobs/jobs_bloc.dart';
import 'package:nimora_worker/domain/model/view_model/job.dart';
import 'package:nimora_worker/presentation/widgets/worker_widgets/jobs/job_card.dart';

class AllJobsListView extends StatelessWidget {
  final List<Job> jobs;

  const AllJobsListView({super.key, required this.jobs});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      itemCount: jobs.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final job = jobs[index];

        return AllJobsCard(
          job: job,
          onTap: () {
            context.read<JobsBloc>().add(
              JobDetailRequested(job.id, 13.0827, 80.2707),
            );
          },
          onSave: () {
            context.read<JobsBloc>().add(JobSaveToggled(job.id));
          },
        );
      },
    );
  }
}
