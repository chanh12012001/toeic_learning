import 'package:flutter/material.dart';
import 'package:toeic_learning_app/models/quiz_model.dart';
import 'package:toeic_learning_app/repositories/quiz_repository.dart';

class QuizProvider extends ChangeNotifier {
  final QuizRepository _quizRepository = QuizRepository();
  static List<Question> questions = [];
  static List<Question> questionsGroup = [];
  static List<Question> questionPart = [];

  // get all quiz
  Future<List<Question>> getQuizList(examId,part) async {
    questions = await _quizRepository.getQuizlist(examId,part);
    return questions;
  }
   Future<List<Question>> getQuizGroupList(examId,questionGroup) async {
    questionsGroup = await _quizRepository.getQuizlistByGroup(examId,questionGroup);
    return questionsGroup;
  }
  Future<List<Question>> getQuizPartList(part) async {
    questionPart = await _quizRepository.getQuizlistByPart(part);
    return questionPart;
  }
}