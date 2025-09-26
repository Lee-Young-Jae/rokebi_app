import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rokebi_app/core/constants/app_colors.dart';
import 'package:rokebi_app/core/constants/app_spacing.dart';
import 'package:rokebi_app/core/constants/app_typography.dart';
import '../viewmodels/auth_view_model.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    final authVM = ref.read(authViewModelProvider.notifier);

    final success = await authVM.register(
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text.isEmpty ? null : _nameController.text,
      phoneNumber: _phoneNumberController.text.isEmpty
          ? null
          : _phoneNumberController.text,
    );

    if (success && mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
        ),
      ),
      body: SingleChildScrollView(
          padding: AppSpacing.paddingXXL,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '계정을\n만들어 볼까요?',
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

                AppSpacing.heightXL,

                // 이름 입력
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: '이름 입력 (선택사항)',
                    fillColor: AppColors.surface,
                    border: OutlineInputBorder(),
                  ),
                ),

                AppSpacing.heightXL,

                // 이메일 입력
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: '이메일 입력',
                    fillColor: AppColors.surface,
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '이메일을 입력해주세요';
                    }
                    if (!value.contains('@')) {
                      return '올바른 이메일 형식이 아닙니다';
                    }
                    return null;
                  },
                ),

                AppSpacing.heightXL,

                // 비밀번호 입력
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    hintText: '비밀번호 입력 (6자 이상)',
                    fillColor: AppColors.surface,
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '비밀번호를 입력해주세요';
                    }
                    if (value.length < 6) {
                      return '비밀번호는 6자 이상이어야 합니다';
                    }
                    return null;
                  },
                ),

                AppSpacing.heightXL,

                // 전화번호 입력
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: const InputDecoration(
                    hintText: '전화번호 입력 (선택사항)',
                    helperText: '예: 010-1234-5678 또는 01012345678',
                    fillColor: AppColors.surface,
                    border: OutlineInputBorder(),
                  ),
                  maxLength: 13, // 하이픈 포함
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return null;
                    }

                    final phoneRegex = RegExp(r'^[0-9-]+$');
                    if (!phoneRegex.hasMatch(value)) {
                      return '숫자와 하이픈(-)만 입력 가능합니다';
                    }

                    // 숫자만 추출해서 길이 확인
                    final numbersOnly = value.replaceAll('-', '');
                    if (numbersOnly.length < 10 || numbersOnly.length > 11) {
                      return '올바른 전화번호 형식이 아닙니다';
                    }

                    // 한국 휴대폰 번호 패턴 확인 (010, 011, 016, 017, 018, 019로 시작)
                    final koreanMobileRegex = RegExp(
                      r'^01[0-9]-?[0-9]{3,4}-?[0-9]{4}$',
                    );
                    if (!koreanMobileRegex.hasMatch(value)) {
                      return '올바른 휴대폰 번호 형식이 아닙니다';
                    }

                    return null;
                  },
                  onChanged: (value) {
                    // 자동 하이픈 추가 기능
                    final numbersOnly = value.replaceAll('-', '');
                    String formatted = numbersOnly;

                    if (numbersOnly.length > 3 && numbersOnly.length <= 7) {
                      formatted =
                          '${numbersOnly.substring(0, 3)}-${numbersOnly.substring(3)}';
                    } else if (numbersOnly.length > 7) {
                      formatted =
                          '${numbersOnly.substring(0, 3)}-${numbersOnly.substring(3, 7)}-${numbersOnly.substring(7)}';
                    }

                    if (formatted != value) {
                      _phoneNumberController.value = TextEditingValue(
                        text: formatted,
                        selection: TextSelection.collapsed(
                          offset: formatted.length,
                        ),
                      );
                    }
                  },
                ),

                AppSpacing.heightXL,

                // 회원가입 버튼
                ElevatedButton(
                  onPressed: authState.isLoading ? null : _handleRegister,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: authState.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('회원가입'),
                ),

                if (authState.error != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    authState.error!,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ],

                AppSpacing.heightXL,

                // 로그인 링크
                TextButton(
                  onPressed: () {
                    context.push('/login');
                  },
                  child: const Text('이미 계정이 있으신가요? 로그인'),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
