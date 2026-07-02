import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class AiAssistantPage extends StatefulWidget {
  const AiAssistantPage({super.key});

  @override
  State<AiAssistantPage> createState() => _AiAssistantPageState();
}

class _AiAssistantPageState extends State<AiAssistantPage> {
  final TextEditingController _controller = TextEditingController();

  bool hasMessages = false;

  final List<Map<String, dynamic>> messages = [];

  void sendMessage() {
    if (_controller.text.trim().isEmpty) {
      return;
    }

    setState(() {
      hasMessages = true;

      messages.add({'isUser': true, 'text': _controller.text});

      messages.add({
        'isUser': false,
        'text': 'I can help you with that. Please share more details.',
      });
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.appbarBackground,
        surfaceTintColor: Colors.transparent,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
        ),

        title: Text(
          'AI Assistant',
          style: NdisThemeStyle.displayLarge.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),

        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined)),

          const SizedBox(width: 10),
        ],
      ),

      body: Column(
        children: [
          Expanded(child: hasMessages ? _buildMessages() : _buildEmptyState()),

          _buildQuickActions(),

          _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/ai_container.jpg'),

          const SizedBox(height: 24),

          Text(
            'Welcome to AI Assistant',
            style: NdisThemeStyle.displayLarge.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Start a conversation or use a quick action below',
            style: NdisThemeStyle.bodyLarge.copyWith(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildMessages() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];

        final isUser = message['isUser'];

        return Align(
          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(14),
            constraints: const BoxConstraints(maxWidth: 280),
            decoration: BoxDecoration(
              color: isUser ? AppColors.primary : const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(
              message['text'],
              style: TextStyle(
                color: isUser ? Colors.white : Colors.black,
                height: 1.5,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickActions() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          _QuickActionChip(title: 'Submit Shift Note'),

          _QuickActionChip(title: 'Check Client Info'),

          _QuickActionChip(title: 'Compliance Reminder'),

          _QuickActionChip(title: 'Training Resources'),
        ],
      ),
    );
  }

  Widget _buildInputBar() {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Type your message...',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            GestureDetector(
              onTap: sendMessage,
              child: Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFAD95FB),
                      Color(0xFF5E40A6),
                      Color(0xFFC057DD),
                    ],
                  ),
                ),
                child: const Icon(Icons.send_rounded, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionChip extends StatelessWidget {
  final String title;

  const _QuickActionChip({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Text(
        title,
        style: NdisThemeStyle.displayLarge.copyWith(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
