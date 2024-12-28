class Post {
  final int userId;
  final int? id;
  final String title;
  final String body;

  Post(
      {required this.userId, this.id, required this.title, required this.body});

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'title': title,
        'body': body,
      };

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        body: json['body'],
      );
}
