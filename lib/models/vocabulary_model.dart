class Vocabulary {
  String? id;
  String? name;
  String? definition;
  String? imageUrl;
  String? phonetic;
  String? partOfSpeech;
  String? meaning;
  Examples? examples;
  String? audioUrl;
  int? lessonId;

  Vocabulary({
    this.id,
    this.name,
    this.definition,
    this.imageUrl,
    this.phonetic,
    this.partOfSpeech,
    this.meaning,
    this.examples,
    this.audioUrl,
    this.lessonId,
  });

  Vocabulary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    definition = json['definition'];
    imageUrl = json['imageUrl'];
    phonetic = json['phonetic'];
    partOfSpeech = json['partOfSpeech'];
    meaning = json['meaning'];
    examples =
        json['examples'] != null ? Examples.fromJson(json['examples']) : null;
    audioUrl = json['audioUrl'];
    lessonId = json['lessonId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['definition'] = definition;
    data['imageUrl'] = imageUrl;
    data['phonetic'] = phonetic;
    data['partOfSpeech'] = partOfSpeech;
    data['meaning'] = meaning;
    if (examples != null) {
      data['examples'] = examples!.toJson();
    }
    data['audioUrl'] = audioUrl;
    data['lessonId'] = lessonId;
    return data;
  }
}

class Examples {
  String? example;
  String? meaning;

  Examples({this.example, this.meaning});

  Examples.fromJson(Map<String, dynamic> json) {
    example = json['example'];
    meaning = json['meaning'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['example'] = example;
    data['meaning'] = meaning;
    return data;
  }
}
