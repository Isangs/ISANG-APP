import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/constants/text_styles.dart';

class ChartCard extends StatefulWidget {
  const ChartCard({super.key});

  @override
  State<ChartCard> createState() => _ChartCardState();
}

class _ChartCardState extends State<ChartCard> {
  bool isLinearSelected = true;
  bool isAreaSelected = false;

  // 운동 데이터
  final List<FlSpot> exerciseData = [
    const FlSpot(0, 20),
    const FlSpot(1, 45),
    const FlSpot(2, 30),
    const FlSpot(3, 60),
    const FlSpot(4, 40),
    const FlSpot(5, 70),
    const FlSpot(6, 55),
  ];

  // 학습 데이터
  final List<FlSpot> studyData = [
    const FlSpot(0, 15),
    const FlSpot(1, 35),
    const FlSpot(2, 50),
    const FlSpot(3, 25),
    const FlSpot(4, 65),
    const FlSpot(5, 40),
    const FlSpot(6, 30),
  ];

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
          // 헤더 섹션
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '주간 성과 차트',
                style: AppTextStyles.mypageMainTitle,
              ),
              // 토글 버튼들
              Row(
                children: [
                  _buildToggleButton(
                    '선형',
                    isLinearSelected,
                    () => setState(() {
                      isLinearSelected = true;
                      isAreaSelected = false;
                    }),
                  ),
                  const SizedBox(width: 8),
                  _buildToggleButton(
                    '영역',
                    isAreaSelected,
                    () => setState(() {
                      isLinearSelected = false;
                      isAreaSelected = true;
                    }),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // 운동 섹션
          _buildChartSection(
            title: '운동',
            score: '340점',
            data: exerciseData,
            isAreaChart: isAreaSelected,
          ),
          const SizedBox(height: 16),
          
          // 학습 섹션
          _buildChartSection(
            title: '학습',
            score: '288점',
            data: studyData,
            isAreaChart: isAreaSelected,
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primary : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildChartSection({
    required String title,
    required String score,
    required List<FlSpot> data,
    required bool isAreaChart,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F5FF), // 연한 보라색 배경
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 제목과 점수
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Text(
                score,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // 차트
          SizedBox(
            height: 120,
            child: isAreaChart ? _buildAreaChart(data) : _buildLineChart(data),
          ),
        ],
      ),
    );
  }

  Widget _buildAreaChart(List<FlSpot> data) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: data,
            isCurved: true,
            color: AppColor.primary,
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: AppColor.primary.withOpacity(0.3),
            ),
          ),
        ],
        minX: 0,
        maxX: 6,
        minY: 0,
        maxY: 80,
      ),
    );
  }

  Widget _buildLineChart(List<FlSpot> data) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: data,
            isCurved: true,
            color: AppColor.primary,
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
        ],
        minX: 0,
        maxX: 6,
        minY: 0,
        maxY: 80,
      ),
    );
  }
}
