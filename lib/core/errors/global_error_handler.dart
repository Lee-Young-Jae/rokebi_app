import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'app_error.dart';

class GlobalErrorHandler {
  static GlobalKey<ScaffoldMessengerState>? _scaffoldMessengerKey;

  static void initialize(GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey) {
    _scaffoldMessengerKey = scaffoldMessengerKey;
  }

  static AppError handleError(Object error, StackTrace stackTrace) {
    AppError appError;

    if (error is DioException) {
      appError = _handleDioError(error);
    } else if (error is AppError) {
      appError = error;
    } else {
      appError = AppError.unknown(
        message: error.toString(),
        originalError: error,
      );
    }

    // 로깅
    _logError(appError, stackTrace);

    // 사용자에게 알림
    _showErrorToUser(appError);

    // 크래시 리포팅 (추후 Firebase Crashlytics 등 추가 가능)
    _reportCrash(appError, stackTrace);

    return appError;
  }

  static AppError _handleDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const AppError.timeout(
          message: '요청 시간이 초과되었습니다.',
        );

      case DioExceptionType.badResponse:
        final statusCode = dioError.response?.statusCode;
        final message = dioError.response?.data?['error'] ??
                        dioError.response?.data?['message'] ??
                        '서버 오류가 발생했습니다.';

        if (statusCode == 401) {
          return AppError.auth(
            message: message,
            code: statusCode.toString(),
          );
        }

        return AppError.network(
          message: message,
          statusCode: statusCode,
          code: statusCode.toString(),
        );

      case DioExceptionType.cancel:
        return const AppError.unknown(
          message: '요청이 취소되었습니다.',
        );

      case DioExceptionType.connectionError:
        return const AppError.noInternet(
          message: '네트워크 연결을 확인해주세요.',
        );

      default:
        return AppError.unknown(
          message: dioError.message ?? '알 수 없는 네트워크 오류가 발생했습니다.',
          originalError: dioError,
        );
    }
  }

  static void _logError(AppError error, StackTrace stackTrace) {
    debugPrint('🚨 AppError: ${error.toString()}');
    debugPrint('📍 StackTrace: ${stackTrace.toString()}');

    // 추후 구조화된 로깅 라이브러리 사용 가능
    // logger.e(error.toString(), error: error, stackTrace: stackTrace);
  }

  static void _showErrorToUser(AppError error) {
    if (_scaffoldMessengerKey?.currentState == null) return;

    final message = error.userFriendlyMessage;
    final isRetryable = error.isRetryable;

    _scaffoldMessengerKey!.currentState!.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
        action: isRetryable
            ? SnackBarAction(
                label: '다시 시도',
                textColor: Colors.white,
                onPressed: () {
                  // 재시도 로직은 각 화면에서 처리
                },
              )
            : null,
      ),
    );
  }

  static void _reportCrash(AppError error, StackTrace stackTrace) {
    // Firebase Crashlytics 또는 Sentry 등을 사용하여 크래시 리포팅
    // 개발 환경에서는 로깅만 수행
    debugPrint('📤 Crash reported: ${error.toString()}');

    // 추후 추가 가능:
    // FirebaseCrashlytics.instance.recordError(error, stackTrace);
    // Sentry.captureException(error, stackTrace: stackTrace);
  }

  static void showSuccessMessage(String message) {
    if (_scaffoldMessengerKey?.currentState == null) return;

    _scaffoldMessengerKey!.currentState!.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static void showInfoMessage(String message) {
    if (_scaffoldMessengerKey?.currentState == null) return;

    _scaffoldMessengerKey!.currentState!.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}