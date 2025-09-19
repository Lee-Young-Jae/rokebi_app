import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../models/nav_item.dart';
import '../widgets/app_bottom_navigation_bar.dart';
import '../../products/pages/product_list_page.dart';
import '../pages/cart_page.dart';
import '../pages/esim_page.dart';
import '../pages/call_page.dart';
import '../pages/account_page.dart';

class MainShellPage extends StatefulWidget {
  final String? initialRoute;

  const MainShellPage({super.key, this.initialRoute});

  @override
  State<MainShellPage> createState() => _MainShellPageState();
}

class _MainShellPageState extends State<MainShellPage> {
  NavItem _currentItem = NavItem.home;

  @override
  void initState() {
    super.initState();
    _setInitialRoute();
  }

  void _setInitialRoute() {
    if (widget.initialRoute != null) {
      switch (widget.initialRoute) {
        case AppRoutes.home:
          _currentItem = NavItem.home;
          break;
        case AppRoutes.cart:
          _currentItem = NavItem.cart;
          break;
        case AppRoutes.esim:
          _currentItem = NavItem.esim;
          break;
        case AppRoutes.call:
          _currentItem = NavItem.call;
          break;
        case AppRoutes.account:
          _currentItem = NavItem.account;
          break;
        default:
          _currentItem = NavItem.home;
      }
    }
  }

  void _onItemSelected(NavItem item) {
    if (_currentItem != item) {
      setState(() {
        _currentItem = item;
      });
    }
  }

  Widget _buildPage(NavItem item) {
    switch (item) {
      case NavItem.home:
        return const ProductListPage();
      case NavItem.cart:
        return const CartPage();
      case NavItem.esim:
        return const ESimPage();
      case NavItem.call:
        return const CallPage();
      case NavItem.account:
        return const AccountPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: IndexedStack(
        index: _currentItem.index,
        children: NavItem.values.map(_buildPage).toList(),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentItem: _currentItem,
        onItemSelected: _onItemSelected,
      ),
    );
  }
}