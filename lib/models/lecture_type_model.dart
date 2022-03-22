class LectureType {
  String? id;
  String? name;

  LectureType({
    this.id,
    this.name,
  });

  factory LectureType.fromJson(Map<String, dynamic> responseData) {
    return LectureType(
      id: responseData['id'],
      name: responseData['name'],
    );
  }
}
