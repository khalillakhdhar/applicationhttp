class Todo {
  final int userId;
  final int? id;
  final String title;
  final bool completed;

  Todo({
    required this.userId,
    this.id,
    required this.title,
    this.completed = false,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'title': title,
        'completed': completed,
      };

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        completed: json['completed'],
      );
}
