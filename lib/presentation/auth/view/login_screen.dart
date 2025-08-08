import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:isang/app_router.dart';
import 'package:isang/core/constants/app_color.dart';
import 'package:isang/core/constants/app_string.dart';
import 'package:isang/core/constants/text_styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(gradient: AppColor.backgroundGradient),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: AppColor.purpleGradient,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(height: 24),
              Text(
                AppStrings.loginTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF1F2937),
                  fontSize: 30,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  height: 1.20,
                ),
              ),
              SizedBox(height: 8),
              Text(
                AppStrings.longinSubtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF4A5462),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                ),
              ),
              SizedBox(height: 280),
              Container(
                width: double.infinity,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: AppColor.yellowGradient,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: GestureDetector(child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/kakaoLoginIcon.svg'),
                    SizedBox(width: 12,),
                    Text(AppStrings.loginButtenText,
                    style: AppTextStyles.button,)
                  ],
                ),
                onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.navigation)),
              ),
              SizedBox(height: 60),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: AppStrings.loginTermsStart,
                      style: AppTextStyles.linkGrey
                    ),
                    TextSpan(
                      text: AppStrings.loginTermsStartMiddle,
                      style: AppTextStyles.linkPurple
                    ),
                    TextSpan(
                      text: AppStrings.loginTermsMiddle,
                      style: AppTextStyles.linkGrey
                    ),
                    TextSpan(
                      text: AppStrings.loginTermsMiddleEnd,
                      style: AppTextStyles.linkPurple
                    ),
                    TextSpan(
                      text: AppStrings.loginTermsEnd,
                      style: AppTextStyles.linkGrey
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
