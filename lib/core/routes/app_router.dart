import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rokebi_app/features/m_mobile/pages/sub_home.dart';
import 'app_routes.dart';
import '../../features/auth/viewmodels/auth_view_model.dart';
import '../../features/auth/pages/login_page.dart';
import '../../features/auth/pages/register_page.dart';
import '../../features/products/pages/product_detail_page.dart';
import '../../features/design_system/pages/design_system_showcase.dart';
import '../../features/cart/viewmodels/cart_view_model.dart';
import '../widgets/chatbot_floating_button.dart';

// Listenable 클래스를 만들어 상태 변경을 감지
class AuthStateNotifier extends ChangeNotifier {
  AuthStateNotifier(this.ref) {
    // authViewModelProvider를 구독하여 변경사항 감지
    ref.listen(authViewModelProvider, (previous, next) {
      notifyListeners();
    });
  }

  final Ref ref;
}

// GoRouter Provider
final routerProvider = Provider<GoRouter>((ref) {
  final authStateNotifier = AuthStateNotifier(ref);

  return GoRouter(
    initialLocation: '/home',
    debugLogDiagnostics: true,
    refreshListenable: authStateNotifier, // 상태 변경시 GoRouter가 redirect를 재실행
    // 리다이렉트 로직
    redirect: (context, state) {
      final authState = ref.read(authViewModelProvider); // read로 변경
      final isAuthenticated = authState.isAuthenticated;
      final path = state.matchedLocation;

      // 인증이 필요한 경로
      final requiresAuth = AppRoutes.requiresAuth(path);
      final isGuestOnly = AppRoutes.isGuestOnly(path);

      // 인증이 필요한데 로그인하지 않은 경우
      if (requiresAuth && !isAuthenticated) {
        return '/login?from=${Uri.encodeComponent(path)}';
      }

      // 이미 로그인했는데 게스트 전용 페이지 접근
      // 단, 로딩 중이거나 에러가 있는 경우는 리다이렉트하지 않음
      if (isGuestOnly &&
          isAuthenticated &&
          !authState.isLoading &&
          authState.error == null) {
        return '/home';
      }

      return null; // 정상 진행
    },

    routes: [
      // 바텀 네비게이션
      ShellRoute(
        builder: (context, state, child) => ScaffoldWithNavBar(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            name: AppRoutes.home,
            builder: (context, state) =>
                const MainShellContent(route: AppRoutes.home),
          ),
          GoRoute(
            path: AppRoutes.productList,
            name: AppRoutes.productList,
            builder: (context, state) => const MainShellContent(
              route: AppRoutes.home,
            ), // 일단 Product로 들어와도 홈을 보여준다.
          ),
          GoRoute(
            path: AppRoutes.esim,
            name: AppRoutes.esim,
            builder: (context, state) =>
                const MainShellContent(route: AppRoutes.esim),
          ),
          GoRoute(
            path: AppRoutes.call,
            name: AppRoutes.call,
            builder: (context, state) =>
                const MainShellContent(route: AppRoutes.call),
          ),
          GoRoute(
            path: AppRoutes.cart,
            name: AppRoutes.cart,
            builder: (context, state) =>
                const MainShellContent(route: AppRoutes.cart),
          ),
          GoRoute(
            path: AppRoutes.account,
            name: AppRoutes.account,
            builder: (context, state) =>
                const MainShellContent(route: AppRoutes.account),
          ),
          GoRoute(
            path: AppRoutes.contacts,
            name: AppRoutes.contacts,
            builder: (context, state) =>
                const MainShellContent(route: AppRoutes.contacts),
          ),
        ],
      ),

      // 독립 라우트들
      GoRoute(
        path: AppRoutes.login,
        name: AppRoutes.login,
        pageBuilder: (context, state) {
          final from = state.uri.queryParameters['from'];
          return NoTransitionPage(
            child: _ConditionalChatbotWrapper(
              routeName: AppRoutes.login,
              child: LoginPage(redirectPath: from),
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.register,
        name: AppRoutes.register,
        pageBuilder: (context, state) => NoTransitionPage(
          child: _ConditionalChatbotWrapper(
            routeName: AppRoutes.register,
            child: const RegisterPage(),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        name: AppRoutes.forgotPassword,
        builder: (context, state) => _ConditionalChatbotWrapper(
          routeName: AppRoutes.forgotPassword,
          child: const Placeholder(),
        ),
      ),
      GoRoute(
        path: AppRoutes.productDetail,
        name: AppRoutes.productDetail,
        builder: (context, state) {
          final productId = state.pathParameters['id']!;
          return _ConditionalChatbotWrapper(
            routeName: AppRoutes.productDetail,
            child: ProductDetailPage(productId: productId),
          );
        },
      ),
      GoRoute(
        path: '/design-system',
        name: AppRoutes.designSystem,
        builder: (context, state) => _ConditionalChatbotWrapper(
          routeName: AppRoutes.designSystem,
          child: const DesignSystemShowcase(),
        ),
      ),
      GoRoute(
        path: AppRoutes.mMobile,
        name: AppRoutes.mMobile,
        builder: (context, state) => const MMobilePage(),
      ),
    ],

    // 에러 페이지
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              '404: Route not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Path: ${state.matchedLocation}',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              child: const Text('홈으로 이동'),
            ),
          ],
        ),
      ),
    ),
  );
});

// 바텀 네비게이션이 있는 Scaffold
class ScaffoldWithNavBar extends ConsumerWidget {
  final Widget child;

  const ScaffoldWithNavBar({required this.child, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPath = GoRouterState.of(context).matchedLocation;
    final cart = ref.watch(cartViewModelProvider);

    // 카트 페이지이고 아이템이 있으면 네비게이션 숨김
    final shouldHideNavigation =
        currentPath.startsWith('/cart') && cart.items.isNotEmpty;

    return CupertinoScaffold(
      body: Scaffold(
        body: child,
        floatingActionButton: AppRoutes.shouldShowChatbot(currentPath)
            ? const ChatbotFloatingButton()
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: shouldHideNavigation
            ? null
            : BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: _calculateSelectedIndex(currentPath),
                onTap: (index) => _onItemTapped(index, context),
                items: [
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: '홈',
                  ),
                  BottomNavigationBarItem(
                    icon: _buildCartIcon(cart.items.length),
                    label: '카트',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.sim_card),
                    label: 'eSIM',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.phone),
                    label: '통화',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: '내계정',
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildCartIcon(int itemCount) {
    if (itemCount == 0) {
      return const Icon(Icons.shopping_cart);
    }

    return Badge(
      label: Text(
        itemCount > 99 ? '99+' : itemCount.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.red,
      child: const Icon(Icons.shopping_cart),
    );
  }

  int _calculateSelectedIndex(String location) {
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/cart')) return 1;
    if (location.startsWith('/esim')) return 2;
    if (location.startsWith('/call')) return 3;
    if (location.startsWith('/account')) return 4;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/cart');
        break;
      case 2:
        context.go('/esim');
        break;
      case 3:
        context.go('/call');
        break;
      case 4:
        context.go('/account');
        break;
    }
  }
}

// MainShell 내용을 표시하는 위젯
class MainShellContent extends StatelessWidget {
  final String route;

  const MainShellContent({required this.route, super.key});

  @override
  Widget build(BuildContext context) {
    // AppRoutes의 매핑을 사용하여 위젯 반환
    return AppRoutes.getShellRouteWidget(route);
  }
}

// 조건부 챗봇 래퍼 위젯
class _ConditionalChatbotWrapper extends StatelessWidget {
  final Widget child;
  final String routeName;

  const _ConditionalChatbotWrapper({
    required this.child,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    if (AppRoutes.shouldShowChatbot(routeName)) {
      return CupertinoScaffold(
        body: Scaffold(
          body: child,
          floatingActionButton: const ChatbotFloatingButton(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ),
      );
    }
    return CupertinoScaffold(body: child);
  }
}
