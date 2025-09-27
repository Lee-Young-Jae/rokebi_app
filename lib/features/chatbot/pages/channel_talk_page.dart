import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../../../core/constants/app_colors.dart';

class ChannelTalkPage extends StatefulWidget {
  const ChannelTalkPage({super.key});

  @override
  State<ChannelTalkPage> createState() => _ChannelTalkPageState();
}

class _ChannelTalkPageState extends State<ChannelTalkPage> {
  InAppWebViewController? webViewController;
  bool _isLoading = true;
  bool _showAppBar = true; // 앱바 표시 여부 제어

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: _showAppBar
            ? AppBar(
                backgroundColor: AppColors.surface,
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              )
            : null,
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri('https://channel-talk-react.vercel.app/'),
              ),
              initialSettings: InAppWebViewSettings(
                javaScriptEnabled: true,
                useHybridComposition: true,
                allowsInlineMediaPlayback: true,
              ),
              onWebViewCreated: (controller) {
                webViewController = controller;

                // 메신저 열기 핸들러 등록
                controller.addJavaScriptHandler(
                  handlerName: 'channelTalkOpened',
                  callback: (args) {
                    debugPrint('Channel Talk 메신저가 열렸습니다');
                    setState(() {
                      _showAppBar = false; // 메신저가 열리면 앱바 숨김
                    });
                  },
                );

                // 메신저 닫기 핸들러 등록
                controller.addJavaScriptHandler(
                  handlerName: 'channelTalkClosed',
                  callback: (args) {
                    debugPrint('Channel Talk 메신저가 닫혔습니다');
                    // 메신저가 닫히면 전체 페이지 닫기
                    Navigator.pop(context);
                  },
                );

                // 메신저 최소화 핸들러 등록 (선택사항)
                controller.addJavaScriptHandler(
                  handlerName: 'channelTalkMinimized',
                  callback: (args) {
                    debugPrint('Channel Talk 메신저가 최소화되었습니다');
                    setState(() {
                      _showAppBar = true; // 최소화되면 앱바 다시 표시
                    });
                  },
                );
              },
              onLoadStart: (controller, url) {
                setState(() {
                  _isLoading = true;
                });
              },
              onLoadStop: (controller, url) async {
                setState(() {
                  _isLoading = false;
                });

                // 페이지 로드 완료 후 자동으로 메신저 열기
                await controller.evaluateJavascript(
                  source: "openChannelTalk()",
                );
              },
              onReceivedError: (controller, request, error) {
                debugPrint('WebView error: ${error.description}');
              },
              onProgressChanged: (controller, progress) {
                if (progress == 100) {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
            ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
