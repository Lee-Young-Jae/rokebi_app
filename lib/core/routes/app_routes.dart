import 'package:flutter/widgets.dart';
import '../../features/products/pages/product_list_page.dart';
import '../../features/cart/pages/cart_page.dart';
import '../../features/navigation/pages/esim_page.dart';
import '../../features/call/pages/call_page.dart';
import '../../features/call/pages/contacts_page.dart';
import '../../features/account/pages/account_page.dart';

class AppRoutes {
  // Shell route (with bottom navigation)
  static const String shell = '/';

  // 메인 탭 라우트 (within shell)
  static const String home = '/home';
  static const String cart = '/cart';
  static const String esim = '/esim';
  static const String call = '/call';
  static const String account = '/account';

  // Auth - 추후 수정할 수도
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  // Other
  static const String profile = '/profile';
  static const String settings = '/settings';

  // Product routes
  static const String productList = '/products';
  static const String productDetail = '/product/:id';
  static const String checkout = '/checkout';

  // Order
  static const String orders = '/orders';
  static const String orderDetail = '/order';

  // Other
  static const String search = '/search';
  static const String notifications = '/notifications';
  static const String help = '/help';
  static const String designSystem = '/design-system';
  static const String contacts = '/call/contacts';

  // 바텀 네비게이션 포함하는 라우트
  static List<String> get shellRoutes => [home, esim, call, account, contacts];

  // 바텀 네비게이션 포함하지 않는 라우트
  static List<String> get standaloneRoutes => [
    login,
    register,
    forgotPassword,
    profile,
    settings,
    productList,
    productDetail,
    checkout,
    orders,
    orderDetail,
    search,
    notifications,
    help,
    designSystem,
  ];

  // 챗봇 X 페이지
  static Set<String> get chatbotDisabledRoutes => {
    login,
    register,
    forgotPassword,
    checkout,
    call,
    designSystem,
  };

  // 인증이 필요한 라우트
  static Set<String> get authRequiredRoutes => {
    profile,
    settings,
    checkout,
    orders,
    orderDetail,
    account,
    esim,
    call,
  };

  // 로그인한 유저는 접근 불가 라우트 (이미 로그인한 경우 홈으로 리다이렉트)
  static Set<String> get guestOnlyRoutes => {login, register, forgotPassword};

  // 선택적 인증 라우트 (게스트도 접근 가능하지만 로그인시 더 많은 기능)
  static Set<String> get optionalAuthRoutes => {
    cart, // 장바구니는 게스트도 이용 가능
    productList,
    productDetail,
    search,
  };

  // chatbot floating 표시 여부
  static bool shouldShowChatbot(String? routeName) {
    if (routeName == null) return false;

    // 비활성화 목록에 있으면 false, 없으면 true
    return !chatbotDisabledRoutes.contains(routeName);
  }

  // 인증 필요 여부 확인
  static bool requiresAuth(String? routeName) {
    if (routeName == null) return false;
    return authRequiredRoutes.contains(routeName);
  }

  // 게스트 전용 라우트 확인
  static bool isGuestOnly(String? routeName) {
    if (routeName == null) return false;
    return guestOnlyRoutes.contains(routeName);
  }

  // 라우트별 위젯 매핑
  static final Map<String, Widget> shellRouteWidgets = {
    home: const ProductListPage(),
    cart: const CartPage(),
    esim: const ESimPage(),
    call: const CallPage(),
    account: const AccountPage(),
    contacts: const ContactsPage(),
  };

  // 라우트에 해당하는 위젯 반환
  static Widget getShellRouteWidget(String route) {
    return shellRouteWidgets[route] ?? const ProductListPage();
  }

  // Get all routes as a list
  static List<String> get allRoutes => [
    shell,
    ...shellRoutes,
    ...standaloneRoutes,
  ];
}
