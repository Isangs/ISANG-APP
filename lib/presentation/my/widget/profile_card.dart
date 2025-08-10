import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:isang/core/constants/app_color.dart';
import 'package:isang/core/constants/text_styles.dart';
import 'profile_edit_dialog.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  String userName = '김이상';
  String userNickname = '@isang_achiever';
  String userEmail = 'isang@example.com';
  String userBio = '매일 성장하는 개발자입니다!';
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 194,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [AppColor.shadow],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  gradient: AppColor.purpleGradient,
                  shape: BoxShape.circle,
                ),
              ),
              // 선택된 이미지가 있으면 표시, 없으면 기본 아이콘
              selectedImage != null
                  ? ClipOval(
                      child: Image.file(
                        selectedImage!,
                        width: 72,
                        height: 72,
                        fit: BoxFit.cover,
                      ),
                    )
                  : SvgPicture.asset(
                      'assets/icons/kakaoLoginIcon.svg',
                      height: 72,
                      width: 72,
                    ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userName, style: AppTextStyles.profileCardName),
                Text(userNickname, style: AppTextStyles.mypageNickName),
                Container(
                  alignment: Alignment.center,
                  height: 40,
                  child: Text(userBio, style: AppTextStyles.profileIntro),
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/level.svg'),
                        const SizedBox(width: 4),
                        Text('레벨 15', style: AppTextStyles.levelAndScoreText),
                      ],
                    ),
                    const SizedBox(width: 7),
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/score.svg'),
                        const SizedBox(width: 4),
                        Text('2827점', style: AppTextStyles.levelAndScoreText),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => _showProfileEditDialog(context),
                icon: SvgPicture.asset(
                  'assets/icons/edit.svg',
                  width: 32,
                  height: 32,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }

  void _showProfileEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProfileEditDialog(
          initialName: userName,
          initialNickname: userNickname,
          initialEmail: userEmail,
          initialBio: userBio,
          initialImage: selectedImage, // 현재 선택된 이미지를 초기값으로 전달
          onSave: (name, nickname, email, bio) {
            setState(() {
              userName = name;
              userNickname = nickname;
              userEmail = email;
              userBio = bio;
            });
          },
          onImageChanged: (image) {
            setState(() {
              selectedImage = image;
            });
          },
        );
      },
    );
  }

  // 이미지 업데이트 메서드 (다이얼로그에서 호출할 수 있도록)
  void updateProfileImage(File? image) {
    setState(() {
      selectedImage = image;
    });
  }
}
