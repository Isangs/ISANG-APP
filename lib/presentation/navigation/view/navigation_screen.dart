import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../feed/view/feed_screen.dart';
import '../../home/view/home_screen.dart';
import '../../my/view/my_screen.dart';
import '../viewmodal/navigation_viewmodel.dart';
import '../widget/bottom_nav_bar.dart';

class NavigationScreen extends ConsumerStatefulWidget {
  const NavigationScreen({super.key});

  @override
  ConsumerState<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends ConsumerState<NavigationScreen> {
  late PageController _pageController;

  static final List<Widget> _screens = [
    HomeScreen(),
    MyScreen(),
    FeedScreen(),
  ];

  @override
  void initState() {
    super.initState();
    final currentIndex = ref.read(navigationViewModelProvider);
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final index = ref.watch(navigationViewModelProvider);

    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (pageIndex) {
            ref.read(navigationViewModelProvider.notifier).changeTab(pageIndex);
          },
          children: _screens,
        ),
        bottomNavigationBar: BottomNavBar(
          currentIndex: index,
          onTap: (pageIndex) {
            _pageController.animateToPage(
              pageIndex,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
      ),
    );
  }
}
