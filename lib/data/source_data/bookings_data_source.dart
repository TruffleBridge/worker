import 'package:nimora_worker/domain/model/view_model/bookings.dart';

abstract class BookingsDataSource {
  Future<List<Booking>> getBookings();
}

class BookingsDataSourceImpl implements BookingsDataSource {
  @override
  Future<List<Booking>> getBookings() async {
    await Future.delayed(const Duration(milliseconds: 700));
    return _mockBookings;
  }

  static final List<Booking> _mockBookings = [
    Booking(
      id: 'bk_001',
      bookingCode: 'HB2360836980512',
      clientName: 'Mrs. Chen',
      serviceType: 'Morning Companion and Mobility Support',
      timeRange: 'Shifts: Day Shift',
      location: 'Sydney, NSW',
      totalAmount: 180,
      status: BookingStatus.upcoming,
      date: DateTime.now(),
      phone: '+61 29876 5432',
      fullAddress: 'Oak Avenue, Apt 5B, Sydney NSW 2000',
      distanceKm: 2.5,
      appliedTime: 'Applied 1 week ago',
    ),
    Booking(
      id: 'bk_002',
      bookingCode: 'HB2360836980512',
      clientName: 'Mr. Thompson',
      serviceType: 'Morning Companion and Mobility Support',
      timeRange: 'Shifts: Day Shift',
      location: 'Sydney, NSW',
      totalAmount: 100,
      status: BookingStatus.upcoming,
      date: DateTime.now().add(const Duration(days: 1)),
      phone: '+61 29876 5432',
      fullAddress: 'Maple Street, Unit 12A, Sydney NSW 2001',
      distanceKm: 1.8,
      appliedTime: 'Applied 1 week ago',
    ),
    Booking(
      id: 'bk_003',
      bookingCode: 'HB2360836980512',
      clientName: 'Mr. Thompson',
      serviceType: 'Morning Companion and Mobility Support',
      timeRange: 'Shifts: Day Shift',
      location: 'Sydney, NSW',
      totalAmount: 80,
      status: BookingStatus.pending,
      date: DateTime.now(),
      phone: '+61 29876 5432',
      fullAddress: 'Maple Street, Unit 12A, Sydney NSW 2001',
      distanceKm: 1.8,
      appliedTime: 'Applied 1 week ago',
    ),
    Booking(
      id: 'bk_004',
      bookingCode: 'HB2360836980512',
      clientName: 'Mr. Davis',
      serviceType: 'Morning Companion and Mobility Support',
      timeRange: 'Shifts: Day Shift',
      location: 'Sydney, NSW',
      totalAmount: 80,
      status: BookingStatus.pending,
      date: DateTime.now(),
      phone: '+61 29876 5432',
      fullAddress: 'Willow Gardens, Room 308, Sydney NSW 2010',
      appliedTime: 'Applied 1 week ago',
      distanceKm: 3.2,
    ),
    Booking(
      id: 'bk_005',
      bookingCode: 'HB2360831290047',
      clientName: 'Mrs. Chen',
      serviceType: 'Morning Companion and Mobility Support',
      timeRange: 'Shifts: Day Shift',
      location: 'Sydney, NSW',
      totalAmount: 80,
      status: BookingStatus.completed,
      date: DateTime.now().subtract(const Duration(days: 2)),
      phone: '+61 29876 5432',
      fullAddress: 'Oak Avenue, Apt 5B, Sydney NSW 2000',
      distanceKm: 2.5,
      appliedTime: 'Applied 1 week ago',
    ),
  ];
}
