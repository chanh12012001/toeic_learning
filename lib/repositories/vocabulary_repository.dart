import 'dart:convert';
import 'package:http/http.dart';
import 'package:toeic_learning_app/models/vocabulary_model.dart';
import '../config/app_url_config.dart';

class VocabularyRepository {
  Future<List<Vocabulary>> getVocabularyList(String id) async {
    Response response = await get(
      Uri.parse(AppUrl.getAllVocabularies + id),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['vocabularies'];
      return jsonResponse.map((word) => Vocabulary.fromJson(word)).toList();
    } else {
      throw Exception('Failed to load vocabulary from the Internet');
    }
  }
}
