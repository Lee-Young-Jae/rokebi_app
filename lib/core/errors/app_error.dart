import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_error.freezed.dart';

@freezed
class AppError with _$AppError {
  const factory AppError.network({
    required String message,
    String? code,
    int? statusCode,
  }) = NetworkError;

  const factory AppError.validation({
    required String message,
    String? field,
  }) = ValidationError;

  const factory AppError.auth({
    required String message,
    String? code,
  }) = AuthError;

  const factory AppError.unknown({
    required String message,
    Object? originalError,
  }) = UnknownError;

  const factory AppError.timeout({
    required String message,
  }) = TimeoutError;

  const factory AppError.noInternet({
    required String message,
  }) = NoInternetError;
}

extension AppErrorExtension on AppError {
  String get userFriendlyMessage {
    return when(
      network: (message, code, statusCode) {
        if (statusCode == 404) return '요청한 데이터를 찾을 수 없습니다.';
        if (statusCode == 500) return '서버에 문제가 발생했습니다.';
        return message;
      },
      validation: (message, field) => message,
      auth: (message, code) => '인증에 실패했습니다. 다시 로그인해주세요.',
      unknown: (message, originalError) => '예상치 못한 오류가 발생했습니다.',
      timeout: (message) => '요청 시간이 초과되었습니다. 다시 시도해주세요.',
      noInternet: (message) => '인터넷 연결을 확인해주세요.',
    );
  }

  bool get isRetryable {
    return when(
      network: (message, code, statusCode) => statusCode != 404 && statusCode != 401,
      validation: (message, field) => false,
      auth: (message, code) => false,
      unknown: (message, originalError) => true,
      timeout: (message) => true,
      noInternet: (message) => true,
    );
  }
}