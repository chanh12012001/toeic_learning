import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class LectureTypePreferences {
  Future<bool> saveGrammarLectureId(String lecId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("grammar", lecId);
    return true;
  }

  Future<bool> saveListeningLectureId(String lecId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("listening", lecId);
    return true;
  }

  void removeLecture() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("grammar");
    prefs.remove("listening");
  }

  Future<String> getListeningLectureId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? listeningLectureId = prefs.getString("listening");
    return listeningLectureId!;
  }

  Future<String> getGrammarLectureId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? grammarLectureId = prefs.getString("grammar");
    return grammarLectureId!;
  }
}
