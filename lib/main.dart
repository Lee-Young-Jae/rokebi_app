import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:channel_talk_flutter/channel_talk_flutter.dart';
import 'package:channel_talk_flutter/channel_talk_flutter_platform_interface.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_router.dart';
import 'core/services/api_service.dart';
import 'core/errors/global_error_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ApiService.initialize();

  // Channel Talk SDK 초기화
  await _initializeChannelTalk();

  runApp(const ProviderScope(child: MyApp()));
}

Future<void> _initializeChannelTalk() async {
  try {
    debugPrint('=== Channel Talk 초기화 시작 ===');

    // 1. 기존 세션 정리 (있다면)
    try {
      await ChannelTalk.shutdown();
      debugPrint('기존 Channel Talk 세션 정리 완료');
      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      debugPrint('기존 세션 정리 중 오류 (무시 가능): $e');
    }

    // 2. 디버그 모드 설정
    await ChannelTalk.setDebugMode(flag: true);
    debugPrint('Channel Talk 디버그 모드 활성화');

    // 3. 리스너 등록
    _registerChannelTalkListener();
    debugPrint('Channel Talk 리스너 등록 완료');

    // 4. 최소 설정으로 부팅 시도 (유효한 플러그인 키인지 확인 필요)
    debugPrint('Channel Talk 부팅 시작...');
    debugPrint('사용 중인 플러그인 키: 072f3c6d-681e-4344-9837-249501435c46');

    final result = await ChannelTalk.boot(
      pluginKey: '072f3c6d-681e-4344-9837-249501435c46',
      language: Language.korean,
      appearance: Appearance.light,
      memberId: "1",
      email: "test@test.com",
      name: "test",
      mobileNumber: "01012345678",
      avatarUrl: "https://via.placeholder.com/150",
      unsubscribeEmail: false,
      unsubscribeTexting: false,
      trackDefaultEvent: false,
      hidePopup: false,
    );

    debugPrint('Channel Talk boot 결과: $result');

    if (result == true) {
      debugPrint('✅ 부팅 성공! 버튼 표시 진행...');

      // 부팅 성공 시에만 버튼 표시
      await Future.delayed(const Duration(milliseconds: 1000));

      final buttonResult = await ChannelTalk.showChannelButton();
      debugPrint('Channel Talk 버튼 표시 결과: $buttonResult');

      // 상태 재확인
      final isBooted = await ChannelTalk.isBooted();
      debugPrint('최종 부팅 상태: $isBooted');

      if (isBooted == true) {
        debugPrint('✅ 모든 초기화 완료! 버튼이 표시되어야 합니다.');
      } else {
        debugPrint('❌ 부팅 상태 불일치 - 재시도 중...');
        await _retryInitialization();
      }
    } else {
      debugPrint('❌ 부팅 실패 - 재시도 중...');
      await _retryInitialization();
    }
  } catch (e) {
    debugPrint('❌ Channel Talk 초기화 중 예외 발생: $e');
    debugPrint('Stack trace: ${StackTrace.current}');
  }
}

Future<void> _retryInitialization() async {
  try {
    debugPrint('=== Channel Talk 재초기화 시도 ===');
    await Future.delayed(const Duration(milliseconds: 1500));

    // 완전히 최소 설정으로 재시도
    final retryResult = await ChannelTalk.boot(
      pluginKey: '072f3c6d-681e-4344-9837-249501435c46',
    );

    debugPrint('재초기화 결과: $retryResult');

    if (retryResult == true) {
      await Future.delayed(const Duration(milliseconds: 1000));

      // 여러 번 버튼 표시 시도
      for (int i = 0; i < 3; i++) {
        final buttonResult = await ChannelTalk.showChannelButton();
        debugPrint('재초기화 후 버튼 표시 시도 ${i + 1}: $buttonResult');

        if (buttonResult == true) {
          final isBooted = await ChannelTalk.isBooted();
          debugPrint('재초기화 후 부팅 상태: $isBooted');

          if (isBooted == true) {
            debugPrint('✅ 재초기화 성공!');
            break;
          }
        }

        await Future.delayed(const Duration(milliseconds: 500));
      }
    }
  } catch (e) {
    debugPrint('재초기화 실패: $e');
  }
}

void _registerChannelTalkListener() {
  ChannelTalk.setListener((event, arguments) {
    debugPrint('Channel Talk Event: $event');
    debugPrint('Channel Talk Arguments: $arguments');

    switch (event) {
      case ChannelTalkEvent.onShowMessenger:
        debugPrint('ON_SHOW_MESSENGER');
        break;
      case ChannelTalkEvent.onHideMessenger:
        debugPrint('ON_HIDE_MESSENGER');
        break;
      case ChannelTalkEvent.onChatCreated:
        debugPrint('ON_CHAT_CREATED:\nchatId: $arguments');
        break;
      case ChannelTalkEvent.onBadgeChanged:
        debugPrint('ON_BADGE_CHANGED:\n$arguments');
        break;
      case ChannelTalkEvent.onFollowUpChanged:
        debugPrint('ON_FOLLOW_UP_CHANGED\ndata: $arguments');
        break;
      case ChannelTalkEvent.onUrlClicked:
        debugPrint('ON_URL_CLICKED\nurl: $arguments');
        break;
      case ChannelTalkEvent.onPopupDataReceived:
        debugPrint('ON_POPUP_DATA_RECEIVED\nevent: $arguments');
        break;
      case ChannelTalkEvent.onPushNotificationClicked:
        debugPrint('ON_PUSH_NOTIFICATION_CLICKED\nevent: $arguments');
        break;
      default:
        debugPrint('Unknown event: $event');
        break;
    }
  });
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
