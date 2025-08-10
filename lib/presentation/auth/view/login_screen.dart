import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:isang/app_router.dart';
import 'package:isang/core/constants/app_color.dart';
import 'package:isang/core/constants/app_string.dart';
import 'package:isang/core/constants/text_styles.dart';
import '../../../data/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  Future<void> _handleKakaoLogin() async {
    if (_isLoading) return;
    
    setState(() {
      _isLoading = true;
    });

    try {
      final result = await _authService.loginWithKakao();

      final msg = result?['message'] ?? '처리 중...';
      final success = result?['success'] == true;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: success ? Colors.green : Colors.black87,
          duration: Duration(seconds: 2),
        ),
      );

      // 1) 서버가 즉시 토큰을 반환해 저장한 경우(현재 auth_service 구현)
      //    -> 바로 홈으로 이동
      // 2) 서버가 딥링크(isang://oauth)로 토큰을 전달하는 경우
      //    -> main.dart의 딥링크 핸들러가 네비게이션 수행
      if (success && mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.navigation);
      }
    } catch (error) {
      // 예외 처리
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('로그인 중 오류가 발생했습니다: $error'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  // 이미 로그인된 상태인지 확인
  Future<void> _checkLoginStatus() async {
    final isLoggedIn = await _authService.isLoggedIn();
    if (isLoggedIn && mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.navigation);
    }
  }

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
                child: GestureDetector(
                  child: _isLoading
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/icons/kakaoLoginIcon.svg'),
                            SizedBox(width: 12),
                            Text(
                              AppStrings.loginButtenText,
                              style: AppTextStyles.button,
                            )
                          ],
                        ),
                  onTap: _isLoading ? null : _handleKakaoLogin,
                ),
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
