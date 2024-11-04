// pages/detail_page.dart
import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/api_service.dart';

class DetailPage extends StatefulWidget {
  final int postId;
  DetailPage({required this.postId});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final ApiService apiService = ApiService();
  late Future<Post> post;

  @override
  void initState() {
    super.initState();
    post = apiService.fetchPost(widget.postId);
  }

  void _updatePost(Post post) async {
    final updatedPost = Post(id: post.id, title: post.title + ' (Updated)', body: post.body + ' (Updated)');
    try {
      final result = await apiService.updatePost(updatedPost);
      setState(() {
        this.post = Future.value(result);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Post updated!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update post: $e')),
      );
    }
  }

  void _deletePost(int id) async {
    try {
      await apiService.deletePost(id);
      Navigator.pop(context); // Kembali ke halaman sebelumnya
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Post deleted!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete post: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail')),
      body: FutureBuilder<Post>(
        future: post,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Post not found'));
          } else {
            final post = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.title, style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 10),
                  Text(post.body),
                  Spacer(),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () => _updatePost(post),
                        child: Text('Update'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () => _deletePost(post.id),
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
