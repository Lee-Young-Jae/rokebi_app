import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rokebi_app/core/constants/app_spacing.dart';
import '../widgets/chatbot_floating_button.dart';

/// 챗봇 플로팅 버튼을 추가하는 PageRoute
class ChatbotPageRoute extends MaterialWithModalsPageRoute {
  final bool showChatbot;

  ChatbotPageRoute({
    required WidgetBuilder builder,
    super.settings,
    this.showChatbot = true,
    super.maintainState = true,
    super.fullscreenDialog = false,
  }) : super(
         builder: (context) =>
             _ChatbotWrapper(showChatbot: showChatbot, child: builder(context)),
       );
}

/// CupertinoScaffold와 플로팅 버튼을 자동으로 래핑하는 위젯
class _ChatbotWrapper extends StatelessWidget {
  final Widget child;
  final bool showChatbot;

  const _ChatbotWrapper({required this.child, required this.showChatbot});

  @override
  Widget build(BuildContext context) {
    // Scaffold가 있는지 확인
    return CupertinoScaffold(
      body: Builder(
        builder: (context) => Stack(
          children: [
            child,
            if (showChatbot)
              Positioned(
                right: AppSpacing.xxl,
                bottom:
                    AppSpacing.xxxxl +
                    AppSpacing.xxxxl +
                    MediaQuery.of(context).padding.bottom,
                child: const ChatbotFloatingButton(),
              ),
          ],
        ),
      ),
    );
  }
}
