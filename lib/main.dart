import 'package:flutter/material.dart';
import 'screens/list_posts_screen.dart';
import 'screens/add_post_screen.dart';
import 'screens/list_todos_screen.dart';
import 'screens/add_todo_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Application',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/listPosts',
      routes: {
        '/listPosts': (context) => ListPostsScreen(),
        '/addPost': (context) => AddPostScreen(),
        '/listTodos': (context) => ListTodosScreen(),
        '/addTodo': (context) => AddTodoScreen(),
      },
    );
  }
}
