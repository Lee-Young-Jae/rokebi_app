import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_router.dart';
import 'core/services/api_service.dart';
import 'core/errors/global_error_handler.dart';

void main() {
  ApiService.initialize();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // GoRouter 가져오기
    final router = ref.watch(routerProvider);

    // GlobalErrorHandler 초기화
    GlobalErrorHandler.initialize(scaffoldMessengerKey);

    return MaterialApp.router(
      title: 'Rokebi',
      theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme,
      scaffoldMessengerKey: scaffoldMessengerKey,
      routerConfig: router,
    );
  }
}
