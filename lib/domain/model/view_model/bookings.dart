import 'package:equatable/equatable.dart';

enum BookingStatus { upcoming, pending, completed }

enum BookingType { physicalTherapy, medicationReminder, companionship, other }

class Booking extends Equatable {
  final String id;
  final String bookingCode;
  final String clientName;
  final String serviceType;
  final String timeRange;
  final String location;
  final double totalAmount;
  final BookingStatus status;
  final DateTime date;
  final String? phone;
  final String? fullAddress;
  final String? appliedTime;
  final double? distanceKm;

  const Booking({
    required this.id,
    required this.bookingCode,
    required this.clientName,
    required this.serviceType,
    required this.timeRange,
    required this.location,
    required this.totalAmount,
    required this.status,
    required this.date,
    this.phone,
    this.fullAddress,
    this.appliedTime,
    this.distanceKm,
  });

  String get statusLabel {
    switch (status) {
      case BookingStatus.upcoming:
        return 'Upcoming';
      case BookingStatus.pending:
        return 'In Pending';
      case BookingStatus.completed:
        return 'Completed';
    }
  }

  @override
  List<Object?> get props => [id, status];
}
