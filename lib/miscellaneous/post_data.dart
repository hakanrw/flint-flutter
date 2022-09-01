class PostData {
    PostData({ 
    required this.id, 
    required this.author, 
    required this.content, 
    required this.username, 
    required this.date, 
    required this.avatarUrl,
    required this.commentCount,
             });

  final String id;
  final String author;
  final String username;
  final String content;
  final String date;
  final String? avatarUrl;
  final int commentCount;

  factory PostData.fromJson(dynamic json) {
    return PostData (
      id: json['id'] as String, 
      author: json['author'] as String,
      content: json['content'] as String,
      username: json['username'] as String,
      date: json['created_at'] as String,
      avatarUrl: json['avatar_url'] as String?,
      commentCount: json['comment_count'] as int,
      );
  }
}
