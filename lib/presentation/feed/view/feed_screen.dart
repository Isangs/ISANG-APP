import 'package:flutter/material.dart';
import 'package:isang/core/constants/text_styles.dart';
import 'package:isang/presentation/common/custom_app_bar.dart';

import '../../../core/constants/app_color.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FeedAppBar(title: '피드', firstIcon: 'search', secondIcon: 'bell'),
      body: Container(
        width: double.infinity,

        decoration: BoxDecoration(gradient: AppColor.backgroundGradient),
        padding: EdgeInsets.symmetric(vertical: 16),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Text('feed 페이지', style: AppTextStyles.loginMainTitle)],
          ),
        ),
      ),
    );
  }
}