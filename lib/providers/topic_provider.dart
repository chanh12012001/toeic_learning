import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

import '../models/topic.dart';
import '../repositories/topic_repository.dart';

class TopicProvider with ChangeNotifier {
  File? image;
  String pickerError = '';
  static List<Topic> topics = [];
  TopicRepository topicRepository = TopicRepository();

  List<Topic> get getTopics {
    return topics;
  }

  Future<Topic> createNewTopic(name, lecId, file) async {
    Topic topic = await topicRepository.createNewTopic(name, lecId, file);
    topics.add(topic);
    notifyListeners();
    return topic;
  }

  // get all topics
  Future<List<Topic>> getTopicsList(lectureTypeId) async {
    topics = await topicRepository.getTopicsList(lectureTypeId);
    notifyListeners();
    return topics;
  }

  Future<Map<String, dynamic>> deleteTopic(Topic topic) async {
    Map<String, dynamic> result;
    result = await topicRepository.deleteTopic(topic);
    topics.remove(topic);
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> updateTopic(id, name, File? file) async {
    Map<String, dynamic> result;
    result = await topicRepository.updateTopic(id, name, file);
    notifyListeners();
    return result;
  }

  Future<File> convertUrlImageToFile(String imageUrl) async {
    File file = await topicRepository.urlToFile(imageUrl);
    notifyListeners();
    return file;
  }
}
