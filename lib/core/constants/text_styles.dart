import 'package:flutter/material.dart';
import 'package:isang/core/constants/app_color.dart';

class AppTextStyles {
  static const String _fontFamily = 'Roboto';

  // 타이틀 (예: "Isang")
  static const TextStyle loginMainTitle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 30,
    fontWeight: FontWeight.w700,
    color: AppColor.primary,
  );

  // 서브타이틀 (예: "더 나은 하루를 만들어보세요")
  static const TextStyle loginsubtitle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColor.textSecondary,
  );

  // 버튼 텍스트
  static const TextStyle button = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColor.textPrimary,
  );

  // 약관 링크 텍스트
  static const TextStyle linkGrey = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    color: AppColor.textSecondary,
  );

  static const TextStyle linkPurple = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    color: AppColor.textPrimaryPurple,
  );

  // 네비게이션바 텍스트
  static const TextStyle navigationbarOff = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColor.textSecondary,
  );

  static const TextStyle navigationbarOn = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColor.textPrimaryPurple,
  );

  //앱바 텍스트
  static const TextStyle appBarTitle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColor.textPrimary,
  );

  static const TextStyle appBarSubTitle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColor.textSub,
  );

  //카드 텍스트
  static const profileCardName = TextStyle(
    color: AppColor.textPrimary,
    fontSize: 20,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
  );

  static const mypageMainTitle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColor.textPrimary,
  );

  static const mypageNickName = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColor.textPrimary,
  );

  static const profileIntro = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColor.profileIntroText,
  );

  static const mypageDetailText = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColor.textPrimaryPurple,
  );

  static const levelAndScoreText = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
  );

  static const progressBarName = TextStyle(
    color: AppColor.progressBarName,
    fontSize: 14,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
  );

  static const progressBarScore = TextStyle(
  color: AppColor.textPrimaryPurple,
  fontSize: 14,
  fontFamily: _fontFamily,
  fontWeight: FontWeight.w700,
  );

  static const progressBarMaxScore = TextStyle(
    color: AppColor.profileIntroText,
    fontSize: 14,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
  );

  static const progressBarPercent = TextStyle(
    color: AppColor.progressBarPercent,
    fontSize: 14,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
  );

  static const goalPercentage = TextStyle(
    color: Color(0xFF374050),
    fontSize: 14,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    height: 1.33,
  );
}
