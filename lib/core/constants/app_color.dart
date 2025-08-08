import 'package:flutter/material.dart';

/// 앱 전체에서 사용하는 컬러 정의
class AppColor {
  // ────────────── 기본 테마 컬러 ──────────────
  static const Color primary = Color(0xFFA855F7); // 주 테마
  static const Color secondary = Color(0xFFB07CF0); // 보조 테마
  static const Color tertiary = Color(0xFFFFA94D); // 선택적 3차 컬러

  // ────────────── 배경 컬러 ──────────────
  static const Color background = Color(0xFFFFFFFF); // 기본 흰색
  static const Color backgroundLight = Color(0xFFF9FAFB); // 옅은 회색
  static const Color backgroundprogressBar = Color(0xFFE5E7EB); // 게이지 바 배경

  // ────────────── 텍스트 컬러 ──────────────N
  static const Color textPrimary = Color(0xFF1F2937); // 메인 글씨
  static const Color textSecondary = Color(0xFF6B7280); // 서브 글씨
  static const Color textTertiary = Color(0xFF9CA3AF); // 비활성 글씨
  static const Color textPrimaryPurple = Color(0xFF9333EA); // 활성 글씨(보라)
  static const Color textSub = Color(0xFF4B5563); // 앱바 서브 텍스트
  static const Color nickNameText = Color(0xFF4B5563);
  static const Color profileIntroText = Color(0xFF6B7280);
  static const Color progressBarName = Color(0xFF374050);
  static const Color progressBarPercent = Color(0xFF4A5462);
  static const Color goalPercentage = Color(0xFF374151);

  // ────────────── 상태 컬러 ──────────────
  static const Color success = Color(0xFF10B981); // 완료, 성공
  static const Color warning = Color(0xFFF59E0B); // 경고
  static const Color error = Color(0xFFEF4444); // 에러

  // ────────────── 카테고리 컬러 ──────────────
  // 목표/할 일 카테고리별 색상
  static const Map<String, Color> goalColors = {
    '운동': Color(0xFFFB923C), // 주황
    '학습': Color(0xFF60A5FA), // 파랑
    '업무': Color(0xFF4ADE80), // 초록
    '건강': Color(0xFF22D3EE), // 청록
    '개인성장': Color(0xFFC084FC), // 보라
  };

  // ────────────── 그라데이션 컬러 ──────────────
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFFFAF5FF), Color(0xFFEFF6FF), Color(0xFFE0E7FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient redGradient = LinearGradient(
    colors: [Color(0xFFFB923C), Color(0xFFEF4444)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient blueGradient = LinearGradient(
    colors: [Color(0xFF60A5FA), Color(0xFF6366F1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient greenGradient = LinearGradient(
    colors: [Color(0xFF4ADE80), Color(0xFF10B981)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient tealGradient = LinearGradient(
    colors: [Color(0xFF22D3EE), Color(0xFF14B8A6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient purpleGradient = LinearGradient(
    colors: [Color(0xFFC084FC), Color(0xFFEC4899)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient yellowGradient = LinearGradient(
    colors: [Color(0xffFACC15), Color(0xFFEAB308)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ────────────── 그림자 ──────────────
  static final BoxShadow shadow = BoxShadow(
    color: Colors.black.withOpacity(0.15),
    blurRadius: 12,
    offset: Offset(0, 10),
    spreadRadius: 0,
  );
}
