import 'package:freezed_annotation/freezed_annotation.dart';
import 'user_model.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool isLoading,
    @Default(false) bool isAuthenticated,
    User? user,
    String? accessToken,
    String? refreshToken,
    String? error,
    // 리다이렉트할 라우트 (로그인 후 원래 가려던 곳으로)
    String? redirectRoute,
  }) = _AuthState;

  const AuthState._();

  // 편의 메서드들
  bool get hasError => error != null;
  bool get isGuest => !isAuthenticated;
}
