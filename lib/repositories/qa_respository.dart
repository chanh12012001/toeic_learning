import 'dart:convert';

import 'package:http/http.dart';
import 'package:toeic_learning_app/config/app_url_config.dart';
import 'package:toeic_learning_app/models/qa_model.dart';
import 'package:toeic_learning_app/screens/QA_screen.dart';

class QARespository {
  Future<List<QA>> getQAList() async {
    Response response = await get(
      Uri.parse(AppUrl.getAllQuestionQA),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['qas'];
      return jsonResponse.map((question) => QA.fromJson(question)).toList();
    } else {
      throw Exception('Failed to load Q & A from the Internet');
    }
  }
  Future<List<QA>> getQAKWList(keyword) async {
    Response response = await get(
      Uri.parse(AppUrl.getAllQuestionKeyWord),
      headers: {
        'Content-Type': 'application/json',
        'keyword': keyword.toString(),
      },
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['qas'];
      return jsonResponse.map((keyword) => QA.fromJson(keyword)).toList();
    } else {
      throw Exception('Failed to load Q & A from the Internet');
    }
  }
}
