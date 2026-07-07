import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../bloc/client_bloc/job_lisiting/job_listing_bloc.dart';
import '../../../../bloc/client_bloc/job_lisiting/job_listing_event.dart';
import '../../../../bloc/client_bloc/job_lisiting/job_listing_state.dart';
import '../../../../domain/model/response/job_listing/job_listing_response_model.dart';
import 'job_detail_widget.dart';

class JobListingWidget extends StatefulWidget {
  const JobListingWidget({super.key});

  @override
  State<JobListingWidget> createState() => _JobListingWidgetState();
}

class _JobListingWidgetState extends State<JobListingWidget> {
  int _selectedTab = 0;

  String get _statusForTab => _selectedTab == 0 ? "active" : "closed";

  @override
  void initState() {
    super.initState();
    // Kick off the initial fetch for the default (Active) tab.
    context.read<MyJobsListBloc>().add(FetchMyJobsListEvent(status: _statusForTab));
  }

  void _switchTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
    context.read<MyJobsListBloc>().add(
      FetchMyJobsListEvent(status: _statusForTab),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
              child: Row(
                children: const [
                  Text(
                    "My Jobs",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              height: 64,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F5F7),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () => _switchTab(0),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: _selectedTab == 0
                                      ? const Color(0xff0B7185)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Center(
                                  child: Text(
                                    "Active Job",
                                    style: TextStyle(
                                      color: _selectedTab == 0
                                          ? Colors.white
                                          : Colors.black87,
                                      fontWeight: _selectedTab == 0
                                          ? FontWeight.w600
                                          : FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () => _switchTab(1),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: _selectedTab == 1
                                      ? const Color(0xff0B7185)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Center(
                                  child: Text(
                                    "Closed Jobs",
                                    style: TextStyle(
                                      color: _selectedTab == 1
                                          ? Colors.white
                                          : Colors.black87,
                                      fontWeight: _selectedTab == 1
                                          ? FontWeight.w600
                                          : FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF4F5F7),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/images/filter_icon.svg',
                        width: 22,
                        height: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: BlocBuilder<MyJobsListBloc, MyJobsListState>(
                builder: (context, state) {
                  if (state is MyJobsListLoading || state is MyJobsListInitial) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is MyJobsListError) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            state.message,
                            style: TextStyle(color: Colors.grey.shade700),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(100, 50), // Width, Height
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {
                              context.read<MyJobsListBloc>().add(
                                FetchMyJobsListEvent(status: _statusForTab),
                              );
                            },
                            child: const Text("Retry"),
                          ),
                        ],
                      ),
                    );
                  }

                  final loaded = state as MyJobsListLoaded;
                  final jobs = loaded.jobs;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          _selectedTab == 0
                              ? "TOTAL JOBS - ${loaded.total}"
                              : "CLOSED JOBS - ${loaded.total}",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Expanded(
                        child: jobs.isEmpty
                            ? Center(
                          child: Text(
                            _selectedTab == 0
                                ? "No active jobs"
                                : "No closed jobs",
                            style:
                            TextStyle(color: Colors.grey.shade600),
                          ),
                        )
                            : RefreshIndicator(
                          onRefresh: () async {
                            context.read<MyJobsListBloc>().add(
                              RefreshMyJobsListEvent(
                                status: _statusForTab,
                              ),
                            );
                          },
                          child: ListView.builder(
                            key: ValueKey(_selectedTab),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            itemCount: jobs.length,
                            itemBuilder: (context, index) {
                              final job = jobs[index];
                              return Padding(
                                padding:
                                const EdgeInsets.only(bottom: 18),
                                child: InkWell(
                                  borderRadius:
                                  BorderRadius.circular(22),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                        const JobDetailWidget(),
                                      ),
                                    );
                                  },
                                  child: _jobCard(job),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _jobCard(JobListItemModel job) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Job #: ${job.id ?? '-'}",
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 6),
          Text(
            job.title ?? '-',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 18),
              const SizedBox(width: 4),
              Text(job.location ?? '-'),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.access_time, size: 18),
              const SizedBox(width: 4),
              Text(job.postedAt ?? '-'),
            ],
          ),
          const SizedBox(height: 16),
          if (job.tags.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: job.tags
                  .map((t) => _Tag(t, const Color(0xffF2F2F2), Colors.black))
                  .toList(),
            ),
          const SizedBox(height: 18),
          const Divider(),
          Row(
            children: [
              ..._buildAvatars(job.applicantAvatars),
              const Spacer(),
              Text(
                "${job.applicantsCount ?? 0}+ applicants",
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildAvatars(List<String> avatarUrls) {
    final shown = avatarUrls.take(2).toList();
    final widgets = <Widget>[];

    for (var i = 0; i < shown.length; i++) {
      widgets.add(
        Transform.translate(
          offset: Offset(i == 0 ? 0 : -10.0 * i, 0),
          child: CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(shown[i]),
          ),
        ),
      );
    }

    if (avatarUrls.length > shown.length) {
      widgets.add(
        Transform.translate(
          offset: Offset(-10.0 * shown.length, 0),
          child: CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xffDCE8FF),
            child: Text(
              "+${avatarUrls.length - shown.length}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    }

    return widgets;
  }
}

class _Tag extends StatelessWidget {
  final String text;
  final Color bg;
  final Color color;

  const _Tag(this.text, this.bg, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}