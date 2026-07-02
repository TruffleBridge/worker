import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimora_worker/bloc/worker_bloc/bookings/bookings_bloc.dart';
import 'package:nimora_worker/core/constants/nimora_colors.dart';
import 'package:nimora_worker/domain/model/view_model/bookings.dart';
import 'package:nimora_worker/presentation/widgets/components/home_app_bar.dart';
import 'package:nimora_worker/presentation/widgets/worker_widgets/bookings/booking_card.dart';
import 'package:nimora_worker/presentation/widgets/worker_widgets/bookings/booking_detail_page.dart';
import '../../../../core/theme/app_theme.dart';

class BookingsWidget extends StatelessWidget {
  const BookingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: HomeAppBar(
          actions: [
            PreferredSize(preferredSize: Size.zero, child: Container()),
          ],
        ),
        body: Column(
          children: [
            const _TabBar(),
            Expanded(
              child: BlocBuilder<BookingsBloc, BookingsState>(
                builder: (context, state) {
                  if (state is BookingsLoading || state is BookingsInitial) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  }
                  if (state is BookingsError) {
                    return Center(child: Text(state.message));
                  }
                  if (state is BookingsSuccess) {
                    return TabBarView(
                      children: [
                        _BookingsList(
                          bookings: state.allBookings
                              .where((b) => b.status == BookingStatus.upcoming)
                              .toList(),
                          status: BookingStatus.upcoming,
                        ),
                        _BookingsList(
                          bookings: state.allBookings
                              .where((b) => b.status == BookingStatus.pending)
                              .toList(),
                          status: BookingStatus.pending,
                        ),
                        _BookingsList(
                          bookings: state.allBookings
                              .where((b) => b.status == BookingStatus.completed)
                              .toList(),
                          status: BookingStatus.completed,
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class _TabBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         border: Border(
//             bottom: BorderSide(color: AppColors.grey200, width: 1)),
//       ),
//       child: TabBar(
//         onTap: (i) {
//           final tabs = [
//             BookingStatus.upcoming,
//             BookingStatus.pending,
//             BookingStatus.completed
//           ];
//           context
//               .read<BookingsBloc>()
//               .add(BookingsTabChanged(tabs[i]));
//         },
//         labelColor: AppColors.primary,
//         unselectedLabelColor: AppColors.grey600,
//         indicatorColor: AppColors.primary,
//         indicatorWeight: 2.5,
//         labelStyle: AppTextStyles.bodyMedium.copyWith(
//             fontWeight: FontWeight.w700, fontSize: 14),
//         unselectedLabelStyle:
//             AppTextStyles.bodyMedium.copyWith(fontSize: 14),
//         tabs: const [
//           Tab(text: 'Upcoming'),
//           Tab(text: 'Pending'),
//           Tab(text: 'Completed'),
//         ],
//       ),
//     );
//   }
// }
class _TabBar extends StatelessWidget {
  const _TabBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 14, 20, 10),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(40),
      ),
      child: TabBar(
        onTap: (i) {
          final tabs = [
            BookingStatus.upcoming,
            BookingStatus.pending,
            BookingStatus.completed,
          ];

          context.read<BookingsBloc>().add(BookingsTabChanged(tabs[i]));
        },

        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,

        indicator: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(40),
        ),

        labelColor: Colors.white,
        unselectedLabelColor: AppColors.textPrimary,

        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.all(Colors.transparent),

        labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),

        unselectedLabelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),

        tabs: const [
          Tab(text: 'Upcoming'),
          Tab(text: 'Pending'),
          Tab(text: 'Completed'),
        ],
      ),
    );
  }
}

class _BookingsList extends StatelessWidget {
  final List<Booking> bookings;
  final BookingStatus status;

  const _BookingsList({required this.bookings, required this.status});

  @override
  Widget build(BuildContext context) {
    if (bookings.isEmpty) {
      return _EmptyBookings(status: status);
    }

    // Group upcoming by Today/Tomorrow/Date
    if (status == BookingStatus.upcoming) {
      return _UpcomingBookingsView(bookings: bookings);
    }
    return ListView.builder(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      itemCount: bookings.length,
      itemBuilder: (ctx, i) => BookingCard(
        booking: bookings[i],
        onTap: () => _openDetail(ctx, bookings[i]),
        onApprove: status == BookingStatus.pending
            ? () =>
            ctx.read<BookingsBloc>().add(BookingApproved(bookings[i].id))
            : null,
        onReject: status == BookingStatus.pending
            ? () =>
            ctx.read<BookingsBloc>().add(BookingRejected(bookings[i].id))
            : null,
      ),
    );
  }

  void _openDetail(BuildContext context, Booking booking) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<BookingsBloc>(),
          child: BookingDetailPage(booking: booking),
        ),
      ),
    );
  }
}

class _GroupedBookingsList extends StatelessWidget {
  final List<Booking> bookings;

  const _GroupedBookingsList({required this.bookings});

  String _dayLabel(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final d = DateTime(date.year, date.month, date.day);
    if (d == today) return 'Today';
    if (d == today.add(const Duration(days: 1))) return 'Tomorrow';
    return '${_month(date.month)} ${date.day}, ${date.year}';
  }

  String _month(int m) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[m];
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, List<Booking>> grouped = {};
    for (final b in bookings) {
      final label = _dayLabel(b.date);
      grouped.putIfAbsent(label, () => []).add(b);
    }

    final sections = grouped.entries.toList();

    return ListView.builder(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      itemCount: sections.length,
      itemBuilder: (ctx, si) {
        final section = sections[si];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (si > 0 || section.key != 'Today') ...[
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppDimensions.paddingM,
                ),
                child: Text(
                  section.key,
                  style: NdisThemeStyle.bodyMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
            ...section.value.map(
                  (b) => BookingCard(
                booking: b,
                onTap: () => Navigator.of(ctx).push(
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: ctx.read<BookingsBloc>(),
                      child: BookingDetailPage(booking: b),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _EmptyBookings extends StatelessWidget {
  final BookingStatus status;

  const _EmptyBookings({required this.status});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingXXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.grey100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.calendar_today_outlined,
                size: 48,
                color: AppColors.grey400,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingL),
            Text('No Bookings', style: NdisThemeStyle.headlineMedium),
            const SizedBox(height: AppDimensions.paddingS),
            const Text(
              'Plan your first session to get started. You can schedule activities, meetings, or appointments.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _UpcomingBookingsView extends StatefulWidget {
  final List<Booking> bookings;

  const _UpcomingBookingsView({required this.bookings});

  @override
  State<_UpcomingBookingsView> createState() => _UpcomingBookingsViewState();
}

class _UpcomingBookingsViewState extends State<_UpcomingBookingsView> {
  int selectedDateIndex = 1;

  final List<String> days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  final List<int> dates = [27, 24, 25, 26, 27, 27, 27];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // DATE STRIP
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(days.length, (index) {
              final isSelected = selectedDateIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDateIndex = index;
                  });
                },
                child: Column(
                  children: [
                    Text(
                      days[index],
                      style: TextStyle(
                        fontSize: 11,
                        color: isSelected ? AppColors.primary : Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Container(
                      width: 32,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${dates[index]}',
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),

        // LIST
        // Expanded(
        //   child: ListView.builder(
        //     padding:
        //     const EdgeInsets.symmetric(
        //       horizontal: 20,
        //     ),
        //     itemCount:
        //     widget.bookings.length,
        //     itemBuilder:
        //         (context, index) {
        //       final booking =
        //       widget.bookings[index];
        //
        //       return Padding(
        //         padding:
        //         const EdgeInsets.only(
        //           bottom: 16,
        //         ),
        //         child: BookingCard(
        //           booking: booking,
        //           onTap: () {
        //             Navigator.of(context)
        //                 .push(
        //               MaterialPageRoute(
        //                 builder: (_) =>
        //                     BlocProvider
        //                         .value(
        //                       value: context
        //                           .read<
        //                           BookingsBloc>(),
        //                       child:
        //                       BookingDetailPage(
        //                         booking:
        //                         booking,
        //                       ),
        //                     ),
        //               ),
        //             );
        //           },
        //         ),
        //       );
        //     },
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.grey200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Job #: 1409',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: NimoraColors.titleColor,
                          ),
                        ),
                        Text(
                          'Elder Care',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: NimoraColors.titleColor,
                          ),
                        ),
                      ],
                    ),

                    Spacer(),

                    Text(
                      '1 sessions',
                      style: TextStyle(
                        color: NimoraColors.subtitleColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                _sessionTile(
                  title: 'Morning Care - Mrs. Anderson',
                  time: '1:00 PM - 3:00 PM',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.grey200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Job #: 1409',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: NimoraColors.titleColor,
                          ),
                        ),
                        Text(
                          'Elder Care',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: NimoraColors.titleColor,
                          ),
                        ),
                      ],
                    ),

                    Spacer(),

                    Text(
                      '2 sessions',
                      style: TextStyle(
                        color: NimoraColors.subtitleColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
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
          ),
        ),
      ],
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
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: NimoraColors.titleColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(
                    color: Color(0xFF4A5565),
                    fontSize: 12,
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
