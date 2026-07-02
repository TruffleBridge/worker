import 'package:flutter/material.dart';
import 'package:nimora_worker/core/constants/nimora_colors.dart';
import 'package:nimora_worker/domain/model/view_model/bookings.dart';
import '../../../../core/theme/app_theme.dart';

class BookingCard extends StatelessWidget {
  final Booking booking;
  final VoidCallback onTap;
  final VoidCallback? onApprove;
  final VoidCallback? onReject;

  const BookingCard({
    super.key,
    required this.booking,
    required this.onTap,
    this.onApprove,
    this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppDimensions.paddingM),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          border: Border.all(color: AppColors.grey200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CardHeader(booking: booking),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.paddingM,
                AppDimensions.paddingM,
                AppDimensions.paddingM,
                AppDimensions.paddingM,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booking.serviceType,
                    style: NdisThemeStyle.headlineMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: NimoraColors.titleColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _MetaRow(
                    icon: 'assets/images/location_symbol.png',
                    text: booking.location,
                  ),
                  const SizedBox(height: 4),
                  _MetaRow(
                    icon: 'assets/images/calendar_symbol.png',
                    text: booking.timeRange,
                  ),
                  const SizedBox(height: 4),
                  _MetaRow(
                    icon: 'assets/images/timer_symbol.png',
                    text: booking.appliedTime ?? '',
                  ),
                  const SizedBox(height: 8),
                  // const SizedBox(height: AppDimensions.paddingM),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text(
                  //           'Total Amount',
                  //           style: AppTextStyles.bodyMedium.copyWith(
                  //             fontSize: 11,
                  //           ),
                  //         ),
                  //         Text(
                  //           '\$${booking.totalAmount.toStringAsFixed(0)}',
                  //           style: AppTextStyles.headlineMedium.copyWith(
                  //             color: AppColors.primary,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     _DetailsButton(onTap: onTap),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Card Header ──────────────────────────────────────────────────────────────

class _CardHeader extends StatelessWidget {
  final Booking booking;

  const _CardHeader({required this.booking});

  // Foreground icon/text/badge color
  Color get _accentColor {
    switch (booking.status) {
      case BookingStatus.upcoming:
        return const Color(0xFF059669); // green
      case BookingStatus.pending:
        return const Color(0xFFDB2777); // pink
      case BookingStatus.completed:
        return const Color(0xFF10B981); // teal
    }
  }

  // Gradient colours for the header background
  List<Color> get _gradientColors {
    switch (booking.status) {
      case BookingStatus.upcoming:
        return const [Color(0xFFF0FDF4), Color(0xFFECFDF5)];
      case BookingStatus.pending:
        return const [Color(0xFFFEF2F2), Color(0xFFFDF2F8)];
      case BookingStatus.completed:
        return const [Color(0xFFECFDF5), Color(0xFFF0FDF4)];
    }
  }

  String get _statusIcon {
    switch (booking.status) {
      case BookingStatus.upcoming:
        return '';
      case BookingStatus.pending:
        return 'assets/images/caution_symbol.png';
      case BookingStatus.completed:
        return 'assets/images/circular_tick.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingM,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _gradientColors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.radiusL),
          topRight: Radius.circular(AppDimensions.radiusL),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(_statusIcon, height: 14),
          // Icon(_statusIcon, size: 14, color: _accentColor),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            // decoration: BoxDecoration(
            //   color: _accentColor.withValues(alpha: 0.12),
            //   borderRadius: BorderRadius.circular(20),
            //   border: Border.all(color: _accentColor.withValues(alpha: 0.3)),
            // ),
            child: Text(
              booking.statusLabel,
              style: TextStyle(
                color: _accentColor,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
          const Spacer(),
          const Text(
            'Job #: 1409',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: NimoraColors.titleColor,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Meta Row ─────────────────────────────────────────────────────────────────

class _MetaRow extends StatelessWidget {
  final String icon;
  final String text;

  const _MetaRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(icon, height: 16),
        // Icon(icon, size: 16, color: AppColors.grey400),
        const SizedBox(width: 6),
        Text(text, style: NdisThemeStyle.bodyMedium.copyWith(fontSize: 14)),
      ],
    );
  }
}

// ─── Details Button ───────────────────────────────────────────────────────────

class _DetailsButton extends StatelessWidget {
  final VoidCallback onTap;

  const _DetailsButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primarySurface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Details',
              style: NdisThemeStyle.bodyMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 11,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
