import 'package:flutter/cupertino.dart';
import 'package:isang/core/constants/text_styles.dart';
import 'package:isang/presentation/my/widget/goal_progress_bar.dart';

import '../../../core/constants/app_color.dart';

class GoalScoreCard extends StatelessWidget {
  const GoalScoreCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 421,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [AppColor.shadow],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('목표별 점수', style: AppTextStyles.mypageMainTitle),
              GestureDetector(
                onTap: () => print('자세히 보기'),
                child: Text('자세히 보기', style: AppTextStyles.mypageDetailText),
              ),
            ],
          ),
          SizedBox(height: 16),
          GoalProgressBar(
            progressBarName: '운동',
            current: 340,
            total: 400,
            percentage: 0.85,
            gradientColors: AppColor.redGradient,
          ),
          SizedBox(height: 16),
          GoalProgressBar(
            progressBarName: '학습',
            current: 288,
            total: 400,
            percentage: 0.72,
            gradientColors: AppColor.blueGradient,
          ),
          SizedBox(height: 16),
          GoalProgressBar(
            progressBarName: '업무',
            current: 360,
            total: 400,
            percentage: 0.90,
            gradientColors: AppColor.greenGradient,
          ),
          SizedBox(height: 16),
          GoalProgressBar(
            progressBarName: '건강',
            current: 272,
            total: 400,
            percentage: 0.68,
            gradientColors: AppColor.tealGradient,
          ),
          SizedBox(height: 16),
          GoalProgressBar(
            progressBarName: '개인 성장',
            current: 220,
            total: 400,
            percentage: 0.55,
            gradientColors: AppColor.purpleGradient,
          ),
          
        ],
      ),
    );
  }
}
