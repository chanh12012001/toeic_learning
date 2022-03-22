import 'dart:async';
import 'package:flutter/material.dart';

import '../repositories/lecture_type_repository.dart';

class LectureTypeProvider with ChangeNotifier {
  LectureRepository lectureRepository = LectureRepository();

  Future<String> getIdLectureTypeByName(name) async {
    String id = await lectureRepository.getIdLectureTypeByName(name);
    notifyListeners();
    return id;
  }
}
