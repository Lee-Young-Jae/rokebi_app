import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rokebi_app/core/constants/app_colors.dart';
import 'package:rokebi_app/core/constants/app_spacing.dart';
import 'package:rokebi_app/core/constants/app_typography.dart';
import '../viewmodels/auth_view_model.dart';

class LoginPage extends ConsumerStatefulWidget {
  final String? redirectPath;

  const LoginPage({this.redirectPath, super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? get _redirectRoute => widget.redirectPath;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    // 입력값 검증
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      ref
          .read(authViewModelProvider.notifier)
          .setError('이메일과 비밀번호를 모두 입력해주세요.');
      return;
    }

    final authVM = ref.read(authViewModelProvider.notifier);

    final success = await authVM.login(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    // 로그인 성공시에만 리다이렉트
    if (success && mounted) {
      // 로그인 성공시 원래 가려던 페이지로 리다이렉트
      if (_redirectRoute != null) {
        context.go(_redirectRoute!);
      } else {
        context.go('/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              // 뒤로 갈 곳이 없으면 홈으로
              context.go('/home');
            }
          },
        ),
      ),
      body: Container(
        color: AppColors.surface,
        child: Padding(
          padding: AppSpacing.paddingXXL,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '여행을\n시작해 볼까요?',
                    style: AppTypography.titleLarge.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Image.asset(
                    "assets/images/rokebiBannerIcon.webp",
                    height: 64,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 이메일 입력
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: '이메일 입력',
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  // 입력시 에러 클리어
                  if (authState.error != null) {
                    ref.read(authViewModelProvider.notifier).clearError();
                  }
                },
              ),
              const SizedBox(height: 16),

              // 비밀번호 입력
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: '비밀번호 입력',
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                onChanged: (value) {
                  // 입력시 에러 클리어
                  if (authState.error != null) {
                    ref.read(authViewModelProvider.notifier).clearError();
                  }
                },
              ),
              const SizedBox(height: 24),

              // 로그인 버튼
              ElevatedButton(
                onPressed: authState.isLoading ? null : _handleLogin,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: authState.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('로그인'),
              ),

              if (authState.error != null) ...[
                const SizedBox(height: 16),
                Text(
                  authState.error!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ],

              const SizedBox(height: 20),

              // 회원가입 링크
              TextButton(
                onPressed: () {
                  context.push('/register');
                },
                child: const Text('계정이 없으신가요? 회원가입'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
