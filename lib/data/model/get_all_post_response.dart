class GetAllPostResponse {
  int? id;
  String? title;

  GetAllPostResponse({this.id, this.title});

  GetAllPostResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }
  @override
  String toString() {
    return 'GetAllPostResponse(id: $id,title: $title)';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}
