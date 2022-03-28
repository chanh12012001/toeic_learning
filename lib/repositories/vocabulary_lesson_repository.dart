import 'dart:convert';
import 'package:http/http.dart';
import '../config/app_url_config.dart';
import '../models/vocabulary_lesson_model.dart';

class VocabularyLessonRepository {
  Future<List<VocabularyLesson>> getLessonsList() async {
    Response response = await get(
      Uri.parse(AppUrl.getAllLessons),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['lessons'];
      return jsonResponse
          .map((lesson) => VocabularyLesson.fromJson(lesson))
          .toList();
    } else {
      throw Exception('Failed to load lesson from the Internet');
    }
  }
}
