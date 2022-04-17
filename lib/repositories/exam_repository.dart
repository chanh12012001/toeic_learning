import 'dart:convert';
import 'package:http/http.dart';
import 'package:toeic_learning_app/models/exam_model.dart';
import '../config/app_url_config.dart';

class ExamRepository {
  Future<List<Exam>> getExamslist() async {
    Response response = await get(
      Uri.parse(AppUrl.getAllExams),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['exams'];
      return jsonResponse.map((exam) => Exam.fromJson(exam)).toList();
    } else {
      throw Exception('Failed to load exams from the Internet');
    }
  }

  Future<Map<String, dynamic>> deleteExam(Exam exam) async {
    Map<String, dynamic> result;

    Response response = await delete(
      Uri.parse(AppUrl.deleteExam + exam.id!),
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
