import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nimora_worker/bloc/worker_bloc/jobs/jobs_bloc.dart';
import 'package:nimora_worker/core/constants/nimora_colors.dart';
import 'package:nimora_worker/core/enums/job_badge.dart';
import 'package:nimora_worker/core/utils/string_extensions.dart';
import 'package:nimora_worker/domain/model/response/job_detail_response_model.dart';
import 'package:nimora_worker/routes/app_router.dart';
import '../../../../core/theme/app_theme.dart';

class JobDetailPage extends StatefulWidget {
  final JobDetailResponseModel job;

  const JobDetailPage({super.key, required this.job});

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobsBloc, JobsState>(
      listener: (context, state) {
        if (state is JobAppliedSuccessState) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(
          //     content: Text('Job applied successfully'),
          //   ),
          // );
        } else if (state is JobAppliedErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      },
      builder: (context, state) {
        JobDetailResponseModel job = widget.job;

        if (state is JobsDetailsOnLoadedState) {
          job = state.response;
        } else if (state is JobAppliedLoadingState) {
          job = state.jobDetail;
        } else if (state is JobAppliedSuccessState) {
          job = state.jobDetail;
        } else if (state is JobAppliedErrorState) {
          job = state.jobDetail;
        }

        final bool isApplying = state is JobAppliedLoadingState;
        final bool isApplied = state is JobAppliedSuccessState;

        final category = job.data?.job?.category ?? '';

        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: const Color(0xFFE0E0E0),
            elevation: 0,
            surfaceTintColor: Colors.white,
            leadingWidth: 72,
            leading: Padding(
              padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
              child: GestureDetector(
                onTap: () {
                  context.push(AppRoutes.home);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF3F4F6),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 18,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
            title: Text(
              'Jobs',
              style: NdisThemeStyle.displayLarge.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 8, bottom: 8),
                child: GestureDetector(
                  onTap: () {},
                  child: const SizedBox(
                    width: 42,
                    height: 42,
                    child: Icon(
                      Icons.share_outlined,
                      size: 20,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              // BODY
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (category.isNotEmpty)
                            Wrap(
                              spacing: 8,
                              children: [
                                _BadgeChip(
                                  label: category,
                                  color: NimoraColors.jobBadgeDefaultColor,
                                ),
                              ],
                            ),
                          const Spacer(),
                          Text(
                            '\$${job.data?.job?.hourlyRate?.toStringAsFixed(2)}/hr',
                            style: const TextStyle(
                              color: NimoraColors.hourlyRateColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      Text(
                        'Job #: ${job.data?.job?.id}',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        job.data?.job?.title ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: NimoraColors.titleColor,
                        ),
                      ),

                      const SizedBox(height: 16),

                      _metaRow(
                        Icons.location_on_outlined,
                        '${job.data?.location?.first.city},${job.data?.location?.first.state} • ${job.data?.location?.first.distanceKm} away',
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          _metaRow(
                            Icons.schedule_outlined,
                            'Posted ${getPostedAgo(job.data?.job?.createdAt)}',
                          ),
                          const SizedBox(width: 16),
                          _metaRow(
                            Icons.people_outline_rounded,
                            '${job.data?.job?.applicationCount} applications',
                            color: NimoraColors.applicantsColor,
                          ),
                        ],
                      ),

                      const SizedBox(height: 28),

                      const Text(
                        'Client Information',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: NimoraColors.titleColor,
                        ),
                      ),

                      const SizedBox(height: 14),

                      _ClientCard(job: job),

                      const SizedBox(height: 24),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.grey200),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 12,
                              ),
                              decoration: const BoxDecoration(
                                color: NimoraColors.moreContainerHeaderBgColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(14),
                                  topRight: Radius.circular(14),
                                ),
                              ),
                              child: const Text(
                                'Service Requirements',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                            if (job.data?.jobRequirements?.serviceRequirement !=
                                null)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: _RequirementTile(
                                  text: job
                                      .data!
                                      .jobRequirements!
                                      .serviceRequirement!,
                                ),
                              ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      _SessionsCard(job: job),

                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ),

              // BOTTOM BUTTON
              Container(
                padding: EdgeInsets.fromLTRB(
                  20,
                  16,
                  20,
                  MediaQuery.of(context).padding.bottom + 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 20,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    if (isApplied) ...[
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: NimoraColors.jobAppliedContainerBgColor,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: NimoraColors.jobAppliedContainerBorderColor,
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color:
                              NimoraColors.jobAppliedContainerBorderColor,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Job applied successfully',
                              style: TextStyle(
                                color: NimoraColors.hourlyRateColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                    ],
                    if(!isApplied)
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: isApplying || isApplied
                            ? null
                            : () {
                          final jobId = job.data?.job?.id;
                          if (jobId != null) {
                            context.read<JobsBloc>().add(
                              JobAppliedEvent(jobId),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          disabledBackgroundColor: AppColors.primary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          isApplying
                              ? 'Applying...'
                              : isApplied
                              ? 'Applied'
                              : 'Apply Now',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _metaRow(IconData icon, String text, {Color? color}) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade500),
        const SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
            color: color ?? NimoraColors.titleColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  String _badgeLabel(JobBadge badge) {
    switch (badge) {
      case JobBadge.ndis:
        return 'NDIS';
      case JobBadge.agedCare:
        return 'Aged';
      case JobBadge.disability:
        return 'Disability';
      case JobBadge.mentalHealth:
        return 'Mental Health';
      case JobBadge.urgent:
        return 'Urgent';
    }
  }

  Color _badgeColor(JobBadge badge) {
    switch (badge) {
      case JobBadge.urgent:
        return NimoraColors.jobBadgeUrgentColor;
      default:
        return NimoraColors.jobBadgeDefaultColor;
    }
  }
}

class _ClientCard extends StatelessWidget {
  final JobDetailResponseModel job;

  const _ClientCard({required this.job});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              job.data?.postedBy?.user?.profilePicture?.isNotEmpty == true
                  ? job.data?.postedBy?.user?.profilePicture ?? ''
                  : 'https://i.pravatar.cc/100',
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 60,
                height: 60,
                color: const Color(0xFFF3F5F7),
                child: const Icon(Icons.person, size: 32, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${job.data?.postedBy?.user?.firstName} ${job.data?.postedBy?.user?.lastName}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${job.data?.sessions?.first.startTime} - ${job.data?.sessions?.first.endTime}',
                  style: const TextStyle(
                    color: NimoraColors.jobClientScheduleColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${job.data?.location?.first.city},${job.data?.location?.first.state} • ${job.data?.location?.first.distanceKm} away',
                  style: const TextStyle(
                    color: NimoraColors.jobClientSubtitleColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Image.asset('assets/images/phone_vector.png'),
          ),
        ],
      ),
    );
  }
}

class _RequirementTile extends StatelessWidget {
  final String text;

  const _RequirementTile({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/circular_tick.jpg', fit: BoxFit.cover),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: NimoraColors.moreTitleColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SessionsCard extends StatelessWidget {
  final JobDetailResponseModel job;

  const _SessionsCard({required this.job});

  @override
  Widget build(BuildContext context) {
    final sessions = job.data?.sessions ?? [];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Sessions',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: NimoraColors.titleColor,
                ),
              ),
              const Spacer(),
              Text(
                '${sessions.length} session${sessions.length == 1 ? '' : 's'}',
                style: const TextStyle(
                  color: NimoraColors.subtitleColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          if (sessions.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'No sessions scheduled.',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            )
          else
            ...sessions.asMap().entries.map((entry) {
              final index = entry.key;
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index < sessions.length - 1 ? 12 : 0,
                ),
                child: _sessionTile(
                  index: index + 1,
                  time:
                  '${job.data?.sessions?.first.startTime} - ${job.data?.sessions?.first.endTime}',
                  dateRange: '',
                ),
              );
            }),
        ],
      ),
    );
  }

  Widget _sessionTile({
    required int index,
    required String time,
    required String dateRange,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: NimoraColors.jobSessionBlueColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF2650FC),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Session $index',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: NimoraColors.titleColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  time,
                  style: const TextStyle(
                    color: NimoraColors.jobClientSubtitleColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  dateRange,
                  style: const TextStyle(
                    color: NimoraColors.jobClientSubtitleColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BadgeChip extends StatelessWidget {
  final String label;
  final Color color;

  const _BadgeChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 11,
        ),
      ),
    );
  }
}