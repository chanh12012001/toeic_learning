import 'dart:convert';
import 'package:http/http.dart';
import 'package:toeic_learning_app/models/terms_of_use_model.dart';
import '../config/app_url_config.dart';

class TermsOfUseRepository {
  Future<TermsOfUse> getTermsOfUse() async {
    Response response = await get(
      Uri.parse(AppUrl.getTermsOfUse),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body)['termsOfUse'];
      return TermsOfUse.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load from the Internet');
    }
  }

  Future<Map<String, dynamic>> updateTermsOfUse(id, content) async {
    Map<String, dynamic> result;
    final Map<String, dynamic> data = {
      'content': content,
    };
    Response response = await put(
      Uri.parse(AppUrl.updateTermsOfUse + id),
      body: json.encode(data),
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
