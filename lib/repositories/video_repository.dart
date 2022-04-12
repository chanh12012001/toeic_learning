import 'dart:convert';
import 'package:http/http.dart';
import 'package:toeic_learning_app/models/video_model.dart';
import '../config/app_url_config.dart';

class VideoRepository {
  Future<List<Video>> getVideosList(topicId) async {
    Response response = await get(
      Uri.parse(AppUrl.getAllVideos),
      headers: {
        'Content-Type': 'application/json',
        'topicid': topicId,
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['videos'];
      return jsonResponse.map((video) => Video.fromJson(video)).toList();
    } else {
      throw Exception('Failed to load video from the Internet');
    }
  }

  Future<Video> createNewVideo(Video video) async {
    final Map<String, dynamic> videoData = {
      'title': video.title,
      'videoUrl': video.videoUrl,
      'topicId': video.topicId,
    };

    Response response = await post(
      Uri.parse(AppUrl.createNewVideo),
      body: json.encode(videoData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseBody = await json.decode(response.body)['video'];
      return Video.fromJson(responseBody);
    } else {
      throw Exception('Failed to add album');
    }
  }

  Future<Map<String, dynamic>> deleteVideo(Video video) async {
    Map<String, dynamic> result;

    Response response = await delete(
      Uri.parse(AppUrl.deleteVideo + video.id!),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      result = {
        'status': true,
        'message': json.decode(response.body)['message'],
      };
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['message'],
      };
    }

    return result;
  }

  Future<Map<String, dynamic>> updateVideo(Map<String, dynamic> params) async {
    Map<String, dynamic> result;
    final Map<String, dynamic> albumData = {
      'title': params['title'],
      'videoUrl': params['videoUrl']
    };
    Response response = await put(
      Uri.parse(AppUrl.updateVideo + params['id']),
      body: json.encode(albumData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      result = {
        'status': true,
        'message': json.decode(response.body)['message'],
      };
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['message'],
      };
    }

    return result;
  }
}
