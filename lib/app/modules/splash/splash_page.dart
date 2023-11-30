import 'package:deeplink_live/app/modules/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';

class SplashPage extends StatefulWidget {
  final SplashController controller;
  const SplashPage({super.key, required this.controller});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _initialUriIsHandled = false;
  String initialUri = '';
  @override
  void initState() {
    super.initState();

    _handleInitialUri().then((value) {
      widget.controller.getPosts().then((posts) {
        Navigator.maybeOf(context)?.pushReplacementNamed('/posts', arguments: {'posts': posts, 'initialUri': initialUri});
      });
    });
  }

  Future<void> _handleInitialUri() async {
    // In this example app this is an almost useless guard, but it is here to
    // show we are not going to call getInitialUri multiple times, even if this
    // was a weidget that will be disposed of (ex. a navigation route change).
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      try {
        final uri = await getInitialUri();
        if (uri == null) {
          print('no initial uri');
        } else {
          print('got initial uri: $uri');
          initialUri = uri.toString();
        }
      } on PlatformException {
        // Platform messages may fail but we ignore the exception
        print('falied to get initial uri');
      } on FormatException catch (err) {
        if (!mounted) return;
        print('malformed initial uri');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
