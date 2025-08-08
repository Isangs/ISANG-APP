import 'package:flutter/material.dart';
import 'package:isang/presentation/common/custom_app_bar.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/constants/text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        title: '오늘의 목표',
        subTitle: '힘내서 완료해보세요! 💪',
        icon: 'delate',
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(gradient: AppColor.backgroundGradient),
        padding: EdgeInsets.symmetric(vertical: 16),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Text('Home 페이지', style: AppTextStyles.loginMainTitle)],
          ),
        ),
      ),
    );
  }
}
