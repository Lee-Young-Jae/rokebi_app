import 'package:flutter/material.dart';

enum NavItem {
  home,
  cart,
  esim,
  call,
  account,
}

extension NavItemExtension on NavItem {
  String get label {
    switch (this) {
      case NavItem.home:
        return '홈';
      case NavItem.cart:
        return '카트';
      case NavItem.esim:
        return 'eSIM';
      case NavItem.call:
        return '통화';
      case NavItem.account:
        return '내계정';
    }
  }

  IconData get icon {
    switch (this) {
      case NavItem.home:
        return Icons.home_outlined;
      case NavItem.cart:
        return Icons.shopping_cart_outlined;
      case NavItem.esim:
        return Icons.sim_card_outlined;
      case NavItem.call:
        return Icons.phone_outlined;
      case NavItem.account:
        return Icons.person_outlined;
    }
  }

  IconData get activeIcon {
    switch (this) {
      case NavItem.home:
        return Icons.home;
      case NavItem.cart:
        return Icons.shopping_cart;
      case NavItem.esim:
        return Icons.sim_card;
      case NavItem.call:
        return Icons.phone;
      case NavItem.account:
        return Icons.person;
    }
  }

  String get route {
    switch (this) {
      case NavItem.home:
        return '/home';
      case NavItem.cart:
        return '/cart';
      case NavItem.esim:
        return '/esim';
      case NavItem.call:
        return '/call';
      case NavItem.account:
        return '/account';
    }
  }
}