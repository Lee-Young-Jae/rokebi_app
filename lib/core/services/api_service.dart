import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../errors/app_error.dart';
import '../../features/auth/services/token_service.dart';

class ApiService {
  static final Dio _dio = Dio();

  static String get baseUrl {
    String baseUrl = Platform.isAndroid
        ? 'http://10.0.2.2:3000'
        // : 'http://localhost:3000';
        : 'http://192.168.219.100:3000';

    // 웹에서는 항상 localhost 사용
    if (kIsWeb) {
      return baseUrl;
    }

    // 모바일 플랫폼에서는 디바이스에 따라 다른 URL 사용
    // Android 에뮬레이터: 10.0.2.2
    // iOS 시뮬레이터 및 실제 기기: localhost (또는 실제 서버 IP)
    return baseUrl;
  }

  static void initialize() {
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    );

    // 인터셉터 추가
    _dio.interceptors.addAll([
      _LoggingInterceptor(),
      _ErrorInterceptor(),
      _AuthInterceptor(),
    ]);
  }

  static Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return await _dio.get(
      path,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  static Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    return await _dio.post(
      path,
      data: data,
      options: Options(headers: headers),
    );
  }

  static Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    return await _dio.put(
      path,
      data: data,
      options: Options(headers: headers),
    );
  }

  static Future<Response> delete(
    String path, {
    Map<String, dynamic>? headers,
  }) async {
    return await _dio.delete(path, options: Options(headers: headers));
  }

  static Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    return await _dio.patch(
      path,
      data: data,
      options: Options(headers: headers),
    );
  }
}

// 로깅 인터셉터
class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('API Request: ${options.method} ${options.uri}');
      if (options.data != null) {
        debugPrint('Request Data: ${options.data}');
      }
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint(
        'API Response: ${response.statusCode} ${response.requestOptions.uri}',
      );
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('API Error: ${err.message}');
    }
    handler.next(err);
  }
}

// 에러 인터셉터
class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // DioException을 AppError로 변환
    AppError appError;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        appError = const AppError.timeout(message: '요청 시간이 초과되었습니다.');
        break;

      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        final message =
            err.response?.data?['error'] ??
            err.response?.data?['message'] ??
            '서버 오류가 발생했습니다.';

        if (statusCode == 401) {
          appError = AppError.auth(
            message: message,
            code: statusCode.toString(),
          );
        } else {
          appError = AppError.network(
            message: message,
            statusCode: statusCode,
            code: statusCode.toString(),
          );
        }
        break;

      case DioExceptionType.cancel:
        appError = const AppError.unknown(message: '요청이 취소되었습니다.');
        break;

      case DioExceptionType.connectionError:
        appError = const AppError.noInternet(message: '네트워크 연결을 확인해주세요.');
        break;

      default:
        appError = AppError.unknown(
          message: err.message ?? '알 수 없는 오류가 발생했습니다.',
          originalError: err,
        );
    }

    // AppError를 throw
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: appError,
        type: err.type,
      ),
    );
  }
}

// 인증 인터셉터
class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 인증이 필요한 엔드포인트에 자동으로 토큰 추가
    if (_requiresAuth(options.path)) {
      try {
        final tokenService = TokenService();
        final accessToken = await tokenService.getAccessToken();

        if (accessToken != null) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
      } catch (e) {
        // 토큰 가져오기 실패시 그냥 진행
        if (kDebugMode) {
          debugPrint('Failed to add auth token: $e');
        }
      }
    }
    handler.next(options);
  }

  bool _requiresAuth(String path) {
    // 인증이 필요한 API 경로들
    final authRequiredPaths = [
      '/api/auth/profile',
      '/api/auth/logout',
      // 추후 다른 인증 필요 API들 추가
    ];

    return authRequiredPaths.any((authPath) => path.contains(authPath));
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 401 에러 시 토큰 갱신 로직 추가 가능
    if (err.response?.statusCode == 401) {
      // AuthService.logout();
      // 로그인 페이지로 리다이렉트
    }
    handler.next(err);
  }
}
