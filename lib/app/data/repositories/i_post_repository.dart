import 'package:deeplink_live/app/data/models/post_model.dart';
import 'package:dio/dio.dart';

import './post_repository.dart';

class IPostRepository implements PostRepository {
  final Dio _rest;

  IPostRepository({required Dio rest}) : _rest = rest;
  @override
  Future<List<PostModel>?> getPosts() async {
    final response = await _rest.get('posts/?_embed');

    if (response.statusCode == 200) {
      return (response.data as List).map((post) => PostModel.fromMap(post)).toList();
    }
    return null;
  }
}
