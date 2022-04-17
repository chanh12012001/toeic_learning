class ToeicPart {
  int? part;
  String? img;
  String? title;

  ToeicPart({this.part, this.img, this.title});

  ToeicPart.fromJson(Map<String, dynamic> json) {
    part = json['part'];
    img = json['img'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['part'] = part;
    data['img'] = img;
    data['title'] = title;
    return data;
  }
}
