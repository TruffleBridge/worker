import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nimora_worker/bloc/client_bloc/job_detail/job_detail_bloc.dart';
import 'package:nimora_worker/bloc/client_bloc/job_detail/job_detail_event.dart';
import 'package:nimora_worker/bloc/client_bloc/job_detail/job_detail_state.dart';
import 'package:nimora_worker/domain/model/response/job_detail/job_detail_response_model.dart';

class JobDetailWidget extends StatefulWidget {
  const JobDetailWidget({super.key});

  @override
  State<JobDetailWidget> createState() => _JobDetailWidgetState();
}

class _JobDetailWidgetState extends State<JobDetailWidget> {
  static const Color _bg = Color(0xFFF9FAFB);
  static const Color _secondary = Color(0xFF706767);
  static const Color _border = Color(0xFFE5E7EB);
  static const Color _linkBlue = Color(0xFF3B82F6);
  static const Color _priceGreen = Color(0xFF00A63E);
  static const Color _editGreen = Color(0xFF336B5F);
  static const Color _closeRed = Color(0xFFD14343);
  static const Color _sessionAccent = Color(0xFF2650FC);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClientJobDetailBloc, ClientJobDetailState>(
      listener: (context, state) {
        if (state is ClientBookingStatusUpdateSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }

        if (state is ClientBookingStatusUpdateFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is ClientJobDetailLoading) {
          return const Scaffold(
            backgroundColor: _bg,
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is ClientJobDetailError) {
          return Scaffold(
            backgroundColor: _bg,
            body: Center(child: Text(state.message)),
          );
        }

        ClientJobDetailResponseModel? response;

        if (state is ClientJobDetailLoaded) {
          response = state.response;
        } else if (state is ClientBookingStatusUpdating) {
          response = state.response;
        } else if (state is ClientBookingStatusUpdateSuccess) {
          response = state.response;
        } else if (state is ClientBookingStatusUpdateFailure) {
          response = state.response;
        }

        if (response == null) {
          return const Scaffold(backgroundColor: _bg, body: SizedBox());
        }

        final applicants =
            response.data?.applicants?.items ?? <ApplicantModel>[];

        final serviceRequirements = response.data?.serviceRequirements ?? [];

        final job = response.data?.job;

        final location = response.data?.location;

        final sessions = response.data?.sessionItems ?? <SessionModel>[];

        final firstApplicant = applicants.isNotEmpty ? applicants.first : null;

        final applicantCount = applicants.length;

        final applicantCountText = applicantCount > 10
            ? '10+ applicants'
            : '$applicantCount applicants';

        return Scaffold(
          backgroundColor: _bg,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'Job Details',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF101828),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Job #: ${job?.id ?? ''}',
                    style: const TextStyle(fontSize: 18, color: _secondary),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    job?.title ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1C1B1D),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _meta(
                    Icons.location_on_outlined,
                    '${location?.street1 ?? ''}, '
                    '${location?.city ?? ''}',
                  ),
                  const SizedBox(height: 6),
                  _meta(Icons.access_time, job?.postedTime ?? ''),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ...job?.tags
                              .map(
                                (tag) => _tag(
                                  tag,
                                  const Color(0xFFF2F2F2),
                                  Colors.black,
                                ),
                              )
                              .toList() ??
                          [],
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage:
                            firstApplicant?.profilePicture != null &&
                                firstApplicant!.profilePicture!.isNotEmpty
                            ? NetworkImage(firstApplicant.profilePicture!)
                            : null,
                        child: firstApplicant == null
                            ? const Icon(
                                Icons.person,
                                color: Colors.grey,
                                size: 20,
                              )
                            : firstApplicant.profilePicture == null ||
                                  firstApplicant.profilePicture!.isEmpty
                            ? Text(
                                _getInitials(firstApplicant.fullName),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          applicantCountText,
                          style: const TextStyle(
                            color: _linkBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        '₹${job?.hourlyRate ?? ''}/hr',
                        style: const TextStyle(
                          color: _priceGreen,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Sessions',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color(0xFF101828),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${sessions.length} Sessions',
                              style: const TextStyle(
                                color: Color(0xFF6A7282),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Column(
                          children: sessions.map((session) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _session(
                                session.startDate ?? '',
                                '${session.startTime ?? ''} - '
                                '${session.endTime ?? ''}',
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Service Requirements',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color(0xFF101828),
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (serviceRequirements.isNotEmpty)
                          ...serviceRequirements.map(
                            (requirement) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/circular_tick.svg',
                                    width: 22,
                                    height: 22,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      requirement,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF364153),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else
                          const Text(
                            'No service requirements available',
                            style: TextStyle(color: Colors.grey),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Applicants - ${applicants.length}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color(0xFF101828),
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (applicants.isEmpty)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                'No applicants yet',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          )
                        else
                          ListView.builder(
                            itemCount: applicants.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final applicant = applicants[index];

                              final workerId = applicant.userId;

                              final isBooking =
                                  state is ClientBookingStatusUpdating &&
                                  state.workerId == workerId;

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(color: _border),
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 28,
                                        backgroundColor: Colors.grey.shade300,
                                        backgroundImage:
                                            applicant.profilePicture != null &&
                                                applicant
                                                    .profilePicture!
                                                    .isNotEmpty
                                            ? NetworkImage(
                                                applicant.profilePicture!,
                                              )
                                            : null,
                                        child:
                                            applicant.profilePicture == null ||
                                                applicant
                                                    .profilePicture!
                                                    .isEmpty
                                            ? Text(
                                                _getInitials(
                                                  applicant.fullName,
                                                ),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  color: Color(0xFF000000),
                                                ),
                                              )
                                            : null,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              applicant.fullName ??
                                                  'Unknown Applicant',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: Color(0xFF000000),
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              applicant
                                                      .applicationStatus
                                                      ?.name ??
                                                  'Application Submitted',
                                              style: const TextStyle(
                                                color: Color(0xFF43474E),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: isBooking
                                            ? null
                                            : () {
                                                final jobId = job?.id;

                                                if (jobId == null ||
                                                    workerId == null) {
                                                  ScaffoldMessenger.of(
                                                    context,
                                                  ).showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                        'Job ID or Worker ID not found',
                                                      ),
                                                    ),
                                                  );

                                                  return;
                                                }

                                                context
                                                    .read<ClientJobDetailBloc>()
                                                    .add(
                                                      ClientBookingStatusUpdateEvent(
                                                        jobId: jobId,
                                                        workerId: workerId,
                                                        statusType: 'Await',
                                                      ),
                                                    );
                                              },
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 4,
                                            horizontal: 8,
                                          ),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: _editGreen,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: const Text(
                                            'Book Now',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      // IconButton(
                                      //   onPressed: () {
                                      //     // TODO: Chat
                                      //   },
                                      //   icon: const Icon(
                                      //     Icons.chat_bubble_outline,
                                      //     color: _secondary,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.edit_outlined),
                            label: const Text('Edit Job Post'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _editGreen,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              foregroundColor: _closeRed,
                              side: const BorderSide(color: _closeRed),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: const Text(
                              'Close Job',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _getInitials(String? fullName) {
    if (fullName == null || fullName.trim().isEmpty) {
      return '';
    }

    return fullName
        .trim()
        .split(RegExp(r'\s+'))
        .where((value) => value.isNotEmpty)
        .map((value) => value[0])
        .take(2)
        .join()
        .toUpperCase();
  }

  Widget _meta(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: _secondary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF43474E),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Widget _tag(String text, Color background, Color foreground) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: foreground,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _session(String title, String time) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF4F7FB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 70,
            decoration: const BoxDecoration(
              color: _sessionAccent,
              borderRadius: BorderRadius.horizontal(left: Radius.circular(12)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color(0xFF101828),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 16,
                        color: _secondary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        time,
                        style: const TextStyle(
                          color: Color(0xFF4A5565),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}