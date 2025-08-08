import 'dart:math';

import 'package:flutter/material.dart';
import 'package:isang/core/constants/app_color.dart';
import 'package:isang/core/constants/text_styles.dart';

class GoalPercentageCard extends StatelessWidget {
  const GoalPercentageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [AppColor.shadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('목표 달성률', style: AppTextStyles.mypageMainTitle),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              GoalCircularIndicator(label: '운동', percent: 0.85),
              GoalCircularIndicator(label: '학습', percent: 0.72),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              GoalCircularIndicator(label: '업무', percent: 0.90),
              GoalCircularIndicator(label: '건강', percent: 0.68),
            ],
          ),
        ],
      ),
    );
  }
}

class GoalCircularIndicator extends StatelessWidget {
  final String label;
  final double percent;

  const GoalCircularIndicator({
    super.key,
    required this.label,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: const Size(80, 80),
              painter: DottedCirclePainter(),
            ),
            Text(
              "${(percent * 100).round()}%",
              style: AppTextStyles.goalPercentage,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTextStyles.progressBarName,
        ),
      ],
    );
  }
}
class DottedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double strokeWidth = 8;
    final center = size.center(Offset.zero);
    final radius = (size.width / 2) - (strokeWidth / 2);

    final Paint basePaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Paint activePaint = Paint()
      ..color = AppColor.primary
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // 배경 원 전체
    canvas.drawCircle(center, radius, basePaint);

    // 중심 각도 기준으로 4구간만 색칠
    final List<double> startAngles = [0, pi / 2, pi, 3 * pi / 2];
    const double sweepAngle = pi / 4; // = 36도 (넓게)

    for (double centerAngle in startAngles) {
      final double startAngle = centerAngle - (sweepAngle / 2); // 중심 기준 좌우 나눔
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        activePaint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
