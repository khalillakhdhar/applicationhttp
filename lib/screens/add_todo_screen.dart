// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../helpers/api_helper.dart';
import '../models/todo.dart';
import '../widgets/app_drawer.dart';

class AddTodoScreen extends StatefulWidget {
  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';

  void _addTodo() async {
    if (_formKey.currentState!.validate()) {
      final newTodo = Todo(userId: 1, title: _title);
      try {
        await ApiHelper.create('todos', newTodo.toJson(), Todo.fromJson);
        ScaffoldMessenger.of(context)
            // ignore: prefer_const_constructors
            .showSnackBar(SnackBar(content: Text('Todo ajouté !')));
        Navigator.pop(context); // Retour à l'écran précédent après ajout
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Erreur lors de l\'ajout')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un Todo'),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Titre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un titre';
                  }
                  return null;
                },
                onChanged: (value) => _title = value,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addTodo,
                child: const Text('Ajouter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
