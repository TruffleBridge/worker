import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimora_worker/bloc/worker_bloc/bookings/bookings_bloc.dart';
import 'package:nimora_worker/core/constants/nimora_colors.dart';
import 'package:nimora_worker/domain/model/view_model/bookings.dart';
import '../../../../core/theme/app_theme.dart';

class BookingDetailPage extends StatefulWidget {
  final Booking booking;

  const BookingDetailPage({super.key, required this.booking});

  @override
  State<BookingDetailPage> createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends State<BookingDetailPage> {
  bool transportEnabled = false;

  @override
  Widget build(BuildContext context) {
    final booking = widget.booking;

    return Scaffold(
      backgroundColor: AppColors.white,

      // APP BAR
      appBar: AppBar(
        backgroundColor: NimoraColors.detailAppBarTitleColor,
        elevation: 0,
        surfaceTintColor: Colors.white,

        leadingWidth: 72,

        leading: Padding(
          padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: const BoxDecoration(
                color: NimoraColors.securityBgContainer,
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

        title: const Text(
          'Jobs',
          style: TextStyle(
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

      // BODY
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // BADGES + PRICE
                  const Row(
                    children: [
                      _BadgeChip(
                        label: 'Aged',
                        color: NimoraColors.jobBadgeDefaultColor,
                      ),

                      SizedBox(width: 8),

                      _BadgeChip(
                        label: 'Urgent',
                        color: NimoraColors.jobBadgeUrgentColor,
                      ),

                      Spacer(),

                      Text(
                        '\$62.00/hr',
                        style: TextStyle(
                          color: NimoraColors.hourlyRateColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'Job #: ${booking.bookingCode}',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    booking.serviceType,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 16),

                  _metaRow(Icons.location_on_outlined, booking.location),

                  const SizedBox(height: 10),

                  _metaRow(Icons.schedule_outlined, booking.timeRange),

                  const SizedBox(height: 28),

                  // CLIENT INFORMATION
                  const Text(
                    'Client Information',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),

                  const SizedBox(height: 14),

                  _ClientCard(booking: booking),

                  const SizedBox(height: 24),

                  // BOOKING TIMELINE
                  _TimelineCard(),

                  const SizedBox(height: 18),

                  // TRANSPORT
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.grey200),
                    ),
                    child: Row(
                      children: [
                        const Text(
                          'Transport',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        Switch(
                          value: transportEnabled,
                          onChanged: (v) {
                            setState(() {
                              transportEnabled = v;
                            });
                          },
                          activeColor: Colors.white,
                          activeTrackColor: AppColors.primary,
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: NimoraColors.detailAppBarTitleColor,
                          trackOutlineColor:
                              MaterialStateProperty.resolveWith<Color>((
                                states,
                              ) {
                                if (states.contains(MaterialState.selected)) {
                                  return Colors.transparent;
                                }
                                return NimoraColors.switchDisabledColor;
                              }),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  // SESSIONS
                  _SessionsCard(),

                  const SizedBox(height: 24),

                  Center(
                    child: GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Cancel Session',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

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
            child: SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    barrierColor: Colors.black54,
                    builder: (_) {
                      return EndShiftDialog(
                        onConfirm: () {
                          context.read<BookingsBloc>().add(
                            BookingShiftEnded(booking.id),
                          );

                          Navigator.pop(context);

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  BookingDetailPage(booking: booking),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'End Shift',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _metaRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade500),

        const SizedBox(width: 5),

        Text(
          text,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// CLIENT CARD

class _ClientCard extends StatelessWidget {
  final Booking booking;

  const _ClientCard({required this.booking});

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
              'https://i.pravatar.cc/100',
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.clientName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  booking.timeRange,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                ),

                const SizedBox(height: 4),

                Text(
                  booking.location,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
          ),

          IconButton(onPressed: () {}, icon: const Icon(Icons.phone_outlined)),
        ],
      ),
    );
  }
}

// TIMELINE CARD

class _TimelineCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                'Booking Timeline',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),

              const Spacer(),

              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.grey.shade600,
              ),
            ],
          ),

          const SizedBox(height: 20),

          _timelineItem(
            title: 'In Review',
            subtitle: 'Jobs is in review with client',
          ),

          _timelineItem(
            title: 'Link Sent',
            subtitle: 'Client will share the link to the worker',
          ),

          _timelineItem(
            title: 'Approved',
            subtitle: 'This job will be approved by worker',
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _timelineItem({
    required String title,
    required String subtitle,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: Color(0xFFE9F8EE),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                size: 14,
                color: NimoraColors.hourlyRateColor,
              ),
            ),

            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: NimoraColors.moreContainerBgColor,
              ),
          ],
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// SESSIONS CARD

class _SessionsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),

              const Spacer(),

              Text(
                '2 sessions',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
            ],
          ),

          const SizedBox(height: 18),

          _sessionTile(
            title: 'Morning Care - Mrs. Anderson',
            time: '1:00 PM - 3:00 PM',
          ),

          const SizedBox(height: 12),

          _sessionTile(
            title: 'Medication - Mr. Thompson',
            time: '4:00 PM - 6:00 PM',
          ),
        ],
      ),
    );
  }

  Widget _sessionTile({required String title, required String time}) {
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
              color: NimoraColors.sessionBgColor,
              borderRadius: BorderRadius.circular(20),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  time,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
          ),

          Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey.shade600),
        ],
      ),
    );
  }
}

// BADGE

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

class EndShiftDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const EndShiftDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 32),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Image.asset('assets/images/causion_symbol.jpg'),
            ),

            const SizedBox(height: 18),

            const Text(
              'End Shift Confirmation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),

            const SizedBox(height: 10),

            const Text(
              'Are you sure you want to clock out and end your shift?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton(
                    onPressed: onConfirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      minimumSize: const Size(0, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text('Clock Out'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
