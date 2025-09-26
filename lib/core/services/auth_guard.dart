import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../routes/app_routes.dart';
import '../../features/auth/viewmodels/auth_view_model.dart';

// ViewModel 상태를 직접 사용
final authGuardProvider = Provider<AuthGuard>((ref) {
  final authState = ref.watch(authViewModelProvider);
  return AuthGuard._(authState.isAuthenticated);
});

class AuthGuard {
  final bool isAuthenticated;

  AuthGuard._(this.isAuthenticated);

  // 라우트 접근 가능 여부 확인
  bool canAccessRoute(String? routeName) {
    if (routeName == null) return true;

    // 인증이 필요한 라우트인데 로그인하지 않은 경우
    if (AppRoutes.requiresAuth(routeName) && !isAuthenticated) {
      return false;
    }

    // 게스트 전용 라우트인데 이미 로그인한 경우
    if (AppRoutes.isGuestOnly(routeName) && isAuthenticated) {
      return false;
    }

    return true;
  }

  // 리다이렉트할 라우트 결정
  String getRedirectRoute(String? attemptedRoute) {
    if (attemptedRoute == null) return AppRoutes.home;

    // 인증이 필요한데 로그인하지 않은 경우 -> 로그인 페이지로
    if (AppRoutes.requiresAuth(attemptedRoute) && !isAuthenticated) {
      return AppRoutes.login;
    }

    // 게스트 전용 라우트인데 이미 로그인한 경우 -> 홈으로
    if (AppRoutes.isGuestOnly(attemptedRoute) && isAuthenticated) {
      return AppRoutes.home;
    }

    return attemptedRoute;
  }
}
