import '../models/user_model.dart';
import '../models/auth_response.dart';
import '../../../core/services/api_service.dart';
import '../services/token_service.dart';

abstract class AuthRepository {
  Future<AuthResponse> login({required String email, required String password});

  Future<AuthResponse> register({
    required String email,
    required String password,
    String? name,
    String? phoneNumber,
  });

  Future<void> logout();

  Future<AuthResponse> refreshToken(String refreshToken);

  Future<User?> getCurrentUser();

  Future<bool> checkEmailExists(String email);

  Future<void> sendPasswordResetEmail(String email);

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  });
}

class HttpAuthRepository implements AuthRepository {
  @override
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await ApiService.post(
      '/api/auth/login',
      data: {'email': email, 'password': password},
    );

    return AuthResponse.fromJson(response.data);
  }

  @override
  Future<AuthResponse> register({
    required String email,
    required String password,
    String? name,
    String? phoneNumber,
  }) async {
    final response = await ApiService.post(
      '/api/auth/signup',
      data: {
        'email': email,
        'password': password,
        if (name != null) 'name': name,
        if (phoneNumber != null) 'phoneNumber': phoneNumber,
      },
    );

    return AuthResponse.fromJson(response.data);
  }

  @override
  Future<void> logout() async {
    // refreshToken도 함께 보낸다.
    final tokenService = TokenService();
    final refreshToken = await tokenService.getRefreshToken();

    await ApiService.post(
      '/api/auth/logout',
      data: {if (refreshToken != null) 'refreshToken': refreshToken},
    );
  }

  @override
  Future<AuthResponse> refreshToken(String refreshToken) async {
    final response = await ApiService.post(
      '/api/auth/refresh',
      data: {'refreshToken': refreshToken},
    );

    return AuthResponse.fromJson(response.data);
  }

  @override
  Future<User?> getCurrentUser() async {
    final response = await ApiService.get('/api/auth/profile');
    return User.fromJson(response.data);
  }

  @override
  Future<bool> checkEmailExists(String email) async {
    // Email existence check endpoint not available
    return false;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    // Password reset functionality not yet implemented
    throw UnimplementedError('Password reset not implemented yet');
  }

  @override
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    // Password reset functionality not yet implemented
    throw UnimplementedError('Password reset not implemented yet');
  }
}
