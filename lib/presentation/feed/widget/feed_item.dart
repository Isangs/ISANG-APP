import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/text_styles.dart';
import '../../../data/models/feed_item.dart';

class FeedItemWidget extends StatelessWidget {
  final FeedItem feedItem;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onShare;

  const FeedItemWidget({
    super.key,
    required this.feedItem,
    this.onLike,
    this.onComment,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 사용자 정보 헤더
          _buildUserHeader(),
          SizedBox(height: 12),
          
          // 챌린지 태그
          _buildChallengeTag(),
          SizedBox(height: 8),
          
          // 피드 내용
          _buildContent(),
          
          // 이미지 (있는 경우)
          if (feedItem.imageUrl != null) ...[
            SizedBox(height: 12),
            _buildImage(),
          ],
          
          SizedBox(height: 12),
          
          // 좋아요, 댓글, 공유 버튼
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildUserHeader() {
    return Row(
      children: [
        // 프로필 이미지
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColor.primaryGradient,
          ),
          child: Center(
            child: Text(
              feedItem.userName.isNotEmpty ? feedItem.userName[0] : 'U',
              style: AppTextStyles.body2.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        
        // 사용자명과 시간
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                feedItem.userName,
                style: TextStyle(
                  fontWeight: FontWeight.w600
                )
              ),
              Text(
                feedItem.timeAgo,
                style: AppTextStyles.caption.copyWith(
                  color: AppColor.gray400,
                ),
              ),
            ],
          ),
        ),
        
        // 더보기 버튼
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.more_horiz,
            color: AppColor.gray400,
          ),
        ),
      ],
    );
  }

  Widget _buildChallengeTag() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: AppColor.primaryGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        feedItem.challengeTag,
        style: AppTextStyles.caption.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Text(
      feedItem.content,
      style: AppTextStyles.body2,
      maxLines: null,
    );
  }

  Widget _buildImage() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColor.gray100,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          feedItem.imageUrl!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppColor.gray100,
              child: Center(
                child: Icon(
                  Icons.image,
                  color: AppColor.gray400,
                  size: 40,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        // 좋아요 버튼
        _buildActionButton(
          icon: feedItem.isLiked ? Icons.favorite : Icons.favorite_border,
          count: feedItem.likeCount,
          color: feedItem.isLiked ? Colors.red : AppColor.gray400,
          onTap: onLike,
        ),
        SizedBox(width: 16),
        
        // 댓글 버튼
        _buildActionButton(
          icon: Icons.chat_bubble_outline,
          count: feedItem.commentCount,
          color: AppColor.gray400,
          onTap: onComment,
        ),
        
        Spacer(),
        
        // 공유 버튼
        IconButton(
          onPressed: onShare,
          icon: Icon(
            Icons.share,
            color: AppColor.gray400,
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required int count,
    required Color color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          SizedBox(width: 4),
          Text(
            count.toString(),
            style: AppTextStyles.caption.copyWith(
              color: AppColor.gray600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}