class FeedItem {
  final String id;
  final String userName;
  final String userProfileImage;
  final String timeAgo;
  final String challengeTag;
  final String content;
  final String? imageUrl;
  final int likeCount;
  final int commentCount;
  final bool isLiked;

  FeedItem({
    required this.id,
    required this.userName,
    required this.userProfileImage,
    required this.timeAgo,
    required this.challengeTag,
    required this.content,
    this.imageUrl,
    required this.likeCount,
    required this.commentCount,
    this.isLiked = false,
  });

  FeedItem copyWith({
    String? id,
    String? userName,
    String? userProfileImage,
    String? timeAgo,
    String? challengeTag,
    String? content,
    String? imageUrl,
    int? likeCount,
    int? commentCount,
    bool? isLiked,
  }) {
    return FeedItem(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      userProfileImage: userProfileImage ?? this.userProfileImage,
      timeAgo: timeAgo ?? this.timeAgo,
      challengeTag: challengeTag ?? this.challengeTag,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
