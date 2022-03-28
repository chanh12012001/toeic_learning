import 'package:flutter/material.dart';
import 'package:toeic_learning_app/models/video_model.dart';
import 'package:toeic_learning_app/repositories/video_repository.dart';

class VideoProvider extends ChangeNotifier {
  final VideoRepository _videoRepository = VideoRepository();
  static List<Video> videos = [];

  // get all lessons
  Future<List<Video>> getVideosList(topicId) async {
    videos = await _videoRepository.getVideosList(topicId);
    notifyListeners();
    return videos;
  }

  Future<Video> createNewVideo(Video video) async {
    Video newVideo = await _videoRepository.createNewVideo(video);
    videos.add(newVideo);
    notifyListeners();
    return newVideo;
  }

  Future<Map<String, dynamic>> deleteVideo(Video video) async {
    Map<String, dynamic> result;
    result = await _videoRepository.deleteVideo(video);
    videos.remove(video);
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> updateVideo(Map<String, dynamic> params) async {
    Map<String, dynamic> result;
    result = await _videoRepository.updateVideo(params);
    notifyListeners();
    return result;
  }
}
