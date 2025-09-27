import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rokebi_app/features/chatbot/pages/channel_talk_page.dart';

/// 독립적으로 사용 가능한 챗봇 플로팅 버튼
///
/// 사용 예시:
/// ```dart
/// Scaffold(
///   appBar: AppBar(...),
///   body: ...,
///   floatingActionButton: const ChatbotFloatingButton(),
/// )
/// ```
class ChatbotFloatingButton extends StatelessWidget {
  final bool isVisible;
  final VoidCallback? onPressed;

  const ChatbotFloatingButton({
    super.key,
    this.isVisible = true,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();

    return FloatingActionButton(
      onPressed: onPressed ?? () => _showChatbot(context),
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/icons/floating_rokebi-1.webp',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void _showChatbot(BuildContext context) {
    CupertinoScaffold.showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => const ChannelTalkPage(),
      expand: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isDismissible: true,
      bounce: true,
      animationCurve: Curves.easeInOut,
      duration: const Duration(milliseconds: 400),
    );
  }
}
