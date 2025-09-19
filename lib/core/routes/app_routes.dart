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
  static const String productDetail = '/product';
  static const String checkout = '/checkout';

  // Order
  static const String orders = '/orders';
  static const String orderDetail = '/order';

  // Other
  static const String search = '/search';
  static const String notifications = '/notifications';
  static const String help = '/help';
  static const String designSystem = '/design-system';

  // 바텀 네비게이션 포함하는 라우트
  static List<String> get shellRoutes => [home, cart, esim, call, account];

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

  // Get all routes as a list
  static List<String> get allRoutes => [
    shell,
    ...shellRoutes,
    ...standaloneRoutes,
  ];
}
