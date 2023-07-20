import 'package:blog_rest_api_provider/data/model/update_response.dart';

abstract class UpdatePostState {}

class UpdateForm extends UpdatePostState{}
class UpdatePostLoading extends UpdatePostState {}

class UpdatePostSuccess extends UpdatePostState {
  final UpdateResponse updateResponse;
  UpdatePostSuccess(this.updateResponse);
}

class UpdatePostFail extends UpdatePostState {
  final String errorMessage;

  UpdatePostFail(this.errorMessage);
}
