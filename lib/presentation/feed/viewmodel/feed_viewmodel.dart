import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/feed_item.dart';

class FeedViewModel extends ChangeNotifier {
  List<FeedItem> _feedItems = [];
  bool _isLoading = false;
  String _searchQuery = '';

  List<FeedItem> get feedItems => _feedItems;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;

  List<FeedItem> get filteredFeedItems {
    if (_searchQuery.isEmpty) {
      return _feedItems;
    }
    return _feedItems.where((item) {
      return item.content.toLowerCase().contains(_searchQuery.toLowerCase()) ||
             item.userName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
             item.challengeTag.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  FeedViewModel() {
    _loadDummyData();
  }

  void _loadDummyData() {
    _feedItems = [
      FeedItem(
        id: '1',
        userName: '김민수',
        userProfileImage: '',
        timeAgo: '2시간 전',
        challengeTag: '30분 조깅 완료',
        content: '하강에서 30분 조깅 완료! 오늘도 목표 달성 💪',
        likeCount: 12,
        commentCount: 8,
        isLiked: false,
      ),
      FeedItem(
        id: '2',
        userName: '한도현',
        userProfileImage: '',
        timeAgo: '1일 전',
        challengeTag: '기타 연습 30분',
        content: '새로운 곡 연주했어요. 손가락이 아프지만 보람차네요! 🎸',
        imageUrl: 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400',
        likeCount: 19,
        commentCount: 16,
        isLiked: true,
      ),
      FeedItem(
        id: '3',
        userName: '이서준',
        userProfileImage: '',
        timeAgo: '3일 전',
        challengeTag: '독서 1시간',
        content: '오늘은 자기계발서를 읽었습니다. 새로운 인사이트를 얻었어요!',
        likeCount: 7,
        commentCount: 3,
        isLiked: false,
      ),
      FeedItem(
        id: '4',
        userName: '박지영',
        userProfileImage: '',
        timeAgo: '5일 전',
        challengeTag: '요가 45분',
        content: '아침 요가로 하루를 시작했습니다. 몸과 마음이 한결 가벼워진 느낌이에요 🧘‍♀️',
        imageUrl: 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=400',
        likeCount: 24,
        commentCount: 12,
        isLiked: false,
      ),
      FeedItem(
        id: '5',
        userName: '최현우',
        userProfileImage: '',
        timeAgo: '1주 전',
        challengeTag: '영어 공부 2시간',
        content: '토익 공부 2시간 완료! 목표 점수까지 조금씩 다가가고 있어요 📚',
        likeCount: 15,
        commentCount: 9,
        isLiked: true,
      ),
    ];
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void toggleLike(String feedId) {
    final index = _feedItems.indexWhere((item) => item.id == feedId);
    if (index != -1) {
      final item = _feedItems[index];
      _feedItems[index] = item.copyWith(
        isLiked: !item.isLiked,
        likeCount: item.isLiked ? item.likeCount - 1 : item.likeCount + 1,
      );
      notifyListeners();
    }
  }

  void addComment(String feedId) {
    final index = _feedItems.indexWhere((item) => item.id == feedId);
    if (index != -1) {
      final item = _feedItems[index];
      _feedItems[index] = item.copyWith(
        commentCount: item.commentCount + 1,
      );
      notifyListeners();
    }
  }

  Future<void> refreshFeed() async {
    _isLoading = true;
    notifyListeners();

    // 실제 API 호출 시뮬레이션
    await Future.delayed(Duration(seconds: 1));
    
    _loadDummyData();
    _isLoading = false;
    notifyListeners();
  }
}

final feedViewModelProvider = ChangeNotifierProvider<FeedViewModel>((ref) {
  return FeedViewModel();
});