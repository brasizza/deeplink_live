import 'package:deeplink_live/app/modules/posts/posts_page.dart';
import 'package:deeplink_live/app/modules/splash/splash_route.dart';
import 'package:flutter/material.dart';

sealed class Routes {
  static Map<String, WidgetBuilder> get route => {
        '/': (context) => SplashRoute(),
        '/posts': (context) => PostsPage(),
      };
}
