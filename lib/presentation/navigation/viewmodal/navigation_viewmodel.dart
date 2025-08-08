import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigationViewModelProvider =
StateNotifierProvider<NavigationViewModel, int>((ref) => NavigationViewModel());

class NavigationViewModel extends StateNotifier<int> {
  NavigationViewModel() : super(0); // 0: Home 탭부터 시작

  void changeTab(int index) {
    state = index;
  }
}
