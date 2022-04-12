import 'package:flutter/material.dart';
import 'package:toeic_learning_app/repositories/vocabulary_lesson_repository.dart';

import '../models/vocabulary_lesson_model.dart';

class VocabularyLessonProvider extends ChangeNotifier {
  final VocabularyLessonRepository _lessonRepository =
      VocabularyLessonRepository();
  static List<VocabularyLesson> lessons = [];

  // get all lessons
  Future<List<VocabularyLesson>> getLessonssList() async {
    lessons = await _lessonRepository.getLessonsList();
    notifyListeners();
    return lessons;
  }
}
