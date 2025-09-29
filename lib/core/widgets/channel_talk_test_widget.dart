import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:channel_talk_flutter/channel_talk_flutter.dart';
import 'package:channel_talk_flutter/channel_talk_flutter_platform_interface.dart';

/// Channel Talk 테스트 위젯 (예제 코드 기반)
class ChannelTalkTestWidget extends StatefulWidget {
  const ChannelTalkTestWidget({super.key});

  @override
  State<ChannelTalkTestWidget> createState() => _ChannelTalkTestWidgetState();
}

class _ChannelTalkTestWidgetState extends State<ChannelTalkTestWidget> {
  String content = '';
  final TextEditingController contentInputController = TextEditingController();

  @override
  void dispose() {
    contentInputController.dispose();
    super.dispose();
  }

  void showMessageToast(String message) {
    debugPrint(message);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void registerListener() {
    ChannelTalk.setListener((event, arguments) {
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
          break;
      }
    });
  }

  void unregisterListener() {
    ChannelTalk.removeListener();
  }

  void showInputDialog(String title, Function? onClick) {
    contentInputController.text = content;
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return Dialog(
          elevation: 0.0,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 24.0,
          ),
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.only(
              top: 40,
              right: 32,
              bottom: 32,
              left: 32,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(32),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0.0, 12.0),
                  blurRadius: 24.0,
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0XFF1A1A1A),
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: contentInputController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: Color(0XFF9E9E9E),
                        ),
                      ),
                      textInputAction: TextInputAction.newline,
                      autocorrect: false,
                      enableSuggestions: false,
                      onChanged: (text) {
                        content = text;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color.fromRGBO(214, 227, 255, 1.0),
                              width: 2.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Cancel',
                              maxLines: 1,
                              style: TextStyle(
                                color: Color.fromRGBO(136, 157, 201, 1.0),
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 11),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(92, 145, 255, 1.0),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color.fromRGBO(92, 145, 255, 1.0),
                              width: 2.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              if (onClick != null) {
                                onClick();
                                content = '';
                              }
                            },
                            child: const Text(
                              'OK',
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Channel Talk Test'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 20),

              // Boot 버튼 (기본)
              ElevatedButton(
                onPressed: () async {
                  content = '''
{
        "pluginKey": "072f3c6d-681e-4344-9837-249501435c46",
        "memberId": "",
        "memberHash": "",
        "email": "",
        "name": "",
        "mobileNumber": "",
        "avatarUrl": "",
        "unsubscribeEmail": false,
        "unsubscribeTexting": false,
        "trackDefaultEvent": false,
        "hidePopup": false
}''';
                  showInputDialog('boot payload', () async {
                    try {
                      Map args = json.decode(content);
                      final result = await ChannelTalk.boot(
                        pluginKey: args['pluginKey'],
                        memberId: args['memberId']?.isEmpty == true
                            ? null
                            : args['memberId'],
                        memberHash: args['memberHash']?.isEmpty == true
                            ? null
                            : args['memberHash'],
                        email: args['email']?.isEmpty == true
                            ? null
                            : args['email'],
                        name: args['name']?.isEmpty == true
                            ? null
                            : args['name'],
                        mobileNumber: args['mobileNumber']?.isEmpty == true
                            ? null
                            : args['mobileNumber'],
                        avatarUrl: args['avatarUrl']?.isEmpty == true
                            ? null
                            : args['avatarUrl'],
                        unsubscribeEmail: args['unsubscribeEmail'],
                        unsubscribeTexting: args['unsubscribeTexting'],
                        trackDefaultEvent: args['trackDefaultEvent'],
                        hidePopup: args['hidePopup'],
                        language: Language.korean,
                        appearance: Appearance.light,
                      );

                      showMessageToast('Boot Result: $result');
                    } on PlatformException catch (error) {
                      showMessageToast('PlatformException: ${error.message}');
                    } catch (err) {
                      showMessageToast(err.toString());
                    }
                  });
                },
                child: const Text('boot (기본)'),
              ),

              // Boot 버튼 (커스텀 위치)
              ElevatedButton(
                onPressed: () async {
                  content = '''
{
        "pluginKey": "072f3c6d-681e-4344-9837-249501435c46",
        "memberId": "",
        "memberHash": "",
        "email": "",
        "name": "",
        "mobileNumber": "",
        "avatarUrl": "",
        "unsubscribeEmail": false,
        "unsubscribeTexting": false,
        "trackDefaultEvent": false,
        "hidePopup": false,
        "channelButtonOption": {
          "xMargin": 20,
          "yMargin": 20,
          "position": "left"
        }
}''';
                  showInputDialog('boot with custom button position', () async {
                    try {
                      Map args = json.decode(content);

                      // channelButtonOption 처리
                      Map<String, dynamic>? channelButtonOption;
                      if (args['channelButtonOption'] != null) {
                        channelButtonOption = Map<String, dynamic>.from(
                          args['channelButtonOption'],
                        );
                      }

                      final result = await ChannelTalk.boot(
                        pluginKey: args['pluginKey'],
                        memberId: args['memberId']?.isEmpty == true
                            ? null
                            : args['memberId'],
                        memberHash: args['memberHash']?.isEmpty == true
                            ? null
                            : args['memberHash'],
                        email: args['email']?.isEmpty == true
                            ? null
                            : args['email'],
                        name: args['name']?.isEmpty == true
                            ? null
                            : args['name'],
                        mobileNumber: args['mobileNumber']?.isEmpty == true
                            ? null
                            : args['mobileNumber'],
                        avatarUrl: args['avatarUrl']?.isEmpty == true
                            ? null
                            : args['avatarUrl'],
                        unsubscribeEmail: args['unsubscribeEmail'],
                        unsubscribeTexting: args['unsubscribeTexting'],
                        trackDefaultEvent: args['trackDefaultEvent'],
                        hidePopup: args['hidePopup'],
                        language: Language.korean,
                        appearance: Appearance.light,
                      );

                      showMessageToast(
                        'Boot with Custom Position Result: $result',
                      );
                    } on PlatformException catch (error) {
                      showMessageToast('PlatformException: ${error.message}');
                    } catch (err) {
                      showMessageToast(err.toString());
                    }
                  });
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text(
                  'boot (커스텀 위치)',
                  style: TextStyle(color: Colors.white),
                ),
              ),

              // 리스너 등록/해제
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          registerListener();
                          showMessageToast('registerListener is called');
                        } on PlatformException catch (error) {
                          showMessageToast(
                            'PlatformException: ${error.message}',
                          );
                        } catch (err) {
                          showMessageToast(err.toString());
                        }
                      },
                      child: const Text('register listener'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          unregisterListener();
                          showMessageToast('unregisterListener is called');
                        } on PlatformException catch (error) {
                          showMessageToast(
                            'PlatformException: ${error.message}',
                          );
                        } catch (err) {
                          showMessageToast(err.toString());
                        }
                      },
                      child: const Text('unregister listener'),
                    ),
                  ),
                ],
              ),

              // 버튼 제어
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          final result = await ChannelTalk.showChannelButton();
                          showMessageToast('showChannelButton Result: $result');
                        } on PlatformException catch (error) {
                          showMessageToast(
                            'PlatformException: ${error.message}',
                          );
                        } catch (err) {
                          showMessageToast(err.toString());
                        }
                      },
                      child: const Text('showChannelButton'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          final result = await ChannelTalk.hideChannelButton();
                          showMessageToast('hideChannelButton Result: $result');
                        } on PlatformException catch (error) {
                          showMessageToast(
                            'PlatformException: ${error.message}',
                          );
                        } catch (err) {
                          showMessageToast(err.toString());
                        }
                      },
                      child: const Text('hideChannelButton'),
                    ),
                  ),
                ],
              ),

              // 메신저 제어
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          final result = await ChannelTalk.showMessenger();
                          showMessageToast('showMessenger Result: $result');
                        } on PlatformException catch (error) {
                          showMessageToast(
                            'PlatformException: ${error.message}',
                          );
                        } catch (err) {
                          showMessageToast(err.toString());
                        }
                      },
                      child: const Text('showMessenger'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          final result = await ChannelTalk.hideMessenger();
                          showMessageToast('hideMessenger Result: $result');
                        } on PlatformException catch (error) {
                          showMessageToast(
                            'PlatformException: ${error.message}',
                          );
                        } catch (err) {
                          showMessageToast(err.toString());
                        }
                      },
                      child: const Text('hideMessenger'),
                    ),
                  ),
                ],
              ),

              // 상태 확인
              ElevatedButton(
                onPressed: () async {
                  try {
                    final bool? result = await ChannelTalk.isBooted();
                    if (result == true) {
                      showMessageToast('isBooted: true');
                    } else {
                      showMessageToast('isBooted: false');
                    }
                  } on PlatformException catch (error) {
                    showMessageToast('PlatformException: ${error.message}');
                  } catch (err) {
                    showMessageToast(err.toString());
                  }
                },
                child: const Text('isBooted'),
              ),

              // 시스템 제어
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          final result = await ChannelTalk.sleep();
                          showMessageToast('sleep Result: $result');
                        } on PlatformException catch (error) {
                          showMessageToast(
                            'PlatformException: ${error.message}',
                          );
                        } catch (err) {
                          showMessageToast(err.toString());
                        }
                      },
                      child: const Text('sleep'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          final result = await ChannelTalk.shutdown();
                          showMessageToast('shutdown Result: $result');
                        } on PlatformException catch (error) {
                          showMessageToast(
                            'PlatformException: ${error.message}',
                          );
                        } catch (err) {
                          showMessageToast(err.toString());
                        }
                      },
                      child: const Text('shutdown'),
                    ),
                  ),
                ],
              ),

              // 외관 설정
              ElevatedButton(
                onPressed: () async {
                  try {
                    final bool? result = await ChannelTalk.setAppearance(
                      appearance: Appearance.light,
                    );
                    if (result == true) {
                      showMessageToast('setAppearance success');
                    } else {
                      showMessageToast('setAppearance fail');
                    }
                  } on PlatformException catch (error) {
                    showMessageToast('PlatformException: ${error.message}');
                  } catch (err) {
                    showMessageToast(err.toString());
                  }
                },
                child: const Text('setAppearance (Light)'),
              ),

              // 커스텀 버튼 테스트 섹션
              const Divider(thickness: 2),
              const Text(
                '커스텀 채널 버튼 테스트',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              // 기본 버튼 숨기기 + 커스텀 버튼 표시
              ElevatedButton(
                onPressed: () async {
                  try {
                    // 1. 기본 채널 버튼 숨기기
                    await ChannelTalk.hideChannelButton();
                    showMessageToast('기본 채널 버튼을 숨겼습니다');
                  } on PlatformException catch (error) {
                    showMessageToast('PlatformException: ${error.message}');
                  } catch (err) {
                    showMessageToast(err.toString());
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text(
                  '기본 버튼 숨기기',
                  style: TextStyle(color: Colors.white),
                ),
              ),

              // 커스텀 버튼들
              const Text(
                '커스텀 버튼 예시 (기본 버튼 숨긴 후 사용)',
                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // 커스텀 버튼 1
                  FloatingActionButton(
                    onPressed: () async {
                      try {
                        await ChannelTalk.showMessenger();
                        showMessageToast('커스텀 버튼 1로 메신저 열기');
                      } catch (e) {
                        showMessageToast('오류: $e');
                      }
                    },
                    backgroundColor: Colors.purple,
                    child: const Icon(Icons.chat, color: Colors.white),
                  ),

                  // 커스텀 버튼 2
                  ElevatedButton.icon(
                    onPressed: () async {
                      try {
                        await ChannelTalk.showMessenger();
                        showMessageToast('커스텀 버튼 2로 메신저 열기');
                      } catch (e) {
                        showMessageToast('오류: $e');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    icon: const Icon(Icons.support_agent, color: Colors.white),
                    label: const Text(
                      '채팅',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                  // 커스텀 버튼 3 - 아이콘만
                  IconButton(
                    onPressed: () async {
                      try {
                        await ChannelTalk.showMessenger();
                        showMessageToast('커스텀 버튼 3으로 메신저 열기');
                      } catch (e) {
                        showMessageToast('오류: $e');
                      }
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.all(12),
                    ),
                    icon: const Icon(
                      Icons.message,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),

              // 기본 버튼 다시 표시
              ElevatedButton(
                onPressed: () async {
                  try {
                    await ChannelTalk.showChannelButton();
                    showMessageToast('기본 채널 버튼을 다시 표시했습니다');
                  } on PlatformException catch (error) {
                    showMessageToast('PlatformException: ${error.message}');
                  } catch (err) {
                    showMessageToast(err.toString());
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text(
                  '기본 버튼 다시 표시',
                  style: TextStyle(color: Colors.white),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
