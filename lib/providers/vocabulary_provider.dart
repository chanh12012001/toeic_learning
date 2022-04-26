import 'package:flutter/material.dart';
import 'package:toeic_learning_app/models/vocabulary_model.dart';
import 'package:toeic_learning_app/repositories/vocabulary_repository.dart';

class VocabularyProvider extends ChangeNotifier {
  final VocabularyRepository _vocabularyRepository = VocabularyRepository();
  static List<Vocabulary> vocabularies = [];

  // get all lessons
  Future<List<Vocabulary>> getVocabularyList(String id) async {
    vocabularies = await _vocabularyRepository.getVocabularyList(id);
    return vocabularies;
  }
}
