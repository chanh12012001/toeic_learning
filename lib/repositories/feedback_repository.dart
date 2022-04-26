import 'dart:convert';
import 'package:http/http.dart';
import '../config/app_url_config.dart';
import '../models/feedback_model.dart';

class FeedbackRepository {
  Future<FeedbackModel> createNewFeedback(content, userId) async {
    final Map<String, dynamic> feedbackData = {
      'content': content,
      'userId': userId,
    };

    Response response = await post(
      Uri.parse(AppUrl.createNewFeedback),
      body: json.encode(feedbackData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseBody = await json.decode(response.body)['feedback'];
      return FeedbackModel.fromJson(responseBody);
    } else {
      throw Exception('Failed to add feedback');
    }
  }

  Future<List<FeedbackModel>> getAllFeedbacks() async {
    Response response = await get(
      Uri.parse(AppUrl.getAllFeedbacks),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['feedbacks'];
      return jsonResponse
          .map((feedback) => FeedbackModel.fromJson(feedback))
          .toList();
    } else {
      throw Exception('Failed to load from the Internet');
    }
  }

  Future<Map<String, dynamic>> deleteFeedback(FeedbackModel feedback) async {
    Map<String, dynamic> result;

    Response response = await delete(
      Uri.parse(AppUrl.deleteFeedback + feedback.id!),
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

  Future<Map<String, dynamic>> updateStateFeedback(
      FeedbackModel feedback) async {
    Map<String, dynamic> result;
    Response response = await put(
      Uri.parse(AppUrl.updateFeedback + feedback.id!),
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
