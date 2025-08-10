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
import '../../../data/services/auth_service.dart';
import '../../../app_router.dart';


class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  final AuthService _authService = AuthService();

  // 설정 메뉴 표시
  void _showSettingsMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                Text(
                  '설정',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.red),
                  title: Text(
                    '로그아웃',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _showLogoutConfirmDialog();
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  // 로그아웃 확인 다이얼로그
  void _showLogoutConfirmDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('로그아웃'),
          content: Text('정말 로그아웃하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _handleLogout();
              },
              child: Text(
                '로그아웃',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  // 로그아웃 처리
  Future<void> _handleLogout() async {
    try {
      final result = await _authService.logout();
      
      if (result['success'] == true) {
        // 로그아웃 성공 - 로그인 화면으로 이동
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.login,
            (route) => false,
          );
        }
      } else {
        // 로그아웃 실패
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('로그아웃 중 오류가 발생했습니다.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('로그아웃 중 오류가 발생했습니다.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: MyAppBar(
        title: '내 정보', 
        icon: 'setting',
        onIconPressed: _showSettingsMenu,
      ),
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
