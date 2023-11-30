import 'dart:async';

import 'package:deeplink_live/app/data/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  var posts = <PostModel>[];
  StreamSubscription? _sub;
  String? initialUri;
  @override
  void initState() {
    _handleIncomingLinks();
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        posts = (ModalRoute.of(context)!.settings.arguments as Map)['posts'] as List<PostModel>;
        initialUri = (ModalRoute.of(context)!.settings.arguments as Map)['initialUri'] as String?;
      });

      if (posts.isNotEmpty) {
        if (initialUri != null) {
          _checkUri(Uri.parse(initialUri!).pathSegments);
        }
      }
    });
  }

  void _handleIncomingLinks() {
    // It will handle app links while the app is already started - be it in
    // the foreground or in the background.
    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        final path = uri.pathSegments;
        _checkUri(path);
      }
    });
  }

  void _checkUri(List<String>? path) {
    if (path != null) {
      if (path.isNotEmpty) {
        String slug = path[path.length - 2];

        final indexPost = posts.indexWhere((post) => post.slug == slug);

        if (indexPost != -1) {
          _showPost(posts[indexPost]);
        }
        // PostModel post = posts.wh((post) => post.slug == slug, orElse: ()=>);
      }
    }
  }

  void _showPost(PostModel post) {
    showModalBottomSheet(context: context, builder: (context) => Text(post.description));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];

          return GestureDetector(
            onTap: () => _showPost(post),
            child: Card(
              child: Column(
                children: [
                  Text(initialUri ?? ''),
                  Expanded(
                    child: Image.network(
                      fit: BoxFit.cover,
                      post.image ?? '',
                      errorBuilder: (_, __, ___) => Container(width: 100, height: 100, color: Colors.blue),
                    ),
                  ),
                  Text(post.title, textAlign: TextAlign.center),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
