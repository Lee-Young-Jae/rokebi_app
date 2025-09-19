import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';

class BannerCarousel extends StatefulWidget {
  final bool isVisible;
  final VoidCallback? onClose;

  const BannerCarousel({super.key, required this.isVisible, this.onClose});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  late PageController _pageController;
  late Timer _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 1000, // 중간에서 시작하여 무한 스크롤 효과를 준다.
    );

    // 자동 슬라이더
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildCarousel();
  }

  Widget _buildCarousel() {
    final bannerData = [
      {
        'title': '해외 로밍을 더 저렴하게!',
        'subtitle': '전 세계 어디서든 안전하고 빠른 데이터',
        'imageUrl':
            'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&h=300&fit=crop',
      },
      {
        'title': '신규 가입 혜택',
        'subtitle': '첫 구매 시 최대 30% 할인',
        'imageUrl':
            'https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?w=800&h=300&fit=crop',
      },
      {
        'title': '24시간 고객지원',
        'subtitle': '언제든지 문의하세요',
        'imageUrl':
            'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=800&h=300&fit=crop',
      },
    ];

    return Container(
      height: 120,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index % bannerData.length;
              });
            },
            itemBuilder: (context, index) {
              final banner = bannerData[index % bannerData.length];
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // 배경 이미지
                    Image.network(
                      banner['imageUrl'] as String,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            gradient: index % 2 == 0
                                ? AppColors.primaryGradient
                                : AppColors.secondaryGradient,
                          ),
                        );
                      },
                    ),
                    // 오버레이
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.black.withValues(alpha: 0.6),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    // 컨텐츠
                    Positioned(
                      left: 20,
                      top: 20,
                      bottom: 20,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            banner['title'] as String,
                            style: AppTypography.titleMedium.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            banner['subtitle'] as String,
                            style: AppTypography.bodySmall.copyWith(
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          // 페이지 인디케이터
          Positioned(
            bottom: 12,
            right: 20,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                bannerData.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
