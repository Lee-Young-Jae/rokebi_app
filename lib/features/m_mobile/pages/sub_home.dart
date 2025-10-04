import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rokebi_app/core/constants/app_radius.dart';
import 'package:rokebi_app/core/constants/app_shadows.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';

class MMobilePage extends StatefulWidget {
  const MMobilePage({super.key});

  @override
  State<MMobilePage> createState() => _MMobilePageState();
}

class _MMobilePageState extends State<MMobilePage>
    with TickerProviderStateMixin {
  int selectedTabIndex = 0;
  late ScrollController _scrollController;
  late AnimationController _dockingAnimationController;
  late Animation<double> _dockingAnimation;

  bool _isFloatingInputDocked = false;
  final GlobalKey _triggerKey = GlobalKey();
  final GlobalKey _bottomNavKey = GlobalKey();

  final List<String> categories = ['베스트', '아시아', '유럽', '미주/호주', '복수국가'];

  final Map<String, List<Map<String, dynamic>>> categorizedCountries = {
    '베스트': [
      {
        'title': '일본에서',
        'subtitle': '하루종일 걱정없이',
        'badges': ['무제한', '5G'],
        'image': 'assets/images/temp.jpg',
      },
      {
        'title': '한국에서',
        'subtitle': '빠르고 안정적으로',
        'badges': ['고속', '안정'],
        'image': 'assets/images/temp2.jpg',
      },
      {
        'title': '싱가포르에서',
        'subtitle': '편리하게 연결',
        'badges': ['편리', '빠름'],
        'image': 'assets/images/temp3.jpg',
      },
    ],
    '아시아': [
      {
        'title': '아시아에서',
        'subtitle': '편리하게 연결하세요',
        'badges': ['빠른속도', '저렴'],
        'image': 'assets/images/temp2.jpg',
      },
      {
        'title': '중국에서',
        'subtitle': '자유롭게 인터넷',
        'badges': ['VPN', '무제한'],
        'image': 'assets/images/temp.jpg',
      },
      {
        'title': '태국에서',
        'subtitle': '여행을 더 즐겁게',
        'badges': ['관광', '편리'],
        'image': 'assets/images/temp3.jpg',
      },
    ],
    '유럽': [
      {
        'title': '유럽에서',
        'subtitle': '자유롭게 여행하세요',
        'badges': ['다국가', '고속'],
        'image': 'assets/images/temp3.jpg',
      },
      {
        'title': '프랑스에서',
        'subtitle': '로맨틱한 여행',
        'badges': ['프리미엄', '고품질'],
        'image': 'assets/images/temp.jpg',
      },
      {
        'title': '독일에서',
        'subtitle': '효율적인 연결',
        'badges': ['안정', '빠름'],
        'image': 'assets/images/temp2.jpg',
      },
    ],
    '미주/호주': [
      {
        'title': '미주/호주에서',
        'subtitle': '새로운 경험을',
        'badges': ['프리미엄', '안정'],
        'image': 'assets/images/temp.jpg',
      },
      {
        'title': '미국에서',
        'subtitle': '무제한 데이터',
        'badges': ['무제한', '5G'],
        'image': 'assets/images/temp2.jpg',
      },
      {
        'title': '호주에서',
        'subtitle': '광활한 대륙 탐험',
        'badges': ['광역', '고속'],
        'image': 'assets/images/temp3.jpg',
      },
    ],
    '복수국가': [
      {
        'title': '복수국가에서',
        'subtitle': '한번에 해결하세요',
        'badges': ['올인원', '경제적'],
        'image': 'assets/images/temp.jpg',
      },
      {
        'title': '글로벌 패키지',
        'subtitle': '전 세계 어디든',
        'badges': ['글로벌', '패키지'],
        'image': 'assets/images/temp2.jpg',
      },
      {
        'title': '유럽 패키지',
        'subtitle': '유럽 전체 이용',
        'badges': ['유럽', '전체'],
        'image': 'assets/images/temp3.jpg',
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _dockingAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
      value: 1.0,
    );

    _dockingAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      // 0 도킹, 1 플로팅
      CurvedAnimation(
        parent: _dockingAnimationController,
        curve: Curves.easeInOutCubic,
      ),
    );

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _dockingAnimationController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final RenderObject? renderObject = _triggerKey.currentContext
        ?.findRenderObject();

    if (renderObject != null && renderObject is RenderBox) {
      final position = renderObject.localToGlobal(Offset.zero);
      final screenHeight = MediaQuery.of(context).size.height;

      // 타겟의 상단이 화면 하단보다 위에 있으면 화면에 보이는 것으로 판단
      final bool isVisible = position.dy < screenHeight;

      if (isVisible && !_isFloatingInputDocked) {
        // 트리거가 보인다면?
        setState(() {
          _isFloatingInputDocked = true;
        });
        _dockingAnimationController.reverse();
      } else if (!isVisible && _isFloatingInputDocked) {
        // 트리거가 안보인다면
        setState(() {
          _isFloatingInputDocked = false;
        });
        _dockingAnimationController.forward(); // 반대로
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.surface,
          appBar: AppBar(
            backgroundColor: AppColors.surface,
            title: Text(
              'M로밍',
              style: AppTypography.titleLarge.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            elevation: 0,
            actions: [
              // 도움말 버튼,
              IconButton(
                icon: const Icon(Icons.help_outline_sharp),
                onPressed: () {},
              ),
              // 알림 버튼
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_none_sharp),
                    onPressed: () {},
                  ),
                  Positioned(
                    top: 10,
                    right: 15,
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: AppRadius.borderRadiusFull,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          body: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 상단 컨텐츠 (패딩 적용)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSpacing.heightSM,
                      AppSpacing.heightSM,
                      AppSpacing.heightSM,
                      AppSpacing.heightSM,

                      Text(
                        '당신을 위한 eSIM',
                        style: AppTypography.titleLarge.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      AppSpacing.heightSM,
                      Text(
                        "여행지별 맞춤 eSIM을 찾아보세요.",
                        style: AppTypography.bodyMedium,
                      ),
                      AppSpacing.heightLG,
                      // 버튼 tab
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: categories.asMap().entries.map((entry) {
                          final index = entry.key;
                          final category = entry.value;
                          return MMobileButtonTab(
                            image: 'assets/images/ai_profile_1.webp',
                            text: category,
                            isSelected: selectedTabIndex == index,
                            onPressed: () {
                              setState(() {
                                selectedTabIndex = index;
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                // 슬라이더는 전체 화면 너비 사용
                SizedBox(
                  height: 500,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 16.0),
                    itemCount:
                        categorizedCountries[categories[selectedTabIndex]]!
                            .length,
                    itemBuilder: (context, index) {
                      final selectedCategory = categories[selectedTabIndex];
                      final countries = categorizedCountries[selectedCategory]!;
                      final country = countries[index];

                      return Container(
                        width:
                            MediaQuery.of(context).size.width *
                            0.75, // 화면 너비의 75%
                        height: 400, // 고정 높이 설정
                        margin: EdgeInsets.only(
                          right: index == countries.length - 1
                              ? 32.0
                              : 16.0, // 마지막 카드에만 추가 오른쪽 여백
                        ),
                        child: MMobileCountryCard(
                          image: country['image'] as String,
                          title: country['title'] as String,
                          subtitle: country['subtitle'] as String,
                          badges: List<String>.from(
                            country['badges'] as List<String>,
                          ),
                          onPressed: () {},
                        ),
                      );
                    },
                  ),
                ),
                // 하단 여백
                AppSpacing.heightLG,
                AppSpacing.heightLG,
                AppSpacing.heightLG,
                AppSpacing.heightLG,
                AppSpacing.heightLG,
                AppSpacing.heightLG,
                AppSpacing.heightLG,
                AppSpacing.heightLG,
                AppSpacing.heightLG,
                AppSpacing.heightLG,
                AppSpacing.heightLG,

                AppSpacing.heightLG,

                // 도킹 트리거
                Container(
                  key: _triggerKey,
                  height: 1, // 최소 높이
                  color: Colors.black,
                ),

                AppSpacing.heightXXXL,
                Container(
                  padding: AppSpacing.paddingLG,
                  decoration: BoxDecoration(color: AppColors.surfaceVariant),
                  child: Row(
                    children: [
                      Text("🎁"),
                      AppSpacing.widthSM,
                      Expanded(child: Text('여행가는 친구에게 eSIM을 선물해보세요!')),
                      AppSpacing.widthSM,
                      Icon(Icons.arrow_forward_ios_rounded),
                    ],
                  ),
                ),

                AppSpacing.heightXXXL,

                Text(
                  '지금 사랑받는 eSIM',
                  style: AppTypography.titleLarge.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),

                // 슬라이더는 전체 화면 너비 사용
                SizedBox(
                  height: 500,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 16.0),

                    itemCount:
                        categorizedCountries[categories[selectedTabIndex]]!
                            .length,
                    itemBuilder: (context, index) {
                      final selectedCategory = categories[selectedTabIndex];
                      final countries = categorizedCountries[selectedCategory]!;
                      final country = countries[index];

                      return Container(
                        width:
                            MediaQuery.of(context).size.width *
                            0.75, // 화면 너비의 75%
                        height: 400, // 고정 높이 설정
                        margin: EdgeInsets.only(
                          right: index == countries.length - 1
                              ? 32.0
                              : 16.0, // 마지막 카드에만 추가 오른쪽 여백
                        ),
                        child: MMobileCountryCard(
                          image: country['image'] as String,
                          title: country['title'] as String,
                          subtitle: country['subtitle'] as String,
                          badges: List<String>.from(
                            country['badges'] as List<String>,
                          ),
                          onPressed: () {},
                        ),
                      );
                    },
                  ),
                ),
                // 하단 여백
              ],
            ),
          ),
        ),
        // 네비게이션 바
        _buildStackedBottomNavigationBar(),
        // 모핑 인풋
        _buildMorphingInput(),
      ],
    );
  }

  // 성민님 이런 애니메이션을 Hero 애니메이션이라고 한답니다.
  Widget _buildStackedBottomNavigationBar() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        // Shadow를 위해서 외부에 BoxShadow를 줬는데 효과가 적용되지 않음
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: AppShadows.bottomSheetShadow,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Container(
            key: _bottomNavKey,
            decoration: const BoxDecoration(color: AppColors.surface),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(Icons.home_rounded, '홈', 0),
                      _buildNavItem(Icons.sim_card_rounded, 'eSIM', 1),
                      _buildNavItem(Icons.shopping_cart_rounded, '장바구니', 2),
                      _buildNavItem(Icons.receipt_long_rounded, '주문조회', 3),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).padding.bottom),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final bool isSelected = index == selectedTabIndex; // TODO: 선택 상태 관리

    return GestureDetector(
      onTap: () {
        // TODO: 네비게이션 처리
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // 플로팅에서 네비바로 안착하는 애니메이션 인풋
  Widget _buildMorphingInput() {
    return AnimatedBuilder(
      animation: _dockingAnimation,
      builder: (context, child) {
        final progress = _dockingAnimation.value;

        // 화면 정보
        final screenWidth = MediaQuery.of(context).size.width;
        final safeAreaBottom = MediaQuery.of(context).padding.bottom;

        // 네비게이션 바 높이 계산
        final navHeight = 72.0 + safeAreaBottom;

        // 위치 애니메이션
        final floatingBottom = navHeight + 16;
        final dockedBottom = navHeight - 14; // 네비바에 반쯤 겹침

        final animatedBottom =
            Tween<double>(begin: dockedBottom, end: floatingBottom)
                .animate(
                  CurvedAnimation(
                    parent: _dockingAnimationController,
                    curve: Curves.easeInOutCubic,
                  ),
                )
                .value;

        // 너비 애니메이션
        final floatingWidth = screenWidth - 32;
        final dockedWidth = screenWidth;

        final animatedWidth =
            Tween<double>(begin: dockedWidth, end: floatingWidth)
                .animate(
                  CurvedAnimation(
                    parent: _dockingAnimationController,
                    curve: Curves.easeInOutCubic,
                  ),
                )
                .value;

        // align center
        final horizontalOffset = (screenWidth - animatedWidth) / 2;

        // 높이 애니메이션
        final animatedHeight = Tween<double>(begin: 80.0, end: 56.0)
            .animate(
              CurvedAnimation(
                parent: _dockingAnimationController,
                curve: Curves.easeInOutCubic,
              ),
            )
            .value;

        // Rounded 애니메이션
        final animatedRadius = Tween<double>(begin: 20.0, end: 28.0)
            .animate(
              CurvedAnimation(
                parent: _dockingAnimationController,
                curve: Curves.easeInOutCubic,
              ),
            )
            .value;

        // 투명도 애니메이션
        final bgOpacity = Tween<double>(begin: 0.0, end: 0.3)
            .animate(
              CurvedAnimation(
                parent: _dockingAnimationController,
                curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
              ),
            )
            .value;

        // 콘텐츠 투명도
        final contentOpacity =
            Tween<double>(
                  begin: 0.0, // 도킹 시 콘텐츠 숨김
                  end: 1.0, // 플로팅 시 콘텐츠 보임
                )
                .animate(
                  CurvedAnimation(
                    parent: _dockingAnimationController,
                    curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
                  ),
                )
                .value;

        // 그림자 애니메이션
        final shadowOpacity = Tween<double>(begin: 0.0, end: 0.1)
            .animate(
              CurvedAnimation(
                parent: _dockingAnimationController,
                curve: const Interval(0.6, 1.0),
              ),
            )
            .value;

        // 블러
        final blurAmount = progress * 10.0;

        return Positioned(
          bottom: animatedBottom,
          left: horizontalOffset,
          child: Container(
            width: animatedWidth,
            height: animatedHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(animatedRadius),
                topRight: Radius.circular(animatedRadius),
                bottomLeft: Radius.circular(
                  progress < 0.3 ? 0 : animatedRadius, // 도킹 시 하단 직각
                ),
                bottomRight: Radius.circular(
                  progress < 0.3 ? 0 : animatedRadius,
                ),
              ),
              boxShadow: shadowOpacity > 0
                  ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: shadowOpacity),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [],
            ),
            child: Stack(
              children: [
                // 배경 레이어 (블러 + 색상)
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(animatedRadius),
                      topRight: Radius.circular(animatedRadius),
                      bottomLeft: Radius.circular(
                        progress < 0.3 ? 0 : animatedRadius,
                      ),
                      bottomRight: Radius.circular(
                        progress < 0.3 ? 0 : animatedRadius,
                      ),
                    ),
                    child: blurAmount > 0.1
                        ? BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: blurAmount,
                              sigmaY: blurAmount,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(
                                  alpha: bgOpacity * 0.8,
                                ),
                                border: bgOpacity > 0.01
                                    ? Border.all(
                                        color: Colors.white.withValues(
                                          alpha: 0.2,
                                        ),
                                        width: 0.5,
                                      )
                                    : null,
                              ),
                            ),
                          )
                        : Container(
                            color: bgOpacity > 0.01
                                ? Colors.white.withValues(alpha: bgOpacity)
                                : Colors.transparent,
                          ),
                  ),
                ),

                // 콘텐츠
                Opacity(
                  opacity: contentOpacity,
                  child: Material(
                    color: const Color.fromARGB(0, 251, 0, 0),
                    child: InkWell(
                      onTap: () {
                        debugPrint('플로팅 검색 탭됨');
                      },
                      borderRadius: BorderRadius.circular(28),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '어느 나라로 떠나시나요?',
                                  style: AppTypography.bodyLarge.copyWith(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const Icon(Icons.search_rounded, size: 24),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // 도킹 되었을 때는 이 UI 표시
                if (progress < 0.3)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(animatedRadius),
                          topRight: Radius.circular(animatedRadius),
                        ),
                        // top에만 border
                        border: Border(
                          top: BorderSide(color: AppColors.border, width: 1),
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: GestureDetector(
                          onTap: () {
                            debugPrint('도킹된 검색 탭됨');
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 34),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '어느 나라로 떠나시나요?',
                                          style: AppTypography.bodyLarge
                                              .copyWith(
                                                color: AppColors.textPrimary
                                                    .withValues(alpha: 0.8),
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.search_rounded,
                                        size: 24,
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: AppColors.border,
                                  height: 1,
                                ),
                                AppSpacing.heightMD,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// 버튼 tab (이미지, 텍스트)
class MMobileButtonTab extends StatelessWidget {
  final String image;
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const MMobileButtonTab({
    super.key,
    required this.image,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.borderRadiusFull,
          border: Border.all(
            color: isSelected ? AppColors.textPrimary : AppColors.border,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: AppRadius.borderRadiusFull,
                child: Image.asset(
                  image,
                  width: 24,
                  height: 24,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox.shrink(
                        child: Icon(Icons.image_not_supported),
                      ),
                ),
              ),
              AppSpacing.widthSM,
              Text(
                text,
                style: AppTypography.bodySmall.copyWith(
                  color: isSelected
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MMobileCountryCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final List<String> badges;
  final VoidCallback onPressed;

  const MMobileCountryCard({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.badges,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.surface,
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // 배경 이미지
                Image.asset(
                  image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: AppColors.border.withValues(alpha: 0.3),
                    child: const Icon(Icons.image_not_supported),
                  ),
                ),

                // 살짝 그라데이션
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.6),
                        ],
                      ),
                    ),
                  ),
                ),
                // 텍스트와 배지
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 제목
                      Text(
                        title,
                        style: AppTypography.titleLarge.copyWith(
                          color: AppColors.textOnPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      // 부제목
                      Text(
                        subtitle,
                        style: AppTypography.titleLarge.copyWith(
                          color: AppColors.textOnPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      // 배지들
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: badges
                            .map(
                              (badge) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.planWarningBox,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  badge,
                                  style: AppTypography.bodySmall.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
