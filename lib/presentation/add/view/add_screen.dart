import 'package:flutter/material.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/constants/text_styles.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: BoxDecoration(
            gradient: AppColor.backgroundGradient
        ),
        padding: EdgeInsets.symmetric(vertical: 16),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Text('add 페이지', style: AppTextStyles.loginMainTitle)],
          ),
        ),
      ),
    );
  }
}
