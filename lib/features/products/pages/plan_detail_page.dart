import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rokebi_app/core/routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../models/product_plan_model.dart';
import '../models/product_model.dart';

class PlanDetailPage extends StatelessWidget {
  final ProductPlan plan;
  final Product product;

  const PlanDetailPage({super.key, required this.plan, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          product.title,
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          // cart
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.cart),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 상단 헤더 섹션
            _buildHeaderSection(),

            // 특징 아이콘 섹션
            _buildFeatureIcons(),

            // 주의사항 박스
            _buildCautionBox(),
            AppSpacing.heightLG,

            // 사용 가능 지역
            _buildAvailableRegions(),

            AppSpacing.heightLG,
            AppSpacing.heightLG,

            // APN 설정
            _buildAPNSettings(),

            AppSpacing.heightXXL,

            // 상세 주의사항
            _buildDetailedCautions(),
          ],
        ),
      ),
      bottomNavigationBar: _PlanDetailBottomBar(plan: plan),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.9),
            AppColors.primaryDark.withValues(alpha: 0.9),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '데이터 ',
                style: AppTypography.headlineSmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (plan.title.contains('무제한'))
                Text(
                  '무제한 ',
                  style: AppTypography.headlineSmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              Text(
                plan.title,
                style: AppTypography.headlineSmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          AppSpacing.heightMD,
          Text(
            "하루에 최대 ${plan.carrier} 소진 후에는 \n384Kbps 속도로 무제한 사용하실 수 있습니다.",
            style: AppTypography.bodyLarge.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
              height: 1.5,
            ),
          ),
          AppSpacing.heightMD,

          Text(
            '[로밍]',
            style: AppTypography.bodyLarge.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            '통신사\nKDDI Softbank',
            style: AppTypography.bodyLarge.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureIcons() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFFF4F9FD),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildFeatureItem(Icons.sim_card_outlined, '데이터 ONLY'),
              ),
              Expanded(
                child: _buildFeatureItem(
                  Icons.schedule_outlined,
                  '사용 기간: ${plan.title}',
                ),
              ),
              Expanded(child: _buildFeatureItem(Icons.network_cell, '5G/LTE')),
            ],
          ),
          AppSpacing.heightLG,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildFeatureItem(
                  Icons.speed_outlined,
                  '일 4GB 소진 시\n속도 제한',
                ),
              ),
              Expanded(
                child: _buildFeatureItem(
                  Icons.wifi_tethering_outlined,
                  '핫스팟 테더링\n가능',
                ),
              ),
              Expanded(
                child: _buildFeatureItemWithBadge(
                  Icons.battery_charging_full_outlined,
                  '충전 가능',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          child: Icon(icon, color: AppColors.primary, size: 24),
        ),
        Text(
          text,
          style: AppTypography.bodySmall.copyWith(
            height: 1.3,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildFeatureItemWithBadge(IconData icon, String text) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child: Icon(icon, color: AppColors.primary, size: 24),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: AppTypography.bodySmall.copyWith(
                height: 1.3,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            AppSpacing.widthXS,
            Icon(Icons.info_outline, size: 12, color: AppColors.primary),
          ],
        ),
        AppSpacing.heightSM,
        IntrinsicWidth(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.1),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '용량 충전',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    AppSpacing.widthXS,
                    Icon(
                      Icons.close_outlined,
                      size: 16,
                      color: AppColors.productBadgeRed,
                    ),
                  ],
                ),
                AppSpacing.heightXS,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '상품 연장',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    AppSpacing.widthXS,
                    Icon(
                      Icons.circle_outlined,
                      size: 14,
                      color: AppColors.productBadgeGreen,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCautionBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.planWarningBox,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                size: 20,
                color: AppColors.productBadgeRed,
                fill: 1,
              ),
              AppSpacing.widthSM,
              Text(
                '주의사항',
                style: AppTypography.labelLarge.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textOnPrimary,
                ),
              ),
            ],
          ),
          AppSpacing.heightMD,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Icon(
                  Icons.info_rounded,
                  size: 6,
                  color: AppColors.textOnPrimary,
                  fill: 1,
                ),
              ),
              AppSpacing.widthSM,
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: AppTypography.bodySmall.copyWith(
                      height: 1.5,
                      color: AppColors.textOnPrimary,
                    ),
                    children: [
                      const TextSpan(text: '본 상품은 '),
                      TextSpan(
                        text: '국내 및 현지에서 모두 상품 등록(QR 스캔) 가능',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text:
                            '합니다. 국내에서 상품 등록 후 현지 도착 시 바로 현지 네트워크를 사용하실 수 있으니, ',
                      ),
                      TextSpan(
                        text: '국내에서 미리 등록하는 것을 추천',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(text: '드립니다.'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvailableRegions() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '사용 가능 지역 및 통신사 확인하기',
            style: AppTypography.titleMedium.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          AppSpacing.heightMD,
          InkWell(
            onTap: () {
              // 지역 상세 보기
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.divider),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  Text(
                    product.region.name,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAPNSettings() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
          clipBehavior: Clip.antiAlias, // 자식이 부모의 borderRadius를 벗어나지 못하게
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryDark,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                ),
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.textOnPrimary,
                        borderRadius: BorderRadius.circular(1),
                      ),
                      child: Icon(
                        Icons.wifi_tethering_outlined,
                        size: 18,
                        color: AppColors.primary,
                      ),
                    ),
                    AppSpacing.widthSM,
                    Text(
                      'APN 설정',
                      style: AppTypography.titleSmall.copyWith(
                        color: AppColors.textOnPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  border: Border.all(color: AppColors.divider),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'APN: ',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                            letterSpacing: 0.1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: AppColors.textPrimary),
                            ),
                          ),
                          child: Text(
                            product.hashCode.toString(),
                            // underline
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        // 복사
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          border: Border.all(color: AppColors.borderLight),
                        ),
                        child: Text('복사', style: AppTypography.bodySmall),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        AppSpacing.heightMD,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              _buildAPNNote('단말에 eSIM 등록시 자동 설정됩니다.', true),
              _buildAPNNote(
                '현지에서 바로 개통되지 않을 때! 당황하지 말고 수동 APN을 설정해보세요.',
                false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAPNNote(String text, bool isHighlight) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '• ',
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
                height: 1.4,
                letterSpacing: 0.1,
              ),
              children: [
                if (isHighlight)
                  TextSpan(
                    text: text.substring(0, text.indexOf('자동')),
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                if (isHighlight)
                  TextSpan(
                    text: '자동 설정',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                if (isHighlight)
                  TextSpan(
                    text: text.substring(text.indexOf('자동') + 5),
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                if (!isHighlight) TextSpan(text: text),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailedCautions() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 32),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '주의사항',
            style: AppTypography.titleMedium.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          AppSpacing.heightLG,
          _buildCautionSection('유효 기간 및 사용 기간 적용 기준', [
            '유효 기간은 발권 완료일로부터 180일이며 180일 이내에 개통(현지 네트워크 접속)하시면 정상 사용이 가능합니다.',
            '개통(현지 네트워크 접속) 시점으로부터 24시간을 1일로 간주하여 구매한 상품의 데이터를 이용할 수 있습니다.\n(예) 사용 기간 : 5일 - 개통 후 120시간 동안 사용 가능)',
          ]),
          AppSpacing.heightLG,
          _buildCautionSection('음영 지역 및 해외 통신환경', [
            '현지 통신사의 통신 환경에 따라 데이터 이용이 원활하지 않은 지역이 일부 있을 수 있습니다.',
            '스마트폰 기종에 따라 특정 해외 통신사의 LTE 주파수와 맞지 않을 경우 3G 또는 2G로 연결될 수 있습니다.',
            '이는 해당 국가의 환경과 단말기 성능의 문제이기 때문에 서비스 불량 사유에 해당되지 않습니다.',
          ]),
          AppSpacing.heightLG,
          _buildCautionSection('eSIM 지원 단말 및 상품 등록', [
            '로케비 eSIM은 eSIM 지원 단말에서 이용할 수 있는 서비스입니다.',
            'eSIM 상품의 특성 상, 상품은 최초 등록된 기기에서만 등록·사용 가능합니다.',
            '중국에서 구매한 iPhone에는 eSIM이 제공되지 않습니다.',
          ]),
          AppSpacing.heightLG,
          _buildCautionSection('반품 및 환불', [
            '정상적인 회수 및 사용 중단이 어려운 상품의 특성상, 상품(QR코드)을 이메일 및 앱으로 발송 이후 혹은 단말에 QR코드 스캔 혹은 세부정보 기입을 통해 상품을 등록한 경우 단순 변심에 의한 교환/환불은 불가능합니다.',
            '해외 현지에서 이용되는 상품의 특성상, 상품 하자로 인한 환불 요청은 대부분 상품의 문제가 아닌 단말기 또는 설정 문제 등의 사유인 관계로, 고객센터를 통해 내용을 통보 후 상품 문제 확인이 완료된 경우에 한하여 처리됩니다.',
          ]),
        ],
      ),
    );
  }

  Widget _buildCautionSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.labelLarge.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        AppSpacing.heightSM,
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• ',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Expanded(
                  child: Text(
                    item,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _PlanDetailBottomBar extends StatelessWidget {
  final ProductPlan plan;

  const _PlanDetailBottomBar({required this.plan});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.divider)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, -2),
            blurRadius: 8,
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // 공유 버튼
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: const Icon(Icons.share_outlined),
                onPressed: () async {
                  await Clipboard.setData(
                    ClipboardData(text: '${plan.title} - ${plan.price}'),
                  );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('클립보드에 복사되었습니다'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }
                },
              ),
            ),

            AppSpacing.widthMD,

            // 구매하기 버튼
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('구매 페이지로 이동중')));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  '구매하기',
                  style: AppTypography.labelLarge.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
