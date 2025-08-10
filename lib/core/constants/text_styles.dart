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

  // ────────────── 표준 텍스트 스타일 ──────────────
  // Body 텍스트 (일반 본문)
  static const TextStyle body1 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColor.textPrimary,
    height: 1.5,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColor.textPrimary,
    height: 1.4,
  );

  // Caption 텍스트 (작은 설명 텍스트)
  static const TextStyle caption = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColor.textSecondary,
    height: 1.3,
  );

  // Headline 텍스트
  static const TextStyle headline1 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColor.textPrimary,
    height: 1.2,
  );

  static const TextStyle headline2 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColor.textPrimary,
    height: 1.3,
  );

  static const TextStyle headline3 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColor.textPrimary,
    height: 1.3,
  );

  // Subtitle 텍스트
  static const TextStyle subtitle1 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColor.textPrimary,
    height: 1.4,
  );

  static const TextStyle subtitle2 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColor.textSecondary,
    height: 1.4,
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
  static const TextStyle profileCardName = TextStyle(
    color: AppColor.textPrimary,
    fontSize: 20,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle mypageMainTitle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColor.textPrimary,
  );

  static const TextStyle mypageNickName = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColor.textPrimary,
  );

  static const TextStyle profileIntro = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColor.profileIntroText,
  );

  static const TextStyle mypageDetailText = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColor.textPrimaryPurple,
  );

  static const TextStyle levelAndScoreText = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle progressBarName = TextStyle(
    color: AppColor.progressBarName,
    fontSize: 14,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle progressBarScore = TextStyle(
  color: AppColor.textPrimaryPurple,
  fontSize: 14,
  fontFamily: _fontFamily,
  fontWeight: FontWeight.w700,
  );

  static const TextStyle progressBarMaxScore = TextStyle(
    color: AppColor.profileIntroText,
    fontSize: 14,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle progressBarPercent = TextStyle(
    color: AppColor.progressBarPercent,
    fontSize: 14,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle goalPercentage = TextStyle(
    color: Color(0xFF374050),
    fontSize: 14,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    height: 1.33,
  );
}
