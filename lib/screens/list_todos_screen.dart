import 'package:flutter/material.dart';
import '../helpers/api_helper.dart';
import '../models/todo.dart';
import '../widgets/app_drawer.dart';

class ListTodosScreen extends StatefulWidget {
  @override
  _ListTodosScreenState createState() => _ListTodosScreenState();
}

class _ListTodosScreenState extends State<ListTodosScreen> {
  late Future<List<Todo>> todos;

  @override
  void initState() {
    super.initState();
    todos = ApiHelper.fetchList('todos', Todo.fromJson);
  }

  void _deleteTodo(int todoId) async {
    try {
      await ApiHelper.delete('todos', todoId);
      setState(() {
        todos = ApiHelper.fetchList('todos', Todo.fromJson);
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Todo supprimé !')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la suppression')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Todos'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder<List<Todo>>(
        future: todos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucun todo disponible'));
          }

          final todoList = snapshot.data!;
          return ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (context, index) {
              final todo = todoList[index];
              return ListTile(
                title: Text(todo.title),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteTodo(todo.id!),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
