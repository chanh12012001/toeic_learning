class Question {
  int? questionNumber;
  String? image;
  String? audio;
  String? paragraph;
  int? groupQuestion;
  String? question;
  String? explainQuestion;
  String? option1;
  String? explain1;
  String? option2;
  String? explain2;
  String? option3;
  String? explain3;
  String? option4;
  String? explain4;
  String? correctAnswer;
  int? part;
  int? examId;
  String? id;

  Question(
      {this.questionNumber,
      this.image,
      this.audio,
      this.paragraph,
      this.groupQuestion,
      this.question,
      this.explainQuestion,
      this.option1,
      this.explain1,
      this.option2,
      this.explain2,
      this.option3,
      this.explain3,
      this.option4,
      this.explain4,
      this.correctAnswer,
      this.part,
      this.examId,
      this.id});

  Question.fromJson(Map<String, dynamic> json) {
    questionNumber = json['questionNumber'];
    image = json['image'] ?? '';
    audio = json['audio'] ?? '';
    paragraph = json['paragraph'] ?? '';
    groupQuestion = json['groupQuestion'] ?? '';
    question = json['question']?? '';
    explainQuestion = json['explainQuestion']?? '';
    option1 = json['option1']?? '';
    explain1 = json['explain1']?? '';
    option2 = json['option2']?? '';
    explain2 = json['explain2']?? '';
    option3 = json['option3']?? '';
    explain3 = json['explain3']?? '';
    option4 = json['option4']?? '';
    explain4 = json['explain4']?? '';
    correctAnswer = json['correctAnswer'];
    part = json['part'];
    examId = json['examId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['questionNumber'] = questionNumber;
    data['image'] = image;
    data['audio'] = audio;
    data['paragraph'] = paragraph;
    data['groupQuestion'] = groupQuestion;
    data['question'] = question;
    data['explainQuestion'] = explainQuestion;
    data['option1'] = option1;
    data['explain1'] = explain1;
    data['option2'] = option2;
    data['explain2'] = explain2;
    data['option3'] = option3;
    data['explain3'] = explain3;
    data['option4'] = option4;
    data['explain4'] = explain4;
    data['correctAnswer'] = correctAnswer;
    data['part'] = part;
    data['examId'] = examId;
    data['id'] = id;
    return data;
  }
}
