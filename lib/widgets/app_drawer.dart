import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu de Navigation',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Liste des Posts'),
            onTap: () {
              Navigator.pushNamed(context, '/listPosts');
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Ajouter un Post'),
            onTap: () {
              Navigator.pushNamed(context, '/addPost');
            },
          ),
          ListTile(
            leading: Icon(Icons.list_alt),
            title: Text('Liste des Todos'),
            onTap: () {
              Navigator.pushNamed(context, '/listTodos');
            },
          ),
          ListTile(
            leading: Icon(Icons.add_task),
            title: Text('Ajouter un Todo'),
            onTap: () {
              Navigator.pushNamed(context, '/addTodo');
            },
          ),
        ],
      ),
    );
  }
}
