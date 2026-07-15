import 'package:equatable/equatable.dart';

abstract class ClientMessagesEvent extends Equatable {
  const ClientMessagesEvent();
  @override
  List<Object?> get props => [];
}

class ClientMessagesLoaded extends ClientMessagesEvent {
  const ClientMessagesLoaded();
}

class ClientMessagesSearchChanged extends ClientMessagesEvent {
  final String query;
  const ClientMessagesSearchChanged(this.query);
  @override
  List<Object?> get props => [query];
}