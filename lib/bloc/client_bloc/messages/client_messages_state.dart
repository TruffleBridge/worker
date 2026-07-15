
import 'package:equatable/equatable.dart';

import '../../../domain/model/view_model/messages_view_model.dart';

abstract class ClientMessagesState extends Equatable {
  const ClientMessagesState();
  @override
  List<Object?> get props => [];
}

class ClientMessagesInitial extends ClientMessagesState {
  const ClientMessagesInitial();
}

class ClientMessagesLoading extends ClientMessagesState {
  const ClientMessagesLoading();
}

class ClientMessagesSuccess extends ClientMessagesState {
  final List<Conversation> conversations;
  final List<Conversation> filtered;
  final String query;

  const ClientMessagesSuccess({
    required this.conversations,
    required this.filtered,
    this.query = '',
  });

  ClientMessagesSuccess copyWith({
    List<Conversation>? conversations,
    List<Conversation>? filtered,
    String? query,
  }) =>
      ClientMessagesSuccess(
        conversations: conversations ?? this.conversations,
        filtered: filtered ?? this.filtered,
        query: query ?? this.query,
      );

  @override
  List<Object?> get props => [conversations, filtered, query];
}

class ClientMessagesError extends ClientMessagesState {
  final String message;
  const ClientMessagesError(this.message);
  @override
  List<Object?> get props => [message];
}