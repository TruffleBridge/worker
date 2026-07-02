import 'package:flutter/material.dart';
import 'package:nimora_worker/domain/model/view_model/messages_view_model.dart';

abstract class MessagesDataSource {
  Future<List<Conversation>> getConversations();
}

class MessagesDataSourceImpl implements MessagesDataSource {
  @override
  Future<List<Conversation>> getConversations() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _mockConversations;
  }

  static final List<Conversation> _mockConversations = [
    Conversation(
      id: 'conv_001',
      participantName: 'Mrs. Anderson',
      avatarInitials: 'MA',
      avatarColor: const Color(0xFF9C27B0),
      lastMessage: 'Thank you for today\'s help',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
      unreadCount: 2,
      isOnline: true,
    ),
    Conversation(
      id: 'conv_002',
      participantName: 'Mr. Thompson',
      avatarInitials: 'MT',
      avatarColor: const Color(0xFF2196F3),
      lastMessage: 'Running a bit late today',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
      unreadCount: 0,
      isOnline: false,
    ),
    Conversation(
      id: 'conv_003',
      participantName: 'Mrs. Chen',
      avatarInitials: 'MC',
      avatarColor: const Color(0xFF4CAF50),
      lastMessage: 'Can we add an extra session?',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 3)),
      unreadCount: 1,
      isOnline: true,
    ),
    Conversation(
      id: 'conv_004',
      participantName: 'Mr. Davis',
      avatarInitials: 'MD',
      avatarColor: const Color(0xFFFF9800),
      lastMessage: 'Looking forward to our visit',
      lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
      unreadCount: 0,
      isOnline: false,
    ),
    Conversation(
      id: 'conv_005',
      participantName: 'Mrs. Rodriguez',
      avatarInitials: 'MR',
      avatarColor: const Color(0xFFE91E63),
      lastMessage: 'The medication is ready',
      lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
      unreadCount: 0,
      isOnline: false,
    ),
    Conversation(
      id: 'conv_006',
      participantName: 'Care Team',
      avatarInitials: 'CT',
      avatarColor: const Color(0xFF607D8B),
      lastMessage: 'Schedule updates for next week',
      lastMessageTime: DateTime.now().subtract(const Duration(days: 2)),
      unreadCount: 3,
      isOnline: true,
    ),
  ];
}
