# 이상 (ISANG) — AI 기반 목표·할일 매칭 앱

> "이상을 현실로" — AI가 목표를 분석해 오늘의 할 일을 자동으로 추천해주는 목표 달성 앱

## 📱 프로젝트 소개

**이상(ISANG)** 은 사용자가 설정한 목표를 AI가 분석하여 실천 가능한 오늘의 할 일로 분해해주는 Flutter 기반 모바일 앱입니다.
목표 달성 과정을 기록하고, 점수와 배지로 동기를 유지하며, 피드를 통해 다른 사용자와 도전을 공유할 수 있습니다.

## 👥 팀 구성 및 담당 역할

| 역할 | 인원 | 담당 |
|------|------|------|
| 기획 | 1명 | 서비스 기획, UX 설계 |
| 프론트엔드 | 1명 | 웹 버전 개발 |
| **앱 개발 (나)** | **1명** | **Flutter 앱 전체 개발** |
| 백엔드 | 2명 | REST API 서버, DB 설계 |

> **개발 기간**: 2주 (MVP 완성 및 배포)

## 🛠 기술 스택

| 분류 | 기술 |
|------|------|
| Framework | Flutter / Dart |
| 상태관리 | Riverpod (ChangeNotifierProvider) |
| HTTP 통신 | Dio + JWT 자동 갱신 인터셉터 |
| 인증 | Kakao OAuth SDK |
| 토큰 저장 | flutter_secure_storage |
| 아키텍처 | Clean Architecture + MVVM |
| 협업 | GitHub (브랜치 전략, PR 리뷰) |

## 📂 프로젝트 구조

lib/
├── core/         # 색상, 네트워크, 테마, 유틸
├── data/         # datasource, dto, model, repository 구현체
├── domain/       # entity, repository 인터페이스, usecase
└── presentation/ # auth / home / feed / my / navigation

## ✨ 주요 기능

### 🔐 인증
- 카카오 OAuth 소셜 로그인
- JWT 토큰 자동 갱신 (401 에러 시 재발급 후 원래 요청 재시도)
- 앱 재실행 시 자동 로그인

### 🏠 홈 (목표 관리)
- 카테고리별 목표 카드, 필터 탭
- 목표/카테고리 추가·삭제, 공개 범위 설정

### 📢 피드
- 달성 기록 피드, 실시간 검색, 좋아요·댓글·공유

### 👤 마이페이지
- 프로필 편집, 주간 차트, 배지, 레벨/점수, 로그아웃

## 🚀 실행 방법

flutter pub get
flutter run

> 카카오 로그인을 위해 kakao_native_app_key 설정 필요

## 🌐 API 서버

- Base URL: https://api.isang.site
- 인증 방식: Bearer JWT Token
