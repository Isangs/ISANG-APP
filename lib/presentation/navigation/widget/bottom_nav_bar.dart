import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:isang/core/constants/app_color.dart';
import 'package:isang/core/constants/text_styles.dart';


class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColor.background,
      selectedLabelStyle: AppTextStyles.navigationbarOn,
      selectedFontSize: 0,
      unselectedFontSize: 0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/icons/homeIcon.svg',
                color: currentIndex == 0
                    ? AppColor.textPrimaryPurple
                    : AppColor.textSecondary,
              ),
              SizedBox(height: 6),
              Text(
                'Home',
                style: currentIndex == 0
                    ? AppTextStyles.navigationbarOn
                    : AppTextStyles.navigationbarOff,
              ),
            ],
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/icons/myIcon.svg',
                color: currentIndex == 1
                    ? AppColor.textPrimaryPurple
                    : AppColor.textSecondary,
              ),
              SizedBox(height: 6),
              Text(
                'My',
                style: currentIndex == 1
                    ? AppTextStyles.navigationbarOn
                    : AppTextStyles.navigationbarOff,
              ),
            ],
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/icons/feedIcon.svg',
                color: currentIndex == 2
                    ? AppColor.textPrimaryPurple
                    : AppColor.textSecondary,
              ),
              SizedBox(height: 6),
              Text(
                'Feed',
                style: currentIndex == 2
                    ? AppTextStyles.navigationbarOn
                    : AppTextStyles.navigationbarOff,
              ),
            ],
          ),
          label: '',
        ),
      ],
    );
  }
}
