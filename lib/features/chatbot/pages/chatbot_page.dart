import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rokebi_app/core/constants/app_colors.dart';
import 'package:rokebi_app/core/constants/app_spacing.dart';
import 'package:rokebi_app/core/constants/app_typography.dart';
import 'package:rokebi_app/features/chatbot/model/chatbot_nav_item.dart';
import 'package:rokebi_app/features/chatbot/widgets/chatbot_bottom_navigation_bar.dart';

class ChatBotPage extends StatelessWidget {
  const ChatBotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset('assets/images/channelTalkLeft.png'),
          Container(
            padding: AppSpacing.paddingXL.copyWith(top: AppSpacing.xs),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "로밍도깨비",
                      style: AppTypography.titleLarge.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "운영시간 보기",
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),
                  ],
                ),
                AppSpacing.heightMD,
                Container(
                  padding: AppSpacing.paddingXL,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: AppColors.surface,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 100,
                        offset: Offset(0, 30),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 로밍도깨비 이미지
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              'assets/icons/chat_profile_rokebi.webp',
                              width: 40,
                              height: 40,
                            ),
                          ),
                          AppSpacing.widthSM,
                          // 채팅 내용
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '로밍도깨비',
                                  style: AppTypography.bodyMedium.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  '안녕하세요 👋',
                                  style: AppTypography.bodyMedium,
                                ),
                                Text(
                                  '걱정 뚝! 로밍 딱! 로밍도깨비입니다.',
                                  style: AppTypography.bodyMedium,
                                ),
                                Text(
                                  '무엇을 도와드릴까요?',
                                  style: AppTypography.bodyMedium,
                                ),
                                AppSpacing.heightMD,
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '챗봇',
                                        style: AppTypography.bodyMedium
                                            .copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.textPrimary,
                                            ),
                                      ),
                                      TextSpan(
                                        text:
                                            '을 통해 궁금하신 사항을 확인하실 수 있으며, 해결되지 않은 사안은 ',
                                        style: AppTypography.bodyMedium
                                            .copyWith(
                                              color: AppColors.textPrimary,
                                            ),
                                      ),
                                      TextSpan(
                                        text: "상담원",
                                        style: AppTypography.bodyMedium
                                            .copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.textPrimary,
                                            ),
                                      ),
                                      TextSpan(
                                        text: '을 통해 문의해주시면 빠르게 확인하여 답변 드리겠습니다.',
                                        style: AppTypography.bodyMedium
                                            .copyWith(
                                              color: AppColors.textPrimary,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      AppSpacing.heightXXXL,
                      // 문의하기 버튼
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: AppSpacing.paddingMD,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "문의하기",
                                style: AppTypography.bodyLarge.copyWith(
                                  color: AppColors.textOnPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Icon(
                                Icons.near_me,
                                size: 18,
                                color: AppColors.textOnPrimary,
                              ),
                            ],
                          ),
                        ),
                      ),

                      AppSpacing.heightSM,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 70, // 3개 이미지 * 30px - 겹침 고려
                            height: 34, // 이미지 30px + border 4px
                            child: Stack(
                              children: [0, 20, 40].map((leftPosition) {
                                return Positioned(
                                  left: leftPosition.toDouble(),
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                    child: ClipOval(
                                      // 원형 이미지
                                      child: Image.asset(
                                        'assets/images/ai_profile_1.webp',
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          AppSpacing.widthSM,
                          Text(
                            '빠르게 답변 받으실 수 있어요',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                AppSpacing.heightLG,
                Container(
                  padding: AppSpacing.paddingXL,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: AppColors.surface,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '다른 방법으로 문의',
                        style: AppTypography.bodyMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Row(
                        spacing: AppSpacing.sm,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image(
                              image: AssetImage('assets/images/kakao.png'),
                              width: 32,
                              height: 32,
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image(
                              image: AssetImage(
                                'assets/images/app-messenger-naver-talk.png',
                              ),
                              width: 32,
                              height: 32,
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image(
                              image: AssetImage(
                                'assets/images/app-messenger-instagram-messenger.png',
                              ),
                              width: 32,
                              height: 32,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Icon(Icons.chat, size: 24, color: AppColors.textSecondary),
          Row(
            spacing: AppSpacing.sm,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/channel_talk.svg',
                width: 18,
                height: 18,
                colorFilter: ColorFilter.mode(
                  AppColors.textSecondary,
                  BlendMode.srcIn,
                ),
              ),
              Text(
                '채널톡 이용중',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: AppColors.surface,
      bottomNavigationBar: ChatbotBottomNavigationBar(
        currentItem: ChatbotNavItem.home,
        onItemSelected: (item) {
          //
        },
      ),
    );
  }
}
