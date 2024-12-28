import 'package:flutter/material.dart';
import '../helpers/api_helper.dart';
import '../models/post.dart';
import '../widgets/app_drawer.dart';

class AddPostScreen extends StatefulWidget {
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _body = '';

  void _addPost() async {
    if (_formKey.currentState!.validate()) {
      final newPost = Post(userId: 1, title: _title, body: _body);
      try {
        await ApiHelper.create('posts', newPost.toJson(), Post.fromJson);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Post ajouté !')));
        Navigator.pop(context); // Retour à l'écran précédent après ajout
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Erreur lors de l\'ajout')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un Post'),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Titre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un titre';
                  }
                  return null;
                },
                onChanged: (value) => _title = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une description';
                  }
                  return null;
                },
                onChanged: (value) => _body = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addPost,
                child: Text('Ajouter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
