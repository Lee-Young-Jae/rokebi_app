import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audio_session/audio_session.dart';
import 'package:rokebi_app/core/routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_radius.dart';

class CallPage extends StatefulWidget {
  const CallPage({super.key});

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  bool _permissionsGranted = false;
  String _phoneNumber = '';

  @override
  void initState() {
    super.initState();
    _initializeCallPage();
  }

  Future<void> _initializeCallPage() async {
    try {
      // 실제 권한 상태 확인
      final contactsStatus = await Permission.contacts.status;
      final microphoneStatus = await Permission.microphone.status;

      if ((contactsStatus.isGranted || contactsStatus.isLimited) &&
          (microphoneStatus.isGranted || microphoneStatus.isLimited)) {
        // 권한이 이미 있으면 바로 다이얼러로 이동
        setState(() {
          _permissionsGranted = true;
        });
      } else {
        // 권한이 없으면 초기 안내 팝업 표시
        if (mounted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showInitialPermissionDialog();
          });
        }
      }
    } catch (e) {
      if (mounted) {
        _showErrorAndNavigateHome('권한 확인 중 오류가 발생했습니다.');
      }
    }
  }

  void _showInitialPermissionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.phone_in_talk, color: AppColors.primary),
            SizedBox(width: 8),
            Text('로밍도깨비 통화'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '로밍도깨비 통화 서비스를 이용하시려면 다음 권한이 필요합니다:',
              style: AppTypography.bodyMedium,
            ),
            SizedBox(height: 16),
            _buildPermissionInfoItem(
              icon: Icons.contacts,
              title: '연락처',
              description: '전화번호부에서 연락처를 불러옵니다',
            ),
            SizedBox(height: 12),
            _buildPermissionInfoItem(
              icon: Icons.mic,
              title: '마이크',
              description: '통화를 위해 마이크를 사용합니다',
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.secondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.secondary.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 16,
                        color: AppColors.secondary,
                      ),
                      SizedBox(width: 8),
                      Text(
                        '권한 설정 방법',
                        style: AppTypography.bodySmall.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.secondary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    '1. "권한 설정하기" 버튼 클릭\n2. iOS 설정 앱으로 이동\n3. 연락처 및 마이크 권한 허용',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/home');
            },
            child: Text('나중에'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // 설정 앱으로 바로 이동
              openAppSettings();

              ScaffoldMessenger.of(this.context).showSnackBar(
                SnackBar(
                  content: Text('설정에서 "연락처"와 "마이크" 권한을 허용해주세요'),
                  backgroundColor: AppColors.primary,
                  duration: Duration(seconds: 5),
                  action: SnackBarAction(
                    label: '확인',
                    textColor: Colors.white,
                    onPressed: () {},
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: Text('권한 설정하기'),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionInfoItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 16, color: AppColors.primary),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                description,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _performInitialSetup() async {
    try {
      // iOS에서 실제 마이크 접근을 트리거하여 권한 팝업 강제 표시
      if (Platform.isIOS) {
        await _triggerIOSMicrophoneRequest();
      }

      // 실제 시스템 권한 요청
      final Map<Permission, PermissionStatus> statuses = await [
        Permission.contacts,
        Permission.microphone,
      ].request();

      // 모든 권한이 허용되었는지 확인
      final allGranted = statuses.values.every(
        (status) =>
            status == PermissionStatus.granted ||
            status == PermissionStatus.limited,
      );

      if (allGranted) {
        setState(() {
          _permissionsGranted = true;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('권한이 허용되었습니다. 통화 서비스를 이용하실 수 있습니다.'),
              backgroundColor: AppColors.secondary,
            ),
          );
        }
      } else {
        // 권한이 거부된 경우 처리
        _handlePermissionDenied(statuses);
      }
    } catch (e) {
      // 권한 요청 중 에러 발생 시 홈으로 이동
      if (mounted) {
        _showErrorAndNavigateHome('권한 요청 중 오류가 발생했습니다.');
      }
    }
  }

  void _showErrorAndNavigateHome(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.error_outline, color: AppColors.error),
            SizedBox(width: 8),
            Text('오류'),
          ],
        ),
        content: Text(message),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/home');
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: Text('홈으로 이동'),
          ),
        ],
      ),
    );
  }

  void _handlePermissionDenied(Map<Permission, PermissionStatus> statuses) {
    final deniedPermissions = <String>[];

    if (statuses[Permission.contacts] == PermissionStatus.denied ||
        statuses[Permission.contacts] == PermissionStatus.permanentlyDenied) {
      deniedPermissions.add('연락처');
    }

    if (statuses[Permission.microphone] == PermissionStatus.denied ||
        statuses[Permission.microphone] == PermissionStatus.permanentlyDenied) {
      deniedPermissions.add('마이크');
    }

    final hasPermanentlyDenied = statuses.values.any(
      (status) => status == PermissionStatus.permanentlyDenied,
    );

    if (mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('권한 필요'),
          content: Text(
            hasPermanentlyDenied
                ? '${deniedPermissions.join(', ')} 권한이 필요합니다.\n설정에서 권한을 허용해주세요.'
                : '${deniedPermissions.join(', ')} 권한이 거부되었습니다.\n서비스 이용을 위해 권한이 필요합니다.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // go_router를 사용하여 안전하게 홈페이지로 이동
                context.go('/home');
              },
              child: Text('홈으로 이동'),
            ),
            if (hasPermanentlyDenied)
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  openAppSettings();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: Text('설정으로 이동'),
              )
            else
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _performInitialSetup();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: Text('다시 요청'),
              ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColors.surface, body: _buildContent());
  }

  Widget _buildContent() {
    // 권한 설정이 완료되면 바로 다이얼러 표시
    if (_permissionsGranted) {
      return _buildDialerView();
    }

    // 초기 로딩 상태
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppColors.primary),
          SizedBox(height: 16),
          Text(
            '초기화 중...',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDialerView() {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: AppSpacing.screenPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: AppSpacing.paddingXL,
                  child: Column(
                    children: [
                      Text(
                        _formatPhoneNumber(_phoneNumber),
                        style: AppTypography.headlineMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildKeypad(),
                AppSpacing.heightXL,
                Padding(
                  padding: AppSpacing.paddingHorizontalXXL,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTextActionButton(
                        text: '연락처',
                        onPressed: () async {
                          // 연락처 페이지로 이동하고 선택된 번호 받기
                          final selectedPhone = await context.push<String>(
                            AppRoutes.contacts,
                          );
                          if (selectedPhone != null && mounted) {
                            setState(() {
                              _phoneNumber = selectedPhone.replaceAll(
                                RegExp(r'[^0-9+]'),
                                '',
                              );
                            });
                          }
                        },
                      ),
                      _buildCallButton(),
                      _buildTextActionButton(
                        text: '발신내역',
                        onPressed: () {
                          // 발신내역 페이지로 이동
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKeypad() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      childAspectRatio: 1.5,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        ...[1, 2, 3, 4, 5, 6, 7, 8, 9].map(
          (digit) => _buildKeypadButton(digit.toString(), digit.toString(), ''),
        ),
        _buildKeypadSpecialButton(Icons.language, () {
          // 국가 선택 페이지로 이동
        }),
        _buildKeypadButton('0', '0', ''),
        _buildKeypadSpecialButton(
          Icons.backspace,
          _phoneNumber.isNotEmpty ? _deleteDigit : null,
        ),
      ],
    );
  }

  Widget _buildKeypadButton(String display, String value, String subtext) {
    return InkWell(
      onTap: () => _addDigit(value),
      onLongPress: subtext == '+' ? () => _addDigit('+') : null,
      borderRadius: BorderRadius.circular(AppRadius.full),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              display,
              style: AppTypography.headlineMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            if (subtext.isNotEmpty)
              Text(
                subtext,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeypadSpecialButton(IconData icon, VoidCallback? onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(AppRadius.full),
      child: Container(
        alignment: Alignment.center,
        child: Icon(
          icon,
          size: 28,
          color: onPressed != null
              ? AppColors.textPrimary
              : AppColors.textSecondary.withValues(alpha: 0.3),
        ),
      ),
    );
  }

  Widget _buildTextActionButton({
    required String text,
    VoidCallback? onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: AppSpacing.paddingHorizontalXXL,
        child: Text(
          text,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildCallButton() {
    return Material(
      color: AppColors.secondary,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: _makeCall,
        customBorder: const CircleBorder(),
        child: Container(
          padding: AppSpacing.paddingXL,
          decoration: BoxDecoration(
            color: AppColors.secondary,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.call, color: AppColors.textOnPrimary, size: 32),
        ),
      ),
    );
  }

  void _addDigit(String digit) {
    HapticFeedback.lightImpact();
    setState(() {
      if (_phoneNumber.length < 13) {
        _phoneNumber += digit;
      }
    });
  }

  void _deleteDigit() {
    HapticFeedback.lightImpact();
    setState(() {
      if (_phoneNumber.isNotEmpty) {
        _phoneNumber = _phoneNumber.substring(0, _phoneNumber.length - 1);
      }
    });
  }

  String _formatPhoneNumber(String number) {
    if (number.startsWith('+')) {
      return number;
    }

    final cleaned = number.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleaned.length <= 3) {
      return cleaned;
    } else if (cleaned.length <= 7) {
      return '${cleaned.substring(0, 3)}-${cleaned.substring(3)}';
    } else if (cleaned.length <= 11) {
      return '${cleaned.substring(0, 3)}-${cleaned.substring(3, cleaned.length - 4)}-${cleaned.substring(cleaned.length - 4)}';
    }
    return cleaned;
  }

  /// iOS에서 실제 마이크 접근을 시도하여 권한 팝업을 강제로 트리거
  Future<void> _triggerIOSMicrophoneRequest() async {
    if (!Platform.isIOS) return;

    try {
      // AudioSession을 통해 마이크 사용을 시도
      final session = await AudioSession.instance;
      await session.configure(
        const AudioSessionConfiguration(
          avAudioSessionCategory: AVAudioSessionCategory.record,
          avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.none,
          avAudioSessionMode: AVAudioSessionMode.defaultMode,
          avAudioSessionRouteSharingPolicy:
              AVAudioSessionRouteSharingPolicy.defaultPolicy,
          avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
          androidAudioAttributes: AndroidAudioAttributes(
            contentType: AndroidAudioContentType.speech,
            flags: AndroidAudioFlags.none,
            usage: AndroidAudioUsage.voiceCommunication,
          ),
          androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
          androidWillPauseWhenDucked: true,
        ),
      );

      await session.setActive(true);

      // 잠시 대기 후 비활성화
      await Future.delayed(const Duration(milliseconds: 500));
      await session.setActive(false);
    } catch (e) {
      // 에러는 무시 (권한이 거부되면 당연히 에러가 발생)
    }
  }

  void _makeCall() {
    HapticFeedback.mediumImpact();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('${_formatPhoneNumber(_phoneNumber)}(으)로 전화를 걸까요?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('취소'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(this.context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${_formatPhoneNumber(_phoneNumber)}로 전화 연결 중...',
                  ),
                  backgroundColor: AppColors.secondary,
                ),
              );
              setState(() {
                _phoneNumber = '';
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondary,
            ),
            child: Text('전화 걸기'),
          ),
        ],
      ),
    );
  }
}
