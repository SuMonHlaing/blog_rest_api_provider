import 'package:blog_rest_api_provider/provider/delete_post/delete_post_state.dart';
import 'package:blog_rest_api_provider/service/blog_api_service.dart';
import 'package:flutter/material.dart';

class DeletePostNotifier extends ChangeNotifier {
  DeletePostState deletePostState = DeletePostLoading();
  final BlogApiService _blogApiService = BlogApiService();
  void deletePost({required int id}) async {
    deletePostState = DeletePostLoading();
    notifyListeners();
    try {
      final deletePostResponse = await _blogApiService.deletePost(id: id);
      deletePostState = DeletePostSuccess(deletePostResponse);
      notifyListeners();
    } catch (e) {
      deletePostState = DeletePostFail('Something wrong');
      notifyListeners();
    }
  }
}
