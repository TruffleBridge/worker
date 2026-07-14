
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/source_data/messages_source_data.dart';
import 'client_messages_event.dart';
import 'client_messages_state.dart';

class ClientMessagesBloc extends Bloc<ClientMessagesEvent, ClientMessagesState> {
  final MessagesDataSource dataSource;

  ClientMessagesBloc({required this.dataSource})
      : super(const ClientMessagesInitial()) {
    on<ClientMessagesLoaded>(_onLoaded);
    on<ClientMessagesSearchChanged>(_onSearchChanged);
  }

  Future<void> _onLoaded(
      ClientMessagesLoaded e, Emitter<ClientMessagesState> emit) async {
    emit(const ClientMessagesLoading());
    try {
      final convs = await dataSource.getConversations();
      emit(ClientMessagesSuccess(conversations: convs, filtered: convs));
    } catch (e) {
      emit(ClientMessagesError(e.toString()));
    }
  }

  void _onSearchChanged(
      ClientMessagesSearchChanged e, Emitter<ClientMessagesState> emit) {
    final s = state;
    if (s is ClientMessagesSuccess) {
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