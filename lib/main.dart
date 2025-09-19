import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/route_generator.dart';
import 'core/routes/app_routes.dart';
import 'core/services/api_service.dart';
import 'core/errors/global_error_handler.dart';

void main() {
  ApiService.initialize();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    // GlobalErrorHandler 초기화
    GlobalErrorHandler.initialize(scaffoldMessengerKey);

    return MaterialApp(
      title: 'Rokebi',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      scaffoldMessengerKey: scaffoldMessengerKey,
      initialRoute: AppRoutes.shell,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
