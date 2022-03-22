import 'package:flutter/material.dart';

class LoadingProvider extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }
}
