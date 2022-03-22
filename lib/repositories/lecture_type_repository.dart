import 'dart:convert';

import 'package:http/http.dart';

import '../config/app_url_config.dart';

class LectureRepository {
  Future<String> getIdLectureTypeByName(name) async {
    Response response = await get(
      Uri.parse(AppUrl.getIdLectureTypeByName),
      headers: {
        'Content-Type': 'application/json',
        'name': name,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['id'];
    } else {
      throw Exception('Failed to load task from the Internet');
    }
  }
}
