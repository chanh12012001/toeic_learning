class VocabularyLesson {
  int? id;
  String? name;
  String? meaning;
  String? imageUrl;

  VocabularyLesson({this.id, this.name, this.meaning, this.imageUrl});

  factory VocabularyLesson.fromJson(Map<String, dynamic> json) {
    return VocabularyLesson(
        id: json['id'],
        name: json['name'],
        meaning: json['meaning'],
        imageUrl: json['imageUrl']);
  }
}
