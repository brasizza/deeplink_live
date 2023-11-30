import 'package:deeplink_live/app/data/repositories/i_post_repository.dart';
import 'package:deeplink_live/app/data/repositories/post_repository.dart';
import 'package:deeplink_live/app/modules/splash/splash_controller.dart';
import 'package:deeplink_live/app/modules/splash/splash_page.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_getit/flutter_getit.dart';

class SplashRoute extends FlutterGetItPageRoute {
  const SplashRoute({super.key});

  @override
  List<Bind> get bindings => [
        Bind.lazySingleton<PostRepository>(
          (i) => IPostRepository(
            rest: i(),
          ),
        ),
        Bind.lazySingleton((i) => SplashController(repository: i()))
      ];
  @override
  // TODO: implement page
  WidgetBuilder get page => (context) => SplashPage(controller: context.get());
}
