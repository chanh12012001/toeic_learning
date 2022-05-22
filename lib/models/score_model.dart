class ScoreModel {
  int? scoreRecord;
  String? userId;
  int? part;
  int? examId;
  String? id;


  ScoreModel({this.scoreRecord, this.userId,this.examId,this.part, this.id});

  ScoreModel.fromJson(Map<String, dynamic> json) {
    scoreRecord = json['scoreRecord'];
    userId = json['userId'];
    examId = json['examId'];
    part = json['part'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['scoreRecord'] = scoreRecord;
    data['userId'] = userId;
    data['examId'] = examId;
    data['part'] = part;
    data['id'] = id;
    return data;
  }
}
