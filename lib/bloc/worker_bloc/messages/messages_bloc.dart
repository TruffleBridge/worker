import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nimora_worker/data/source_data/messages_source_data.dart';
import 'package:nimora_worker/domain/model/view_model/messages_view_model.dart';

// ── Events ────────────────────────────────────────────────────────────────────

abstract class MessagesEvent extends Equatable {
  const MessagesEvent();
  @override
  List<Object?> get props => [];
}

class MessagesLoaded extends MessagesEvent {
  const MessagesLoaded();
}

class MessagesSearchChanged extends MessagesEvent {
  final String query;
  const MessagesSearchChanged(this.query);
  @override
  List<Object?> get props => [query];
}

// ── States ────────────────────────────────────────────────────────────────────

abstract class MessagesState extends Equatable {
  const MessagesState();
  @override
  List<Object?> get props => [];
}

class MessagesInitial extends MessagesState {
  const MessagesInitial();
}

class MessagesLoading extends MessagesState {
  const MessagesLoading();
}

class MessagesSuccess extends MessagesState {
  final List<Conversation> conversations;
  final List<Conversation> filtered;
  final String query;

  const MessagesSuccess({
    required this.conversations,
    required this.filtered,
    this.query = '',
  });

  MessagesSuccess copyWith({
    List<Conversation>? conversations,
    List<Conversation>? filtered,
    String? query,
  }) =>
      MessagesSuccess(
        conversations: conversations ?? this.conversations,
        filtered: filtered ?? this.filtered,
        query: query ?? this.query,
      );

  @override
  List<Object?> get props => [conversations, filtered, query];
}

class MessagesError extends MessagesState {
  final String message;
  const MessagesError(this.message);
  @override
  List<Object?> get props => [message];
}

// ── BLoC ──────────────────────────────────────────────────────────────────────

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  final MessagesDataSource _dataSource;

  MessagesBloc({required this._dataSource})
      : super(const MessagesInitial()) {
    on<MessagesLoaded>(_onLoaded);
    on<MessagesSearchChanged>(_onSearchChanged);
  }

  Future<void> _onLoaded(
      MessagesLoaded e, Emitter<MessagesState> emit) async {
    emit(const MessagesLoading());
    try {
      final convs = await _dataSource.getConversations();
      emit(MessagesSuccess(conversations: convs, filtered: convs));
    } catch (e) {
      emit(MessagesError(e.toString()));
    }
  }

  void _onSearchChanged(
      MessagesSearchChanged e, Emitter<MessagesState> emit) {
    final s = state;
    if (s is MessagesSuccess) {
      final filtered = e.query.isEmpty
          ? s.conversations
          : s.conversations
              .where((c) => c.participantName
                  .toLowerCase()
                  .contains(e.query.toLowerCase()))
              .toList();
      emit(s.copyWith(filtered: filtered, query: e.query));
    }
  }
}
