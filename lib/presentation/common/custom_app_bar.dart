import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:isang/core/constants/app_color.dart';
import 'package:isang/core/constants/text_styles.dart';

// my페이지 앱바
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Color backgroundColor;
  final String icon;

  const MyAppBar({
    super.key,
    required this.title,
    required this.icon,
    this.actions,
    this.backgroundColor = Colors.white,
  });

  @override
  Size get preferredSize => const Size.fromHeight(83);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.centerLeft,
        color: AppColor.background,
        height: 83,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppTextStyles.appBarTitle),
            GestureDetector(
              onTap: () => print('설정'),
              child: SvgPicture.asset(
                'assets/icons/$icon.svg',
                height: 40,
                width: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//home페이지 앱바
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subTitle;
  final List<Widget>? actions;
  final Color backgroundColor;
  final String icon;

  const HomeAppBar({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    this.actions,
    this.backgroundColor = Colors.white,
  });

  @override
  Size get preferredSize => const Size.fromHeight(83);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.centerLeft,
        color: AppColor.background,
        height: 83,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.appBarTitle),
                Text(subTitle, style: AppTextStyles.appBarSubTitle),
              ],
            ),
            GestureDetector(
              onTap: () => print('휴지통'),
              child: SvgPicture.asset(
                'assets/icons/$icon.svg',
                height: 40,
                width: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//feed페이지 앱바
class FeedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Color backgroundColor;
  final String firstIcon;
  final String secondIcon;

  const FeedAppBar({
    super.key,
    required this.title,
    this.actions,
    this.backgroundColor = Colors.white,
    required this.firstIcon,
    required this.secondIcon,
  });

  @override
  Size get preferredSize => const Size.fromHeight(83);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.centerLeft,
        color: AppColor.background,
        height: 83,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppTextStyles.appBarTitle),
            Row(
              children: [
                GestureDetector(
                  onTap: () => print('검색'),
                  child: SvgPicture.asset(
                    'assets/icons/$firstIcon.svg',
                    height: 40,
                    width: 40,
                  ),
                ),
                SizedBox(width: 12),
                GestureDetector(
                  onTap: () => print('종'),
                  child: SvgPicture.asset(
                    'assets/icons/$secondIcon.svg',
                    height: 40,
                    width: 40,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
