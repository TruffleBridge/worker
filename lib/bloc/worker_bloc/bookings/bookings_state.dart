import 'package:equatable/equatable.dart';
import 'package:nimora_worker/domain/model/view_model/bookings.dart';

abstract class BookingsState extends Equatable {
  const BookingsState();
  @override
  List<Object?> get props => [];
}

class BookingsInitial extends BookingsState {
  const BookingsInitial();
}

class BookingsLoading extends BookingsState {
  const BookingsLoading();
}

class BookingsSuccess extends BookingsState {
  final List<Booking> allBookings;
  final BookingStatus activeTab;

  const BookingsSuccess({
    required this.allBookings,
    this.activeTab = BookingStatus.upcoming,
  });

  List<Booking> get filteredBookings =>
      allBookings.where((b) => b.status == activeTab).toList();

  BookingsSuccess copyWith({
    List<Booking>? allBookings,
    BookingStatus? activeTab,
  }) =>
      BookingsSuccess(
        allBookings: allBookings ?? this.allBookings,
        activeTab: activeTab ?? this.activeTab,
      );

  @override
  List<Object?> get props => [allBookings, activeTab];
}

class BookingsError extends BookingsState {
  final String message;
  const BookingsError(this.message);
  @override
  List<Object?> get props => [message];
}
