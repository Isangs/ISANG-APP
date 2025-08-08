import 'package:flutter/material.dart';
import 'package:isang/core/constants/app_color.dart';
import 'package:isang/core/constants/text_styles.dart';

class GoalProgressBar extends StatelessWidget {
  final String progressBarName;
  final int current;
  final int total;
  final double percentage;
  final LinearGradient gradientColors;

  const GoalProgressBar({
    super.key,
    required this.progressBarName,
    required this.current,
    required this.total,
    required this.percentage,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 상단 텍스트
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: gradientColors,
              ),
            ),
            const SizedBox(width: 8),
            Text(progressBarName, style: AppTextStyles.progressBarName),
            const Spacer(),
            Text("$current점", style: AppTextStyles.progressBarScore),
            Text(" / $total점", style: AppTextStyles.progressBarMaxScore),
          ],
        ),
        const SizedBox(height: 8),
        // 게이지 바
        Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: 12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColor.backgroundprogressBar,
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: percentage,
                    child: Container(
                      height: 12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: gradientColors,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "${(percentage * 100).round()}%",
              style: AppTextStyles.progressBarPercent,
            ),
          ],
        ),
      ],
    );
  }
}
