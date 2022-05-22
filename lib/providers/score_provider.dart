import 'package:flutter/material.dart';
import 'package:toeic_learning_app/models/score_model.dart';
import 'package:toeic_learning_app/repositories/score_repository.dart';

class ScoreProvider with ChangeNotifier {
  ScoreRepository scoreRepository = ScoreRepository();

  static List<ScoreModel> scores = [];
  static List<ScoreModel> scoresList = [];

  Future<ScoreModel> addNewScore(scoreRecord, userId,examId,part) async {
    ScoreModel newScore = await scoreRepository.addNewScore(scoreRecord, userId,examId,part);
    scores.add(newScore);
    notifyListeners();
    return newScore;
  }
  Future<List<ScoreModel>> getScoreList(examId,part) async {
    scoresList = await scoreRepository.getScorelist(examId,part);
    return scoresList;
  }
}
