import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _tokenExpiryKey = 'token_expiry';

  final FlutterSecureStorage _storage;

  TokenService({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  // 토큰 저장 (만료 시간 포함)
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    DateTime? expiresAt,
  }) async {
    // 만료 시간이 없으면 현재시간 + 1시간으로 설정
    final expiry = expiresAt ?? DateTime.now().add(const Duration(hours: 1));

    await Future.wait([
      _storage.write(key: _accessTokenKey, value: accessToken),
      _storage.write(key: _refreshTokenKey, value: refreshToken),
      _storage.write(key: _tokenExpiryKey, value: expiry.toIso8601String()),
    ]);
  }

  // Access Token 가져오기
  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  // Refresh Token 가져오기
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  // 토큰 만료 시간 가져오기
  Future<DateTime?> getTokenExpiry() async {
    final expiryStr = await _storage.read(key: _tokenExpiryKey);
    if (expiryStr != null) {
      return DateTime.parse(expiryStr);
    }
    return null;
  }

  // 토큰 만료 여부 확인
  Future<bool> isTokenExpired() async {
    final expiry = await getTokenExpiry();
    if (expiry == null) return true;

    // 5분 여유를 두고 만료 체크
    final threshold = DateTime.now().add(const Duration(minutes: 5));
    return expiry.isBefore(threshold);
  }

  // 토큰 삭제
  Future<void> clearTokens() async {
    await Future.wait([
      _storage.delete(key: _accessTokenKey),
      _storage.delete(key: _refreshTokenKey),
      _storage.delete(key: _tokenExpiryKey),
    ]);
  }

  // 토큰 존재 여부 확인
  Future<bool> hasTokens() async {
    final accessToken = await getAccessToken();
    final refreshToken = await getRefreshToken();
    return accessToken != null && refreshToken != null;
  }

  // Access Token 토큰 업데이트
  Future<void> updateAccessToken(String accessToken) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
  }
}
