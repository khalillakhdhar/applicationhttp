import 'package:flutter/material.dart';
import '../helpers/api_helper.dart';
import '../models/post.dart';
import '../widgets/app_drawer.dart';

class ListPostsScreen extends StatefulWidget {
  @override
  _ListPostsScreenState createState() => _ListPostsScreenState();
}

class _ListPostsScreenState extends State<ListPostsScreen> {
  late Future<List<Post>> posts;

  @override
  void initState() {
    super.initState();
    posts = ApiHelper.fetchList('posts', Post.fromJson);
  }

  void _deletePost(int postId) async {
    try {
      await ApiHelper.delete('posts', postId);
      setState(() {
        posts = ApiHelper.fetchList('posts', Post.fromJson);
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Post supprimé !')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la suppression')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Posts'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder<List<Post>>(
        future: posts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucun post disponible'));
          }

          final postList = snapshot.data!;
          return ListView.builder(
            itemCount: postList.length,
            itemBuilder: (context, index) {
              final post = postList[index];
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.body),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deletePost(post.id!),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
