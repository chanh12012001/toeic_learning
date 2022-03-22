class Topic {
  String? id;
  String? name;
  String? lectureTypeId;
  String? image;
  String? cloudinaryId;

  Topic({
    this.id,
    this.name,
    this.lectureTypeId,
    this.image,
    this.cloudinaryId,
  });

  factory Topic.fromJson(Map<String, dynamic> responseData) {
    return Topic(
        id: responseData['_id'],
        name: responseData['name'],
        lectureTypeId: responseData['lectureTypeId'],
        image: responseData['image'],
        cloudinaryId: responseData['cloudinaryId']);
  }
}
