import 'package:deeplink_live/app/data/models/post_model.dart';
import 'package:deeplink_live/app/data/repositories/post_repository.dart';

class SplashController {
  final PostRepository _repository;

  SplashController({required PostRepository repository}) : _repository = repository;

  Future<List<PostModel>?> getPosts() async {
    final posts = await _repository.getPosts();

    return posts;
  }
}
