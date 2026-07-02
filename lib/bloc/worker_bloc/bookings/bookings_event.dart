// part of 'bookings_bloc.dart';
//
// sealed class BookingsEvent extends Equatable {
//   const BookingsEvent();
//   @override
//   List<Object?> get props => [];
// }
//
// class BookingsLoaded extends BookingsEvent {
//   const BookingsLoaded();
// }
//
// class BookingsTabChanged extends BookingsEvent {
//   final BookingStatus tab;
//   const BookingsTabChanged(this.tab);
//   @override
//   List<Object?> get props => [tab];
// }
//
// class BookingApproved extends BookingsEvent {
//   final String bookingId;
//   const BookingApproved(this.bookingId);
//   @override
//   List<Object?> get props => [bookingId];
// }
//
// class BookingRejected extends BookingsEvent {
//   final String bookingId;
//   const BookingRejected(this.bookingId);
//   @override
//   List<Object?> get props => [bookingId];
// }
//
// class BookingShiftEnded extends BookingsEvent {
//   final String bookingId;
//
//   const BookingShiftEnded(this.bookingId);
//
//   @override
//   List<Object?> get props => [bookingId];
// }