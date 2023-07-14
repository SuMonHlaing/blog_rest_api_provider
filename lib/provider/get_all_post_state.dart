import 'package:blog_rest_api_provider/data/model/get_all_post_response.dart';

abstract class GetAllPostState {}

class GetAllPostLoading extends GetAllPostState {}

class GetAllPostSuccess extends GetAllPostState {
  final List<GetAllPostResponse> getAllPostList;

  GetAllPostSuccess(this.getAllPostList);
}

class GetAllPostFail extends GetAllPostState {
  final String errorMessage;

  GetAllPostFail(this.errorMessage);
}
