import 'dart:ui' show Color;

import 'package:equatable/equatable.dart';

class Conversation extends Equatable {
  final String id;
  final String participantName;
  final String? avatarUrl;
  final String avatarInitials;
  final Color avatarColor;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final bool isOnline;

  const Conversation({
    required this.id,
    required this.participantName,
    this.avatarUrl,
    required this.avatarInitials,
    required this.avatarColor,
    required this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = 0,
    this.isOnline = false,
  });

  @override
  List<Object?> get props => [id, unreadCount];
}
