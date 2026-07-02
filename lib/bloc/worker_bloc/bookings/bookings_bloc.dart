import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nimora_worker/data/source_data/bookings_data_source.dart';
import 'package:nimora_worker/domain/model/view_model/bookings.dart';

// ── Events ────────────────────────────────────────────────────────────────────

abstract class BookingsEvent extends Equatable {
  const BookingsEvent();
  @override
  List<Object?> get props => [];
}

class BookingsLoaded extends BookingsEvent {
  const BookingsLoaded();
}

class BookingsTabChanged extends BookingsEvent {
  final BookingStatus tab;
  const BookingsTabChanged(this.tab);
  @override
  List<Object?> get props => [tab];
}

class BookingApproved extends BookingsEvent {
  final String bookingId;
  const BookingApproved(this.bookingId);
  @override
  List<Object?> get props => [bookingId];
}

class BookingRejected extends BookingsEvent {
  final String bookingId;
  const BookingRejected(this.bookingId);
  @override
  List<Object?> get props => [bookingId];
}

class BookingShiftEnded extends BookingsEvent {
  final String bookingId;

  const BookingShiftEnded(this.bookingId);

  @override
  List<Object?> get props => [bookingId];
}
// ── States ────────────────────────────────────────────────────────────────────

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

// ── BLoC ──────────────────────────────────────────────────────────────────────

class BookingsBloc extends Bloc<BookingsEvent, BookingsState> {
  final BookingsDataSource _dataSource;

  BookingsBloc({required BookingsDataSource dataSource})
      : _dataSource = dataSource,
        super(const BookingsInitial()) {
    on<BookingsLoaded>(_onLoaded);
    on<BookingsTabChanged>(_onTabChanged);
    on<BookingApproved>(_onApproved);
    on<BookingRejected>(_onRejected);
    on<BookingShiftEnded>(_onShiftEnded);
  }

  Future<void> _onLoaded(BookingsLoaded e, Emitter<BookingsState> emit) async {
    emit(const BookingsLoading());
    try {
      final bookings = await _dataSource.getBookings();
      emit(BookingsSuccess(allBookings: bookings));
    } catch (e) {
      emit(BookingsError(e.toString()));
    }
  }

  void _onTabChanged(BookingsTabChanged e, Emitter<BookingsState> emit) {
    final s = state;
    if (s is BookingsSuccess) emit(s.copyWith(activeTab: e.tab));
  }

  void _onApproved(BookingApproved e, Emitter<BookingsState> emit) {
    final s = state;
    if (s is BookingsSuccess) {
      final updated = s.allBookings.map((b) {
        if (b.id == e.bookingId) {
          return Booking(
            id: b.id,
            bookingCode: b.bookingCode,
            clientName: b.clientName,
            serviceType: b.serviceType,
            timeRange: b.timeRange,
            location: b.location,
            totalAmount: b.totalAmount,
            status: BookingStatus.upcoming,
            date: b.date,
            phone: b.phone,
            fullAddress: b.fullAddress,
            distanceKm: b.distanceKm,
          );
        }
        return b;
      }).toList();
      emit(s.copyWith(allBookings: updated));
    }
  }

  void _onRejected(BookingRejected e, Emitter<BookingsState> emit) {
    final s = state;
    if (s is BookingsSuccess) {
      final updated = s.allBookings.where((b) => b.id != e.bookingId).toList();
      emit(s.copyWith(allBookings: updated));
    }
  }
  void _onShiftEnded(
      BookingShiftEnded event,
      Emitter<BookingsState> emit,
      ) {
    final s = state;

    if (s is BookingsSuccess) {
      final updated =
      s.allBookings.map((b) {
        if (b.id == event.bookingId) {
          return Booking(
            id: b.id,
            bookingCode: b.bookingCode,
            clientName: b.clientName,
            serviceType: b.serviceType,
            timeRange: b.timeRange,
            location: b.location,
            totalAmount: b.totalAmount,
            status: BookingStatus.completed,
            date: b.date,
            phone: b.phone,
            fullAddress: b.fullAddress,
            distanceKm: b.distanceKm,
          );
        }

        return b;
      }).toList();

      emit(
        s.copyWith(
          allBookings: updated,
        ),
      );
    }
  }
}
