import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../bloc/client_bloc/job_detail/job_detail_bloc.dart';
import '../../../../bloc/client_bloc/job_detail/job_detail_state.dart';

class JobDetailWidget extends StatefulWidget {
  const JobDetailWidget({super.key});

  @override
  State<JobDetailWidget> createState() => _JobDetailWidgetState();
}

class _JobDetailWidgetState extends State<JobDetailWidget> {
  static const _bg = Color(0xFFF9FAFB);
  static const _secondary = Color(0xFF6B7280);
  static const _border = Color(0xFFE5E7EB);
  static const _linkBlue = Color(0xFF3B82F6);
  static const _priceGreen = Color(0xFF10B981);
  static const _editGreen = Color(0xFF336B5F);
  static const _closeRed = Color(0xFFD14343);
  static const _sessionAccent = Color(0xFF2563EB);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientJobDetailBloc, ClientJobDetailState>(
      builder: (context, state) {
        if (state is ClientJobDetailLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is ClientJobDetailError) {
          return Scaffold(body: Center(child: Text(state.message)));
        }

        if (state is! ClientJobDetailLoaded) {
          return const Scaffold(body: SizedBox());
        }

        final response = state.response;

        final job = response.data?.job;

        final location = response.data?.location?.isNotEmpty == true
            ? response.data!.location!.first
            : null;

        final sessions = response.data?.sessions ?? [];

        final requirements = response.data?.jobRequirements;

        final serviceCategory = response.data?.serviceDetails?.serviceCategory;

        final postedBy = response.data?.postedBy?.user;

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
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),

                      const SizedBox(width: 16),

                      const Text(
                        "Job Details",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  Text(
                    "Job #: ${job?.id ?? ""}",
                    style: const TextStyle(fontSize: 13, color: _secondary),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    job?.title ?? "",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 10),

                  _meta(
                    Icons.location_on_outlined,
                    "${location?.street1 ?? ""}, ${location?.city ?? ""}",
                  ),

                  const SizedBox(height: 6),

                  _meta(Icons.access_time, job?.createdAt ?? ""),

                  const SizedBox(height: 14),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (serviceCategory != null)
                        _tag(
                          serviceCategory.name ?? "",
                          const Color(0xFFF3F4F6),
                          const Color(0xFF374151),
                        ),

                      if (job?.shift != null)
                        _tag(job!.shift!, const Color(0xFFE0F2FE), Colors.blue),

                      if (job?.category != null)
                        _tag(
                          job!.category!,
                          const Color(0xFFFCE7F3),
                          Colors.pink,
                        ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.grey.shade300,
                        child: Text(
                          postedBy?.firstName?.substring(0, 1).toUpperCase() ??
                              "",
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Text(
                          "${job?.applicationCount ?? 0} Applicants",
                          style: const TextStyle(
                            color: _linkBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      Text(
                        "₹${job?.hourlyRate ?? ""}/hr",
                        style: const TextStyle(
                          color: _priceGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
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
                              "Job Description",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),

                            const Spacer(),

                            Text(
                              "${job?.hoursPerDay ?? ""} hrs/day",
                              style: const TextStyle(color: _secondary),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        Text(
                          job?.description ?? "",
                          style: const TextStyle(
                            height: 1.6,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  _card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Sessions",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),

                            const Spacer(),

                            Text(
                              "${sessions.length} Sessions",
                              style: const TextStyle(color: _secondary),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        Column(
                          children: sessions.map((session) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _session(
                                session.startDate ?? "",
                                "${session.startTime ?? ""} - ${session.endTime ?? ""}",
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
                          "Service Requirements",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 16),

                        if (requirements?.serviceRequirement != null)
                          Row(
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
                                  requirements!.serviceRequirement!,
                                  style: const TextStyle(height: 1.5),
                                ),
                              ),
                            ],
                          ),

                        if (requirements?.description != null) ...[
                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 16),

                          Row(
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
                                  requirements!.description!,
                                  style: const TextStyle(height: 1.5),
                                ),
                              ),
                            ],
                          ),
                        ],

                        if (job?.shift != null) ...[
                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 16),

                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/circular_tick.svg',
                                width: 22,
                                height: 22,
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: Text(
                                  "Shift : ${job!.shift}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],

                        if (job?.hoursPerDay != null) ...[
                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 16),

                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/circular_tick.svg',
                                width: 22,
                                height: 22,
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: Text(
                                  "Hours Per Day : ${job!.hoursPerDay}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],

                        if (job?.hourlyRate != null) ...[
                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 16),

                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/circular_tick.svg',
                                width: 22,
                                height: 22,
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: Text(
                                  "Hourly Rate : ₹${job!.hourlyRate}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  _card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Posted By",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 16),

                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            radius: 24,
                            child: Text(
                              postedBy?.firstName
                                      ?.substring(0, 1)
                                      .toUpperCase() ??
                                  "",
                            ),
                          ),
                          title: Text(
                            "${postedBy?.firstName ?? ""} ${postedBy?.lastName ?? ""}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(postedBy?.email ?? ""),
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
                          "Job Location Details",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 16),

                        _meta(
                          Icons.location_on,
                          "${location?.street1 ?? ""}, ${location?.street2 ?? ""}",
                        ),

                        const SizedBox(height: 10),

                        _meta(
                          Icons.location_city,
                          "${location?.city ?? ""}, ${location?.state ?? ""}",
                        ),

                        const SizedBox(height: 10),

                        _meta(Icons.pin_drop, location?.zipCode ?? ""),

                        const SizedBox(height: 10),

                        _meta(
                          Icons.social_distance,
                          "${location?.distanceKm ?? 0} km away",
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
                          "Total Applicants - ${job?.applicationCount ?? 0}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 16),

                        if ((job?.applicationCount ?? 0) == 0)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                "No applicants yet",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          )
                        else
                          ListView.builder(
                            itemCount: job?.applicationCount ?? 0,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
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
                                        child: Text(
                                          "${index + 1}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(width: 12),

                                      const Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Applicant",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),

                                            SizedBox(height: 4),

                                            Text(
                                              "Waiting for applicant details",
                                              style: TextStyle(
                                                color: _secondary,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.chat_bubble_outline,
                                          color: _secondary,
                                        ),
                                      ),
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
                            label: const Text("Edit Job Post"),
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
                              "Close Job",
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
              fontSize: 14,
              color: _secondary,
              height: 1.4,
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
        color: const Color(0xffF4F7FB),
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
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
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
                      Text(time, style: const TextStyle(color: _secondary)),
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
