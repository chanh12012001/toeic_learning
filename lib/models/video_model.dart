class Video {
  String? id;
  String? title;
  int? time;
  String? thumbnail;
  String? videoUrl;
  String? topicId;

  Video({
    this.id,
    this.title,
    this.time,
    this.thumbnail,
    this.videoUrl,
    this.topicId,
  });

  factory Video.fromJson(Map<String, dynamic> responseData) {
    return Video(
      id: responseData['id'],
      title: responseData['title'],
      time: responseData['time'],
      thumbnail: responseData['thumbnail'],
      videoUrl: responseData['videoUrl'],
      topicId: responseData['topicId'],
    );
  }
}
