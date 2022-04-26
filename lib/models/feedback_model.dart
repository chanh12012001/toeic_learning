class FeedbackModel {
  String? createAt;
  String? content;
  bool? state;
  String? userId;
  String? id;

  FeedbackModel(
      {this.createAt, this.content, this.state, this.userId, this.id});

  FeedbackModel.fromJson(Map<String, dynamic> json) {
    createAt = json['createAt'];
    content = json['content'];
    state = json['state'];
    userId = json['userId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['createAt'] = createAt;
    data['content'] = content;
    data['state'] = state;
    data['userId'] = userId;
    data['id'] = id;
    return data;
  }
}
