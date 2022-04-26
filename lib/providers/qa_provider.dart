import 'package:flutter/material.dart';
import 'package:toeic_learning_app/models/qa_model.dart';
import 'package:toeic_learning_app/repositories/qa_respository.dart';

class QAProvider extends ChangeNotifier {
  final QARespository _qaRepository = QARespository();
  static List<QA> questions = [];

  // get all questions
  Future<List<QA>> getAllQuestionList() async {
    questions = await _qaRepository.getQAList();
    return questions;
  }
  Future<List<QA>> getAllQuestionByKeyWord(question) async {
    questions = await _qaRepository.getQAKWList(question);
    return questions;
  }
}
