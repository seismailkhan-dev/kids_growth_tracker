// lib/views/ai_insights/ai_insights_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/app_controller.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_widgets.dart';
import '../subscription/subscription_screen.dart';

class AiInsightsScreen extends StatefulWidget {
  final bool embedded;
  const AiInsightsScreen({super.key, this.embedded = false});

  @override
  State<AiInsightsScreen> createState() => _AiInsightsScreenState();
}

class _AiInsightsScreenState extends State<AiInsightsScreen> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  final controller = Get.find<AppController>();

  final _quickPrompts = [
    'Is Emma growing well?',
    'Sleep tips for toddlers',
    'Nutrition for active kids',
    'When next vaccine due?',
  ];

  @override
  void initState() {
    super.initState();
    controller.initChat();
  }

  void _send() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;
    _textController.clear();
    controller.sendMessage(text);
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent + 200, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = widget.embedded ? null : AppBar(title: const Text('AI Buddy'), leading: const BackButton());

    Widget body = Column(
      children: [
        // Header banner
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: AppColors.gradient2,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), shape: BoxShape.circle),
                child: const Center(child: Text('🤖', style: TextStyle(fontSize: 26))),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('GrowBuddy AI', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    Text('Ask me anything about your child\'s health & growth!', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Quick prompts
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: _quickPrompts.map((p) => GestureDetector(
              onTap: () {
                _textController.text = p;
                _send();
              },
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(color: AppColors.pink.withOpacity(0.1), borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.pink.withOpacity(0.3))),
                child: Text(p, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.pink)),
              ),
            )).toList(),
          ),
        ),
        const SizedBox(height: 8),
        // Chat messages
        Expanded(
          child: Obx(() => ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: controller.chatMessages.length + (controller.isAiTyping.value ? 1 : 0),
            itemBuilder: (_, i) {
              if (i == controller.chatMessages.length) {
                return _TypingBubble();
              }
              final msg = controller.chatMessages[i];
              return _ChatBubble(msg: msg);
            },
          )),
        ),
        // Input
        _buildInput(context),
      ],
    );

    if (widget.embedded) {
      return Scaffold(
        appBar: AppBar(title: const Text('AI Buddy')),
        body: body,
      );
    }
    return Scaffold(appBar: appBar, body: body);
  }

  Widget _buildInput(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -2))],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Ask about your child...',
                filled: true,
                fillColor: AppColors.pink.withOpacity(0.05),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onSubmitted: (_) => _send(),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: _send,
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(gradient: AppColors.gradient1, shape: BoxShape.circle),
              child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final Map<String, dynamic> msg;
  const _ChatBubble({required this.msg});

  @override
  Widget build(BuildContext context) {
    final isUser = msg['role'] == 'user';
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(color: AppColors.pink.withOpacity(0.2), shape: BoxShape.circle),
              child: const Center(child: Text('🤖', style: TextStyle(fontSize: 16))),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                gradient: isUser ? AppColors.gradient1 : null,
                color: isUser ? null : AppColors.pink.withOpacity(0.08),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: isUser ? const Radius.circular(16) : Radius.zero,
                  bottomRight: isUser ? Radius.zero : const Radius.circular(16),
                ),
              ),
              child: Text(msg['text'] ?? '', style: TextStyle(color: isUser ? Colors.white : null, fontSize: 14, height: 1.5)),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 8),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(color: AppColors.pink.withOpacity(0.2), shape: BoxShape.circle),
              child: const Center(child: Text('👩', style: TextStyle(fontSize: 16))),
            ),
          ],
        ],
      ),
    );
  }
}

class _TypingBubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(width: 32, height: 32, decoration: BoxDecoration(color: AppColors.pink.withOpacity(0.2), shape: BoxShape.circle), child: const Center(child: Text('🤖', style: TextStyle(fontSize: 16)))),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(color: AppColors.pink.withOpacity(0.08), borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16), bottomRight: Radius.circular(16))),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) => AnimatedContainer(
                duration: Duration(milliseconds: 300 + i * 150),
                margin: const EdgeInsets.symmetric(horizontal: 2),
                width: 6,
                height: 6,
                decoration: BoxDecoration(color: AppColors.pink.withOpacity(0.6), shape: BoxShape.circle),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
