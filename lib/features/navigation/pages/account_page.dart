import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../../auth/viewmodels/auth_view_model.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authViewModelProvider);
    final user = authState.user;

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: Text(
          '내 계정',
          style: AppTypography.titleLarge.copyWith(fontWeight: FontWeight.w700),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          // 프로필 섹션
          AppSpacing.heightMD,
          Container(
            padding: AppSpacing.paddingLG,
            decoration: BoxDecoration(color: AppColors.surface),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  child: Icon(Icons.person, size: 30, color: AppColors.primary),
                ),
                AppSpacing.widthXL,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.email ?? '사용자',
                        style: AppTypography.titleMedium.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      AppSpacing.heightXS,
                      Text(
                        user?.phoneNumber ?? user?.name ?? '',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 로깨비캐시 잔액
          Container(
            margin: AppSpacing.paddingLG,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
            padding: AppSpacing.paddingLG,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "로깨비캐시 잔액",
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textOnPrimary,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "0원",
                          style: AppTypography.bodyLarge.copyWith(
                            color: AppColors.textOnPrimary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        AppSpacing.widthXS,
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 10,
                          color: AppColors.textOnPrimary,
                        ),
                      ],
                    ),
                  ],
                ),
                // 충전하기 버튼
                GestureDetector(
                  child: Container(
                    padding: AppSpacing.paddingMD,
                    decoration: BoxDecoration(
                      color: AppColors.textOnPrimary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "충전하기",
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),

          //  쿠폰함, 1:1문의, 이벤트 인증
          Container(
            margin: AppSpacing.paddingLG,
            padding:
                AppSpacing.paddingHorizontalXXL +
                AppSpacing.paddingHorizontalXXL +
                AppSpacing.paddingHorizontalMD,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Icon(Icons.local_activity, color: AppColors.textPrimary),
                    Text(
                      "쿠폰함",
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.chat, color: AppColors.textPrimary),
                    Text(
                      "1:1문의",
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.event, color: AppColors.textPrimary),
                    Text(
                      "이벤트 인증",
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          AppSpacing.heightMD,
          Divider(color: AppColors.divider, thickness: 6),
          AppSpacing.heightMD,

          // 광고 배너
          AppSpacing.heightMD,
          GestureDetector(
            onTap: () {
              // https://gift.kakao.com/product/10996167 로 이동
              launchUrl(Uri.parse('https://gift.kakao.com/product/10996167'));
            },
            child: Container(
              margin: AppSpacing.paddingLG,
              padding: AppSpacing.paddingMD,
              decoration: BoxDecoration(
                gradient: AppColors.guideBannerGradient,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '어쩌면 데이터가 공짜?',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textOnPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '친구 초대하면 무제한 캐시 적립',
                        style: AppTypography.bodyLarge.copyWith(
                          color: AppColors.textOnPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Image.asset('assets/images/rokebiGuide.webp', height: 64),
                ],
              ),
            ),
          ),

          // 구매 내역
          AppSpacing.heightMD,

          Container(
            margin: AppSpacing.paddingLG,
            child: Row(children: [Text("구매 내역")]),
          ),

          // 로그아웃 버튼
          Container(
            margin: AppSpacing.paddingLG,
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () async {
                  await ref.read(authViewModelProvider.notifier).logout();
                  if (context.mounted) {
                    context.go('/home');
                  }
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: AppColors.textSecondary),
                ),
                child: Text(
                  '로그아웃',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),

          AppSpacing.heightLG,
        ],
      ),
    );
  }
}
