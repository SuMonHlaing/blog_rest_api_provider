import 'package:blog_rest_api_provider/data/model/delete_post_response.dart';

abstract class DeletePostState{}

class DeletePostLoading extends DeletePostState {}

class DeletePostSuccess extends DeletePostState {
  final DeletePostResponse deletePostResponse;

  DeletePostSuccess(this.deletePostResponse);
}

class DeletePostFail extends DeletePostState {
  final String errorMessage;

  DeletePostFail(this.errorMessage);
}
