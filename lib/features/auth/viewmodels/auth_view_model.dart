import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/auth_state.dart';
import '../repositories/auth_repository.dart';
import '../services/token_service.dart';

// Repository Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return HttpAuthRepository();
});

// Token Service Provider
final tokenServiceProvider = Provider<TokenService>((ref) {
  return TokenService();
});

// Auth ViewModel Provider
final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>((
  ref,
) {
  return AuthViewModel(
    repository: ref.watch(authRepositoryProvider),
    tokenService: ref.watch(tokenServiceProvider),
  );
});

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthRepository _repository;
  final TokenService _tokenService;

  AuthViewModel({
    required AuthRepository repository,
    required TokenService tokenService,
  }) : _repository = repository,
       _tokenService = tokenService,
       super(const AuthState()) {
    // 앱 시작시 자동 로그인 체크
    _checkAuthStatus();
  }

  // 초기 인증 상태 확인
  Future<void> _checkAuthStatus() async {
    try {
      state = state.copyWith(isLoading: true);

      // 저장된 토큰 확인
      final accessToken = await _tokenService.getAccessToken();
      final refreshToken = await _tokenService.getRefreshToken();

      if (accessToken != null && refreshToken != null) {
        // 토큰 만료 여부 확인
        final isExpired = await _tokenService.isTokenExpired();

        if (isExpired) {
          // 토큰이 만료된 경우 자동 갱신 시도
          final refreshSuccess = await refreshAuth();
          if (!refreshSuccess) {
            await _clearAuthData();
            state = state.copyWith(isLoading: false);
            return;
          }
        }

        // 토큰이 유효하면 사용자 정보 가져오기
        final user = await _repository.getCurrentUser();

        if (user != null) {
          state = state.copyWith(
            isAuthenticated: true,
            user: user,
            accessToken: await _tokenService.getAccessToken(),
            refreshToken: await _tokenService.getRefreshToken(),
            isLoading: false,
          );
        } else {
          // 토큰은 있지만 유저 정보를 못가져온 경우
          await _clearAuthData();
        }
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // 로그인
  Future<bool> login({required String email, required String password}) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final response = await _repository.login(
        email: email,
        password: password,
      );

      // 토큰 저장
      await _tokenService.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
        expiresAt: response.expiresIn != null
            ? DateTime.now().add(Duration(seconds: response.expiresIn!))
            : DateTime.now().add(const Duration(hours: 1)),
      );

      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        user: response.user,
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );

      return true;
    } catch (e) {
      // 로그인 실패시 저장된 토큰 모두 삭제
      await _tokenService.clearTokens();

      String errorMessage;
      if (e.toString().contains('DioException')) {
        final errorStart = e.toString().indexOf('message: ') + 9;
        if (errorStart > 8) {
          final errorEnd = e.toString().indexOf(',', errorStart);
          errorMessage = e.toString().substring(
            errorStart,
            errorEnd > 0 ? errorEnd : e.toString().length,
          );
        } else {
          errorMessage = '로그인에 실패했습니다. 이메일과 비밀번호를 확인해주세요.';
        }
      } else {
        errorMessage = e.toString();
      }

      state = state.copyWith(
        isLoading: false,
        error: errorMessage,
        isAuthenticated: false, // 인증 실패 상태로 설정
        user: null,
        accessToken: null,
        refreshToken: null,
      );
      return false;
    }
  }

  // 회원가입
  Future<bool> register({
    required String email,
    required String password,
    String? name,
    String? phoneNumber,
  }) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final response = await _repository.register(
        email: email,
        password: password,
        name: name,
        phoneNumber: phoneNumber,
      );

      // 토큰 저장
      await _tokenService.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
        expiresAt: response.expiresIn != null
            ? DateTime.now().add(Duration(seconds: response.expiresIn!))
            : DateTime.now().add(const Duration(hours: 1)),
      );

      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        user: response.user,
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );

      return true;
    } catch (e) {
      // 회원가입을 실패하면 저장된 토큰 모두 삭제
      await _tokenService.clearTokens();

      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        isAuthenticated: false,
        user: null,
        accessToken: null,
        refreshToken: null,
      );
      return false;
    }
  }

  // 로그아웃
  Future<void> logout() async {
    try {
      state = state.copyWith(isLoading: true);

      await _repository.logout();
      await _clearAuthData();

      state = const AuthState(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // 토큰 리프레시
  Future<bool> refreshAuth() async {
    try {
      final refreshToken =
          state.refreshToken ?? await _tokenService.getRefreshToken();
      if (refreshToken == null) return false;

      final response = await _repository.refreshToken(refreshToken);

      await _tokenService.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
        expiresAt: response.expiresIn != null
            ? DateTime.now().add(Duration(seconds: response.expiresIn!))
            : DateTime.now().add(const Duration(hours: 1)),
      );

      state = state.copyWith(
        user: response.user,
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );

      return true;
    } catch (e) {
      await _clearAuthData();
      return false;
    }
  }

  // 비밀번호 재설정 이메일 전송
  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      await _repository.sendPasswordResetEmail(email);

      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  // 리다이렉트 라우트 설정
  void setRedirectRoute(String? route) {
    state = state.copyWith(redirectRoute: route);
  }

  // 토큰 데이터 초기화
  Future<void> _clearAuthData() async {
    await _tokenService.clearTokens();
    state = const AuthState();
  }

  // 에러 설정
  void setError(String error) {
    state = state.copyWith(
      error: error,
      isLoading: false,
      isAuthenticated: false,
    );
  }

  // 에러 초기화
  void clearError() {
    state = state.copyWith(error: null);
  }
}
