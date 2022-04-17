class Exam {
  int? exam;
  String? id;

  Exam({this.exam, this.id});

  Exam.fromJson(Map<String, dynamic> json) {
    exam = json['exam'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['exam'] = exam;
    data['id'] = id;
    return data;
  }
}
