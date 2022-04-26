import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class StateNotificationPreferences {
  Future<bool> saveStateNotification(bool state) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isStateNotification", state);
    return true;
  }

  Future<bool> saveNotificationTime(String time) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('notificationTime', time);
    return true;
  }

  void removeStateNotification() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("isStateNotification");
    prefs.remove("notificationTime");
  }

  Future<bool> getStateNotification() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isStateNotification = prefs.getBool("isStateNotification");
    return isStateNotification!;
  }

  Future<String> getNotificationTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? isStateNotification = prefs.getString("notificationTime");
    return isStateNotification!;
  }
}
