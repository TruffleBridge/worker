import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class JobDetailWidget extends StatelessWidget {
  const JobDetailWidget({super.key});

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
    final applicants = [
      _Applicant(
        name: 'Manoj Rajkumar',
        timeSlot: '9:00 AM - 1:00 PM',
        location: 'Surry Hills, NSW',
        distance: '3.4 km away',
        avatarUrl: 'https://randomuser.me/api/portraits/men/75.jpg',
      ),
      _Applicant(
        name: 'Mark Bench',
        timeSlot: '1:00 PM - 3:00 PM',
        location: 'Surry Hills, NSW',
        distance: '3.4 km away',
        avatarUrl: 'https://randomuser.me/api/portraits/men/12.jpg',
      ),
      _Applicant(
        name: 'David Chan',
        timeSlot: '6:00 PM - 9:00 PM',
        location: 'Surry Hills, NSW',
        distance: '3.4 km away',
        avatarUrl: 'https://randomuser.me/api/portraits/men/22.jpg',
      ),
      _Applicant(
        name: 'Jennie Butter',
        timeSlot: '10:00 AM - 12:00 PM',
        location: 'Surry Hills, NSW',
        distance: '3.4 km away',
        avatarUrl: 'https://randomuser.me/api/portraits/women/65.jpg',
      ),
    ];

    final requirements = [
      'Morning routine assistance including dressing and light hygiene',
      'Light meal preparation (breakfast and early lunch)',
      'Mobility support for short neighborhood walks',
      'Social engagement and technology assistance',
    ];

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
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                      ),
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
              // Job header
              const Text('Job #: 1409', style: TextStyle(fontSize: 13, color: _secondary)),
              const SizedBox(height: 6),
              const Text(
                'Community Access Support',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              _meta(Icons.location_on_outlined, 'Surry Hills, NSW'),
              const SizedBox(height: 6),
              _meta(Icons.access_time, 'Posted 2 days ago'),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _tag('Aged', const Color(0xFFF3F4F6), const Color(0xFF374151)),
                  _tag('Urgent', const Color(0xFFFEE2E2), const Color(0xFFDC2626)),
                  _tag('Dementia', const Color(0xFFCCFBF1), const Color(0xFF0F766E)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  SizedBox(
                    width: 52,
                    height: 28,
                    child: Stack(
                      children: const [
                        Positioned(
                          left: 0,
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 12,
                              backgroundImage: NetworkImage(
                                'https://randomuser.me/api/portraits/men/32.jpg',
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 18,
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 12,
                              backgroundImage: NetworkImage(
                                'https://randomuser.me/api/portraits/women/44.jpg',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '10+ applicants',
                    style: TextStyle(
                      color: _linkBlue,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    '\$40.00/hr',
                    style: TextStyle(
                      color: _priceGreen,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
        
              const SizedBox(height: 20),
        
              // Sessions
              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text('Sessions', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                        Spacer(),
                        Text('2 sessions', style: TextStyle(color: _secondary, fontSize: 13)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _session('Morning Care - Mrs. Anderson', '1:00 PM - 3:00 PM'),
                    const SizedBox(height: 10),
                    _session('Medication - Mr. Thompson', '4:00 PM - 6:00 PM'),
                  ],
                ),
              ),
        
              const SizedBox(height: 16),
        
              // Service requirements
              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Service Requirements',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    ...List.generate(requirements.length, (i) {
                      return Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                    'assets/images/circular_tick.svg',
                                    width: 22,
                                    height: 22,
                                  ),
                              const SizedBox(width: 10),
                              Expanded(child: Text(requirements[i], style: const TextStyle(height: 1.4))),
                            ],
                          ),
                          if (i != requirements.length - 1) ...[
                            const SizedBox(height: 12),
                            const Divider(height: 1, color: _border),
                            const SizedBox(height: 12),
                          ],
                        ],
                      );
                    }),
                  ],
                ),
              ),
        
              const SizedBox(height: 20),
        
              // Applicants section
               _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Applicants - 20',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    ...applicants.map((a) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: _border),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                a.avatarUrl,
                                width: 56,
                                height: 56,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    a.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    a.timeSlot,
                                    style: const TextStyle(color: _secondary, fontSize: 13),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on_outlined,
                                          size: 14, color: _secondary),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          '${a.location} • ${a.distance}',
                                          style: const TextStyle(
                                            color: _secondary,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
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
                    )),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.edit_outlined, size: 18),
                        label: const Text('Edit Job Post'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _editGreen,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: _closeRed,
                          side: const BorderSide(color: _closeRed),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        child: const Text(
                          'Close Job',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _meta(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: _secondary),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(color: _secondary, fontSize: 14)),
      ],
    );
  }

  Widget _tag(String label, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: fg),
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _border),
      ),
      child: child,
    );
  }

  Widget _session(String title, String time) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 72,
            decoration: const BoxDecoration(
              color: _sessionAccent,
              borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 14, color: _secondary),
                      const SizedBox(width: 4),
                      Text(time, style: const TextStyle(color: _secondary, fontSize: 13)),
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

class _Applicant {
  final String name;
  final String timeSlot;
  final String location;
  final String distance;
  final String avatarUrl;

  const _Applicant({
    required this.name,
    required this.timeSlot,
    required this.location,
    required this.distance,
    required this.avatarUrl,
  });
}