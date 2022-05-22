import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:toeic_learning_app/config/app_url_config.dart';
import 'package:toeic_learning_app/models/score_model.dart';

class ScoreRepository {
  Future<ScoreModel> addNewScore(scoreRecord, userId, examId, part) async {
    final Map<String, dynamic> scoreData = {
      'scoreRecord': scoreRecord,
      'userId': userId,
      'examId': examId,
      'part': part,
    };
    Response response = await post(
      Uri.parse(AppUrl.addNewScore),
      body: json.encode(scoreData),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final responseBody = await json.decode(response.body)['score'];
      return ScoreModel.fromJson(responseBody);
    } else {
      throw Exception('Failed to add new score record ');
    }
  }

  Future<List<ScoreModel>> getScorelist(examId, part) async {
    Response response = await get(
      Uri.parse(AppUrl.getScoreByExamIdAndPart + "/$examId"),
      headers: {'Content-Type': 'application/json', 'part': part.toString()},
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['scores'];
      return jsonResponse.map((score) => ScoreModel.fromJson(score)).toList();
    } else {
      throw Exception('Failed to load score from the Internet');
    }
  }
}
