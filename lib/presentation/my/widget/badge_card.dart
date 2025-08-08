import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/constants/text_styles.dart';

class BadgeCard extends StatelessWidget {
  const BadgeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [AppColor.shadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 헤더
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('배지 갤러리', style: AppTextStyles.mypageMainTitle),
              GestureDetector(
                onTap: () => print('자세히 보기'),
                child: Text(
                  '자세히 보기',
                  style: TextStyle(
                    color: AppColor.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // 배지 그리드 (2x3)
          Column(
            children: [
              // 첫 번째 행
              Row(
                children: [
                  Expanded(
                    child: _buildBadge(
                      title: '3일 연속',
                      iconPath: 'assets/icons/badgeFire.svg',
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF6B35), Color(0xFFFF4757)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      isUnlocked: true,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildBadge(
                      title: '100점 돌파',
                      iconPath: 'assets/icons/badgeCrown.svg',
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF6B35), Color(0xFFFFD93D)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      isUnlocked: true,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildBadge(
                      title: '완벽한 주',
                      iconPath: 'assets/icons/badgeStar.svg',
                      gradient: const LinearGradient(
                        colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      isUnlocked: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // 두 번째 행
              Row(
                children: [
                  Expanded(
                    child: _buildBadge(
                      title: '초보 탈출',
                      iconPath: 'assets/icons/badgeBand.svg',
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      isUnlocked: true,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMonthlyKingBadge(
                      title: '월간 왕',
                      progress: 0.6,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildBadge(
                      title: '마스터',
                      iconPath: 'assets/icons/badgeMasterOff.svg',
                      gradient: null,
                      isUnlocked: false,
                      progress: 0.3,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyKingBadge({
    required String title,
    required double progress,
  }) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 제목
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            // 진행률 바
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[400]!),
                minHeight: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge({
    required String title,
    String? iconPath,
    LinearGradient? gradient,
    required bool isUnlocked,
    double? progress,
  }) {
    return AspectRatio(
      aspectRatio: 1.0, // 정사각형 비율
      child: Container(
        decoration: BoxDecoration(
          gradient: isUnlocked ? gradient : null,
          color: isUnlocked ? null : Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            // 아이콘 (아이콘이 있는 경우에만)
            if (iconPath != null)
              Positioned(
                top: 16,
                left: 0,
                right: 0,
                child: Center(
                  child: SvgPicture.asset(
                    iconPath,
                    width: 32,
                    height: 32,
                    colorFilter: ColorFilter.mode(
                      isUnlocked ? Colors.white : Colors.grey[400]!,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            // 제목
            Positioned(
              bottom: 16,
              left: 8,
              right: 8,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isUnlocked ? Colors.white : Colors.grey[600],
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
            ),
            // 진행률 바 (잠금 해제되지 않은 배지에만)
            if (!isUnlocked && progress != null)
              Positioned(
                bottom: 8,
                left: 8,
                right: 8,
                child: Column(
                  children: [
                    const SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[400]!),
                      minHeight: 4,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
