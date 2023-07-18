import 'package:blog_rest_api_provider/data/model/blog_upload_response.dart';

abstract class UplaoadUIState {}
class UploadForm extends UplaoadUIState{
  
}

class UploadUILoading extends UplaoadUIState {
  final double progress;
  UploadUILoading(this.progress);
}

class UploadUISuccess extends UplaoadUIState {
  final BlogUploadResponse blogUploadResponse;

  UploadUISuccess(this.blogUploadResponse);
}

class UploadUIFail extends UplaoadUIState {
  final String errorMessage;

  UploadUIFail(this.errorMessage);
}
