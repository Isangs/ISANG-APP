import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/constants/text_styles.dart';

class MyRecordCard extends StatelessWidget {
  const MyRecordCard({super.key});

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
              Text('내 기록', style: AppTextStyles.mypageMainTitle),
              GestureDetector(
                onTap: () => print('전체 보기'),
                child: Text(
                  '전체 보기',
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
          
          // 기록 항목들
          Column(
            children: [
              // 첫 번째 기록
              _buildRecordItem(
                date: '2024-01-15',
                content: '오늘 정말 힘들었지만 모든 할일을 완료했다!',
                isPublic: true,
              ),
              const SizedBox(height: 16),
              // 두 번째 기록
              _buildRecordItem(
                date: '2024-01-14',
                content: '운동 30분 완료. 체력이 조금씩 늘고 있는 것 같다.',
                isPublic: false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecordItem({
    required String date,
    required String content,
    required bool isPublic,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 상단 행 (날짜, 삭제 아이콘)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                date,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                onTap: () => print('삭제'),
                child: SvgPicture.asset(
                  'assets/icons/myRecordDelate.svg',
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // 내용
          Text(
            content,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          // 하단 행 (공개/비공개 상태)
          Row(
            children: [
              SvgPicture.asset(
                isPublic ? 'assets/icons/public.svg' : 'assets/icons/private.svg',
                width: 16,
                height: 16,
                colorFilter: ColorFilter.mode(
                  Colors.grey[600]!,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                isPublic ? '공개' : '비공개',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
