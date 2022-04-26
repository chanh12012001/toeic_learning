class TermsOfUse {
  String? content;
  String? id;

  TermsOfUse({this.content, this.id});

  TermsOfUse.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['content'] = content;
    data['id'] = id;
    return data;
  }
}
