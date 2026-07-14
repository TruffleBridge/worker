import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/messages/client_chat_widget.dart';

import '../../../../bloc/client_bloc/messages/client_messages_bloc.dart';
import '../../../../bloc/client_bloc/messages/client_messages_event.dart';
import '../../../../bloc/client_bloc/messages/client_messages_state.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../domain/model/view_model/messages_view_model.dart';
import '../../components/home_app_bar.dart';

class ClientMessagesWidget extends StatelessWidget {
  const ClientMessagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const HomeAppBar(),
      body: Column(
        children: [
          _SearchBar(),
          Expanded(
            child:  BlocBuilder<ClientMessagesBloc, ClientMessagesState>(
              builder: (context, state) {
                if (state is ClientMessagesLoading || state is ClientMessagesInitial) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }
                if (state is ClientMessagesError) {
                  return Center(child: Text(state.message));
                }
                if (state is ClientMessagesSuccess) {
                  if (state.filtered.isEmpty) {
                    return _EmptyMessages();
                  }
                  return _ConversationList(conversations: state.filtered);
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.paddingL,
        AppDimensions.paddingM,
        AppDimensions.paddingL,
        0,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.grey100,
                borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
                border: Border.all(color: AppColors.grey200),
              ),
              child: TextField(
                onChanged: (v) =>
                    context.read<ClientMessagesBloc>().add(ClientMessagesSearchChanged(v)),
                style: NdisThemeStyle.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: 'Ask AI or Search',
                  hintStyle: NdisThemeStyle.bodyMedium.copyWith(
                    color: AppColors.textHint,
                    fontSize: 13,
                  ),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: AppColors.grey400,
                    size: 18,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.grey100,
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              border: Border.all(color: AppColors.grey200),
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/images/filter_icon.svg',
                height: 24,
                width: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConversationList extends StatelessWidget {
  final List<Conversation> conversations;

  const _ConversationList({required this.conversations});

  String _timeLabel(DateTime t) {
    final now = DateTime.now();
    final diff = now.difference(t);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    return '${diff.inDays}d';
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: AppDimensions.paddingM),
      itemCount: conversations.length,
      separatorBuilder: (_, __) =>
      const Divider(height: 1, indent: 76, color: AppColors.grey200),
      itemBuilder: (ctx, i) {
        final conv = conversations[i];
        return _ConversationTile(
          conversation: conv,
          timeLabel: _timeLabel(conv.lastMessageTime),
          onTap: () => Navigator.of(ctx).push(
            MaterialPageRoute(builder: (_) => ClientChatWidget(conversation: conv)),
          ),
        );
      },
    );
  }
}

class _ConversationTile extends StatelessWidget {
  final Conversation conversation;
  final String timeLabel;
  final VoidCallback onTap;

  const _ConversationTile({
    required this.conversation,
    required this.timeLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingL,
          vertical: AppDimensions.paddingM,
        ),
        child: Row(
          children: [
            // Avatar
            Stack(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Color(conversation.avatarColor.toARGB32()),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      conversation.avatarInitials,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                if (conversation.isOnline)
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981),
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conversation.participantName,
                          style: NdisThemeStyle.bodyMedium.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Text(
                        timeLabel,
                        style: NdisThemeStyle.bodyMedium.copyWith(
                          fontSize: 12,
                          color: conversation.unreadCount > 0
                              ? AppColors.primary
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conversation.lastMessage,
                          style: NdisThemeStyle.bodyMedium.copyWith(
                            fontSize: 13,
                            color: conversation.unreadCount > 0
                                ? AppColors.textPrimary
                                : AppColors.textSecondary,
                            fontWeight: conversation.unreadCount > 0
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (conversation.unreadCount > 0) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${conversation.unreadCount}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyMessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingXXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.grey100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.chat_bubble_outline_rounded,
                size: 48,
                color: AppColors.grey400,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingL),
            Text('No messages', style: NdisThemeStyle.headlineMedium),
            const SizedBox(height: AppDimensions.paddingS),
            Text(
              'Your conversations will appear here',
              style: NdisThemeStyle.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.paddingXL),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                elevation: 0,
              ),
              child: const Text(
                'Add Message',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
