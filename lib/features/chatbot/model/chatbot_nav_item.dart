import 'package:flutter/material.dart';

enum ChatbotNavItem { home, chat, setting }

extension ChatbotNavItemExtension on ChatbotNavItem {
  String get label {
    switch (this) {
      case ChatbotNavItem.home:
        return '홈';
      case ChatbotNavItem.chat:
        return '대화';
      case ChatbotNavItem.setting:
        return '설정';
    }
  }

  IconData get icon {
    switch (this) {
      case ChatbotNavItem.home:
        return Icons.home_outlined;
      case ChatbotNavItem.chat:
        return Icons.chat;
      case ChatbotNavItem.setting:
        return Icons.settings_outlined;
    }
  }

  IconData get activeIcon {
    switch (this) {
      case ChatbotNavItem.home:
        return Icons.home;
      case ChatbotNavItem.chat:
        return Icons.chat;
      case ChatbotNavItem.setting:
        return Icons.phone;
    }
  }

  String get route {
    switch (this) {
      case ChatbotNavItem.home:
        return '/home';
      case ChatbotNavItem.chat:
        return '/chat';
      case ChatbotNavItem.setting:
        return '/setting';
    }
  }
}
