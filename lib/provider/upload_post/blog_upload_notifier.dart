import 'package:blog_rest_api_provider/provider/upload_post/upload_ui_state.dart';
import 'package:blog_rest_api_provider/service/blog_api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BlogUploadNotifier extends ChangeNotifier {
  UplaoadUIState uploadUIState = UploadForm();
  final BlogApiService _blogApiService = BlogApiService();
  void upload(
      {required String title,
      required String body,
      required FormData? data}) async {
    try {
      uploadUIState = UploadUILoading(0);
      notifyListeners();
      final blogUploadResponse = await _blogApiService.uploadPost(
          title: title,
          body: body,
          data: data,
          sendProgress: (int send, int size) {
            double progress = ((send / size) * 100);
            uploadUIState = UploadUILoading(progress);
          });
      uploadUIState = UploadUISuccess(blogUploadResponse);
      notifyListeners();
    } catch (e) {
      UploadUIFail('something wrong');
      notifyListeners();
    }
  }

  void tryAgain() {
    uploadUIState = UploadForm();
    notifyListeners();
  }
}
