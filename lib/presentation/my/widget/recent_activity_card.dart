import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/constants/text_styles.dart';

class RecentActivityCard extends StatelessWidget {
  const RecentActivityCard({super.key});

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
              Text('최근 활동', style: AppTextStyles.mypageMainTitle),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => print('새로 고침'),
                    child: SvgPicture.asset(
                      'assets/icons/refresh.svg',
                      width: 32,
                      height: 32,
                    ),
                  ),
                  const SizedBox(width: 8),
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
            ],
          ),
          const SizedBox(height: 24),
          
          // 활동 목록
          Column(
            children: [
              // 첫 번째 활동
              _buildActivityItem(
                title: '30분 조깅 완료',
                time: '2시간 전',
                description: '"한강공원에서 3km 달리기 완료!"',
              ),
              const SizedBox(height: 16),
              // 두 번째 활동
              _buildActivityItem(
                title: '영어 단어 50개 암기',
                time: '4시간 전',
                description: '"오늘 새로운 단어 50개 외웠어요."',
              ),
              const SizedBox(height: 16),
              // 세 번째 활동
              _buildActivityItem(
                title: '프로젝트 회의 참석',
                time: '어제',
                description: '"팀 회의에서 새로운 아이디어 제안"',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem({
    required String title,
    required String time,
    required String description,
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
      child: Row(
        children: [
          // 왼쪽 체크 아이콘
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: AppColor.purpleGradient,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          // 중앙 내용
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 제목
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                // 시간
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                // 설명
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // 오른쪽 X 아이콘
          GestureDetector(
            onTap: () => print('삭제'),
            child: Icon(
              Icons.close,
              size: 20,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}
