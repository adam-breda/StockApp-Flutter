class Post {
  final int id_post;
  final int id_user;
  final String title;
  final String content;

  Post({
    required this.id_post,
    required this.id_user,
    required this.title,
    required this.content,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id_post: json['id_post'],
      id_user: json['id_user'],
      title: json['title'],
      content: json['content'],
    );
  }
}
