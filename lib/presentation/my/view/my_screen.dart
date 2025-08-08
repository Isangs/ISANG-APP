import 'package:flutter/material.dart';
import 'package:isang/core/constants/app_color.dart';
import 'package:isang/presentation/common/custom_app_bar.dart';
import 'package:isang/presentation/my/widget/badge_card.dart';
import 'package:isang/presentation/my/widget/chart_card.dart';
import 'package:isang/presentation/my/widget/goal_percentage_card.dart';
import 'package:isang/presentation/my/widget/goal_score_card.dart';
import 'package:isang/presentation/my/widget/my_record_card.dart';
import 'package:isang/presentation/my/widget/profile_card.dart';
import 'package:isang/presentation/my/widget/recent_activity_card.dart';


class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: MyAppBar(title: '내 정보', icon: 'setting'),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColor.backgroundGradient),
        padding: EdgeInsets.only(bottom: 16, top: 8, left: 16, right: 16),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProfileCard(),
                SizedBox(height: 24,),
                GoalScoreCard(),
                SizedBox(height: 24,),
                ChartCard(),
                SizedBox(height: 24,),
                GoalPercentageCard(),
                SizedBox(height: 24,),
                BadgeCard(),
                SizedBox(height: 24,),
                MyRecordCard(),
                SizedBox(height: 24,),
                RecentActivityCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
