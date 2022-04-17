import 'dart:async';
import 'package:flutter/material.dart';
import 'package:toeic_learning_app/models/exam_model.dart';
import 'package:toeic_learning_app/repositories/exam_repository.dart';

class ExamProvider with ChangeNotifier {
  static List<Exam> exams = [];
  ExamRepository examRepository = ExamRepository();

  // get all topics
  Future<List<Exam>> getExamsList() async {
    exams = await examRepository.getExamslist();
    return exams;
  }

  Future<Map<String, dynamic>> deleteExam(Exam exam) async {
    Map<String, dynamic> result;
    result = await examRepository.deleteExam(exam);
    exams.remove(exam);
    notifyListeners();
    return result;
  }
}
