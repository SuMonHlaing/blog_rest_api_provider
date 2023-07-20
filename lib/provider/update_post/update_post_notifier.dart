import 'package:blog_rest_api_provider/provider/update_post/update_post_state.dart';
import 'package:blog_rest_api_provider/service/blog_api_service.dart';
import 'package:flutter/foundation.dart';

class UpdatePostNotifier extends ChangeNotifier {
  UpdatePostState updatePostState = UpdateForm();
  final BlogApiService _blogApiService = BlogApiService();
  void update(
      {required int id, required String title, required String body}) async {
    try {
      updatePostState = UpdatePostLoading();
      notifyListeners();
      final updatePostResponse =
          await _blogApiService.updatePost(id: id, title: title, body: body);
      updatePostState = UpdatePostSuccess(updatePostResponse);
      notifyListeners();
    } catch (e) {
      print('------------------------>${e.toString()}');
    updatePostState=  UpdatePostFail('Something Wrong');
      notifyListeners();
    }
  }
}
