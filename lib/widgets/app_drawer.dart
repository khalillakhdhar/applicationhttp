import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu de Navigation',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Liste des Posts'),
            onTap: () {
              Navigator.pushNamed(context, '/listPosts');
            },
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Ajouter un Post'),
            onTap: () {
              Navigator.pushNamed(context, '/addPost');
            },
          ),
          ListTile(
            leading: const Icon(Icons.list_alt),
            title: const Text('Liste des Todos'),
            onTap: () {
              Navigator.pushNamed(context, '/listTodos');
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_task),
            title: const Text('Ajouter un Todo'),
            onTap: () {
              Navigator.pushNamed(context, '/addTodo');
            },
          ),
        ],
      ),
    );
  }
}
