class QA {
  String? keyword;
  String? question;
  String? answer;
  String? id;

  QA({this.keyword,this.question,this.answer , this.id});

  QA.fromJson(Map<String, dynamic> json) {
    keyword = json['keyword'] ?? '';
    question = json['question']?? '';
    answer = json['answer']?? '';
    id = json['id'];
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['keyword'] = keyword;
    data['question'] = question;
    data['answer'] = answer;
    data['id'] = id;
    return data;
  }
}
