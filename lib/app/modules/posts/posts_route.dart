import 'package:deeplink_live/app/modules/posts/posts_page.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_getit/flutter_getit.dart';

class PostsRoute extends FlutterGetItPageRoute {
  const PostsRoute({super.key});

  @override
  List<Bind> get bindings => [];

  @override
  // TODO: implement page
  WidgetBuilder get page => (context) => const PostsPage();
}
