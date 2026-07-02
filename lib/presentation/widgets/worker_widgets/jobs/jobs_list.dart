import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nimora_worker/bloc/worker_bloc/jobs/jobs_bloc.dart';
import 'package:nimora_worker/core/constants/nimora_colors.dart';
import 'package:nimora_worker/core/enums/job_tab.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';
import 'package:nimora_worker/domain/model/view_model/job.dart';
import 'package:nimora_worker/presentation/widgets/worker_widgets/jobs/job_card.dart';

class JobsList extends StatelessWidget {
  final List<Job> jobs;
  final int total;
  final JobsTab selectedTab;

  const JobsList({
    super.key,
    required this.jobs,
    required this.total,
    required this.selectedTab,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      itemCount: jobs.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tabs + Filter
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F5F7),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          // All Jobs
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                context.read<JobsBloc>().add(
                                  const JobsTabChanged(JobsTab.allJobs),
                                );
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                decoration: BoxDecoration(
                                  color: selectedTab == JobsTab.allJobs
                                      ? AppColors.primary
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(26),
                                  boxShadow: selectedTab == JobsTab.allJobs
                                      ? [
                                          BoxShadow(
                                            color: AppColors.primary.withValues(
                                              alpha: 0.18,
                                            ),
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          ),
                                        ]
                                      : null,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'All Jobs',
                                  style: TextStyle(
                                    color: selectedTab == JobsTab.allJobs
                                        ? NimoraColors.jobTabWhiteTitleColor
                                        : AppColors.textPrimary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Job Tracker
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                // context.read<JobsBloc>().add(
                                //   const JobsTabChanged(JobsTab.tracker),
                                // );
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                decoration: BoxDecoration(
                                  color: selectedTab == JobsTab.tracker
                                      ? AppColors.primary
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(26),
                                  boxShadow: selectedTab == JobsTab.tracker
                                      ? [
                                          BoxShadow(
                                            color: AppColors.primary.withValues(
                                              alpha: 0.18,
                                            ),
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          ),
                                        ]
                                      : null,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Job Tracker',
                                  style: TextStyle(
                                    color: selectedTab == JobsTab.tracker
                                        ? NimoraColors.jobTabWhiteTitleColor
                                        : AppColors.textPrimary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: NimoraColors.jobTabWhiteTitleColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/images/filter_icon.svg',
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Total + Distance
              Row(
                children: [
                  Text(
                    'Total Jobs - $total',
                    style: NdisThemeStyle.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  const Spacer(),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: AppColors.grey200),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Distance : 5 km',
                          style: NdisThemeStyle.bodyMedium.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(width: 4),

                        const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),
            ],
          );
        }

        final job = jobs[index - 1];

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: JobCard(
            job: job,

            // isTracker:
            // selectedTab ==
            //     JobsTab.tracker,
            onTap: () {
              context.read<JobsBloc>().add(
                JobDetailRequested(job.id, 13.0827, 80.2707),
              );
            },
            onSave: () {
              context.read<JobsBloc>().add(JobSaveToggled(job.id));
            },
          ),
        );
      },
    );
  }
}
