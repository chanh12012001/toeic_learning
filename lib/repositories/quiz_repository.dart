import 'dart:convert';
import 'package:http/http.dart';
import 'package:toeic_learning_app/models/quiz_model.dart';
import '../config/app_url_config.dart';

class QuizRepository {
  Future<List<Question>> getQuizlist(examId, part) async {
    Response response = await get(
      Uri.parse(AppUrl.getAllQuizs + "/$examId"),
      headers: {'Content-Type': 'application/json', 'part': part.toString()},
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['questions'];
      return jsonResponse.map((quiz) => Question.fromJson(quiz)).toList();
    } else {
      throw Exception('Failed to load quiz from the Internet');
    }
  }

  Future<List<Question>> getQuizlistByGroup(examId, groupquestion) async {
    Response response = await get(
      Uri.parse(AppUrl.getAllQuizsGroup + "/$examId"),
      headers: {
        'Content-Type': 'application/json',
        'groupquestion': groupquestion.toString()
      },
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['questions'];
      return jsonResponse.map((quiz) => Question.fromJson(quiz)).toList();
    } else {
      throw Exception('Failed to load quiz from the Internet');
    }
  }
}
