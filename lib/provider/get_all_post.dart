import 'package:blog_rest_api_provider/data/model/get_all_post_response.dart';
import 'package:blog_rest_api_provider/provider/get_all_post_state.dart';
import 'package:blog_rest_api_provider/service/blog_api_service.dart';
import 'package:flutter/material.dart';

class GetAllPost extends ChangeNotifier {
  GetAllPostState getAllPostState = GetAllPostLoading();
  final BlogApiService _apiService = BlogApiService();
  Future<void> getAllPost() async {
    getAllPostState = GetAllPostLoading();
    try {
      List<GetAllPostResponse> getAllPostList = await _apiService.getAllPost();
      getAllPostState = GetAllPostSuccess(getAllPostList);
      notifyListeners();
    } catch (e) {
      getAllPostState = GetAllPostFail(e.toString());
    }
  }
}
