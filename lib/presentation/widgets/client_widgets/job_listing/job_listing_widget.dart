import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'job_detail_widget.dart';

class JobListingWidget extends StatelessWidget {
  const JobListingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final jobs = [
      {
        "id": "1409",
        "title": "Community Access Support",
      },
      {
        "id": "1201",
        "title": "Personal Care Assistant",
      },
      {
        "id": "1340",
        "title": "Community Access Support",
      },
      {
        "id": "1360",
        "title": "Support Worker",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [

            /// Header
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

            /// Tabs

               Container(
                height: 64,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    /// Active / Closed Tabs
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF4F5F7),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: const Color(0xff0B7185),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Active Job",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Center(
                                child: Text(
                                  "Closed Jobs",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    /// Filter Button
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Color(0xFFF4F5F7),
                        borderRadius: BorderRadius.circular(16),
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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "TOTAL JOBS - ${jobs.length}",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: jobs.length,
                itemBuilder: (context, index) {
                  final job = jobs[index];

                  return Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(22),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const JobDetailWidget(),
                        ),
                      );
                    },
                    child: _jobCard(job),
                  ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _jobCard(Map job) {
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
            "Job #: ${job["id"]}",
            style: const TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 6),

          Text(
            job["title"],
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Row(
            children: const [
              Icon(Icons.location_on_outlined, size: 18),
              SizedBox(width: 4),
              Text("Surry Hills, NSW"),
            ],
          ),

          const SizedBox(height: 6),

          Row(
            children: const [
              Icon(Icons.access_time, size: 18),
              SizedBox(width: 4),
              Text("Posted 2 days ago"),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: const [

              _Tag("Aged", Color(0xffF2F2F2), Colors.black),

              SizedBox(width: 8),

              _Tag("Urgent", Color(0xffFFE2E2), Colors.red),

              SizedBox(width: 8),

              _Tag("Dementia", Color(0xffDDF7F4), Color(0xff00796B)),
            ],
          ),

          const SizedBox(height: 18),

          Divider(),

          Row(
            children: [

              _avatar(),

              Transform.translate(
                offset: const Offset(-10, 0),
                child: _avatar(),
              ),

              Transform.translate(
                offset: const Offset(-20, 0),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Color(0xffDCE8FF),
                  child: Text(
                    "+18",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const Spacer(),

              const Text(
                "10+ applicants",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _avatar() {
    return const CircleAvatar(
      radius: 18,
      backgroundImage: NetworkImage(
        "https://i.pravatar.cc/150?img=3",
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String text;
  final Color bg;
  final Color color;

  const _Tag(
      this.text,
      this.bg,
      this.color,
      );

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

class _BottomItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool selected;

  const _BottomItem(
      this.icon,
      this.title,
      this.selected,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Icon(
          icon,
          color: selected ? Color(0xff0B7185) : Colors.grey,
        ),

        const SizedBox(height: 4),

        Text(
          title,
          style: TextStyle(
            color: selected ? Color(0xff0B7185) : Colors.grey,
            fontWeight:
            selected ? FontWeight.bold : FontWeight.normal,
          ),
        )
      ],
    );
  }
}