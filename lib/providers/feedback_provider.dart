import 'dart:async';
import 'package:flutter/material.dart';
import 'package:toeic_learning_app/models/feedback_model.dart';
import 'package:toeic_learning_app/repositories/feedback_repository.dart';

class FeedbackProvider with ChangeNotifier {
  FeedbackRepository feedbackRepository = FeedbackRepository();

  static List<FeedbackModel> feedbacks = [];

  Future<FeedbackModel> createNewFeedback(content, userId) async {
    FeedbackModel feedback =
        await feedbackRepository.createNewFeedback(content, userId);
    feedbacks.add(feedback);
    notifyListeners();
    return feedback;
  }

  // get all blogs
  Future<List<FeedbackModel>> getFeedbacksList() async {
    feedbacks = await feedbackRepository.getAllFeedbacks();
    return feedbacks;
  }

  Future<Map<String, dynamic>> deleteFeedback(FeedbackModel feedback) async {
    Map<String, dynamic> result;
    result = await feedbackRepository.deleteFeedback(feedback);
    feedbacks.remove(feedback);
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> updateStateFeedback(id) async {
    Map<String, dynamic> result;
    result = await feedbackRepository.updateStateFeedback(id);
    notifyListeners();
    return result;
  }
}
