import 'package:flutter/material.dart';
import 'app_routes.dart';
import '../../features/products/pages/product_detail_page.dart';
import '../../features/design_system/pages/design_system_showcase.dart';
import '../../features/navigation/pages/main_shell_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Shell route (바텀 네비게이션이 존재하는 라우터들)
      case AppRoutes.shell:
      case AppRoutes.home:
      case AppRoutes.cart:
      case AppRoutes.esim:
      case AppRoutes.call:
      case AppRoutes.account:
        return MaterialPageRoute(
          builder: (_) =>
              MainShellPage(initialRoute: settings.name ?? AppRoutes.home),
          settings: settings,
        );

      // Auth routes
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(),
          settings: settings,
        );

      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(),
          settings: settings,
        );

      case AppRoutes.forgotPassword:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(),
          settings: settings,
        );

      // Main app routes
      case AppRoutes.profile:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(),
          settings: settings,
        );

      case AppRoutes.settings:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(),
          settings: settings,
        );

      case AppRoutes.productDetail:
        final productId = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => ProductDetailPage(productId: productId ?? '1'),
          settings: settings,
        );

      case AppRoutes.checkout:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(),
          settings: settings,
        );

      // Order routes
      case AppRoutes.orders:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(),
          settings: settings,
        );

      case AppRoutes.orderDetail:
        // final orderId = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => const Placeholder(),
          settings: settings,
        );

      // Other routes
      case AppRoutes.search:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(),
          settings: settings,
        );

      case AppRoutes.notifications:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(),
          settings: settings,
        );

      case AppRoutes.help:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(),
          settings: settings,
        );

      case AppRoutes.designSystem:
        return MaterialPageRoute(
          builder: (_) => const DesignSystemShowcase(),
          settings: settings,
        );

      // Unknown route
      default:
        return _errorRoute(settings.name);
    }
  }

  static Route<dynamic> _errorRoute(String? routeName) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
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
                routeName ?? '404: Unknown route',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(AppRoutes.home, (route) => false),
                child: const Text('홈으로 이동'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
