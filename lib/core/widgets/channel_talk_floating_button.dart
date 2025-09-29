import 'package:flutter/material.dart';
import 'package:channel_talk_flutter/channel_talk_flutter.dart';
import 'package:channel_talk_flutter/channel_talk_flutter_platform_interface.dart';
import '../constants/app_colors.dart';

/// Channel Talk SDK를 사용하는 플로팅 버튼
class ChannelTalkFloatingButton extends StatefulWidget {
  final bool isVisible;

  const ChannelTalkFloatingButton({super.key, this.isVisible = true});

  @override
  State<ChannelTalkFloatingButton> createState() =>
      _ChannelTalkFloatingButtonState();
}

class _ChannelTalkFloatingButtonState extends State<ChannelTalkFloatingButton> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeChannelTalk();
  }

  Future<void> _initializeChannelTalk() async {
    try {
      // Channel Talk SDK 초기화 - 최소 설정으로 시작
      await ChannelTalk.boot(pluginKey: '072f3c6d-681e-4344-9837-249501435c46');

      setState(() {
        _isInitialized = true;
      });

      // SDK 제공 버튼 숨기기 (자체 버튼 사용)
      await ChannelTalk.hideChannelButton();

      // 이벤트 리스너 추가 - ChannelTalkEvent enum 타입
      ChannelTalk.setListener((event, data) {
        debugPrint('Channel Talk Event: $event');
        debugPrint('Channel Talk Data: $data');

        // event는 ChannelTalkEvent enum 타입
        switch (event) {
          case ChannelTalkEvent.onShowMessenger:
            debugPrint('메신저가 표시되었습니다');
            break;
          case ChannelTalkEvent.onHideMessenger:
            debugPrint('메신저가 숨겨졌습니다');
            break;
          case ChannelTalkEvent.onChatCreated:
            debugPrint('채팅이 생성되었습니다');
            break;
          case ChannelTalkEvent.onBadgeChanged:
            debugPrint('배지가 변경되었습니다: $data');
            break;
          case ChannelTalkEvent.onFollowUpChanged:
            debugPrint('팔로우업 상태 변경: $data');
            break;
          case ChannelTalkEvent.onUrlClicked:
            debugPrint('URL 클릭됨: $data');
            break;
          default:
            debugPrint('기타 이벤트: $event');
        }
      });

      debugPrint('Channel Talk SDK 초기화 성공');

      // 초기화 후 상태 확인
      final isBooted = await ChannelTalk.isBooted();
      debugPrint('Channel Talk 부팅 상태: $isBooted');
    } catch (e) {
      debugPrint('Channel Talk 초기화 실패: $e');
      setState(() {
        _isInitialized = false;
      });
    }
  }

  Future<void> _openChannelTalk() async {
    if (!_isInitialized) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('채팅 서비스를 준비 중입니다'),
          duration: Duration(seconds: 2),
        ),
      );
      // 초기화 재시도
      await _initializeChannelTalk();
      return;
    }

    try {
      // 부팅 상태 확인 (참고용)
      final isBooted = await ChannelTalk.isBooted();
      debugPrint('메신저 열기 전 부팅 상태: $isBooted');

      // isBooted가 false를 반환하더라도 메신저 열기 시도
      // (SDK 버그로 isBooted()가 항상 false를 반환하는 것으로 보임)
      debugPrint('Channel Talk 메신저 열기 시도...');
      await ChannelTalk.showMessenger();
      debugPrint('showMessenger 호출 완료');

      // 방법 2: 만약 안되면 openChat 시도 (일부 버전에서 지원)
      // await ChannelTalk.openChat();
    } catch (e) {
      debugPrint('Channel Talk 열기 실패: $e');
      debugPrint('에러 타입: ${e.runtimeType}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('채팅 서비스를 열 수 없습니다: $e'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isVisible) return const SizedBox.shrink();

    return FloatingActionButton(
      onPressed: _openChannelTalk,
      backgroundColor: AppColors.primary,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(Icons.support_agent, color: Colors.white, size: 28),
          if (!_isInitialized)
            const Positioned(
              right: 0,
              top: 0,
              child: SizedBox(
                width: 12,
                height: 12,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // 필요시 Channel Talk 정리
    super.dispose();
  }
}
