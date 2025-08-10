import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isang/core/constants/text_styles.dart';
import 'package:isang/presentation/common/custom_app_bar.dart';
import '../../../core/constants/app_color.dart';
import '../viewmodel/feed_viewmodel.dart';
import '../widget/feed_item.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _showSearchBar = false; // 검색바 표시 상태 추가

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final feedViewModel = ref.watch(feedViewModelProvider);
    
    return Scaffold(
      appBar: FeedAppBar(
        title: '피드',
        firstIcon: 'search',
        secondIcon: 'bell',
        onFirstIconTap: () {
          setState(() {
            _showSearchBar = !_showSearchBar;
          });
        },
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppColor.backgroundGradient),
        child: Column(
          children: [
            if (_showSearchBar)
              _buildSearchBar(feedViewModel),
            
            // 피드 리스트
            Expanded(
              child: _buildFeedList(feedViewModel),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(FeedViewModel viewModel) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: AppColor.textSub,
            size: 20,
          ),
          SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: viewModel.updateSearchQuery,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                hintText: viewModel.searchQuery.isEmpty ? '검색' : '',
                hintStyle: AppTextStyles.body2.copyWith(
                  color: AppColor.textSub,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
              style: AppTextStyles.body2,
            ),
          ),
          if (viewModel.searchQuery.isNotEmpty)
            GestureDetector(
              onTap: () {
                _searchController.clear();
                viewModel.updateSearchQuery('');
              },
              child: Icon(
                Icons.clear,
                color: AppColor.textSub,
                size: 20,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFeedList(FeedViewModel viewModel) {
    final filteredItems = viewModel.filteredFeedItems;
    
    if (viewModel.isLoading) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColor.primary),
        ),
      );
    }

    if (filteredItems.isEmpty && viewModel.searchQuery.isNotEmpty) {
      return _buildEmptySearchResult();
    }

    if (filteredItems.isEmpty) {
      return _buildEmptyFeed();
    }

    return RefreshIndicator(
      onRefresh: viewModel.refreshFeed,
      color: AppColor.primary,
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 16),
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          final feedItem = filteredItems[index];
          return FeedItemWidget(
            feedItem: feedItem,
            onLike: () => viewModel.toggleLike(feedItem.id),
            onComment: () => viewModel.addComment(feedItem.id),
            onShare: () => _showShareDialog(feedItem.userName),
          );
        },
      ),
    );
  }

  Widget _buildEmptySearchResult() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: AppColor.textTertiary,
          ),
          SizedBox(height: 16),
          Text(
            '검색 결과가 없습니다',
            style: AppTextStyles.body1.copyWith(
              color: AppColor.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '다른 키워드로 검색해보세요',
            style: AppTextStyles.body2.copyWith(
              color: AppColor.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyFeed() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.feed_outlined,
            size: 64,
            color: AppColor.textTertiary,
          ),
          SizedBox(height: 16),
          Text(
            '아직 피드가 없습니다',
            style: AppTextStyles.body1.copyWith(
              color: AppColor.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '첫 번째 도전을 시작해보세요!',
            style: AppTextStyles.body2.copyWith(
              color: AppColor.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  void _showShareDialog(String userName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('공유하기'),
        content: Text('${userName}님의 피드를 공유하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('피드가 공유되었습니다!')),
              );
            },
            child: Text('공유'),
          ),
        ],
      ),
    );
  }
}