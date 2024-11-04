// pages/home_page.dart
import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/api_service.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService apiService = ApiService();

  void _createNewPost() async {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();

    final result = await showDialog<Post>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create New Post'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: bodyController,
                decoration: InputDecoration(labelText: 'Body'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Create'),
              onPressed: () async {
                final newPost = Post(
                  id: 0,
                  title: titleController.text,
                  body: bodyController.text,
                );
                try {
                  final createdPost = await apiService.createPost(newPost);
                  Navigator.of(context).pop(createdPost);
                } catch (e) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to create post: $e')),
                  );
                }
              },
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Post created with ID: ${result.id}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewPost,
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<Post>>(
        future: apiService.fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No posts available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final post = snapshot.data![index];
                return ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(postId: post.id),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
