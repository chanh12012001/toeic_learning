import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

import '../models/terms_of_use_model.dart';
import '../repositories/terms_of_use_repository.dart';

class TermsOfUseProvider with ChangeNotifier {
  TermsOfUseRepository termsOfUseRepository = TermsOfUseRepository();

  // get
  Future<TermsOfUse> getTermsOfUse() async {
    TermsOfUse termsOfUse = await termsOfUseRepository.getTermsOfUse();
    notifyListeners();
    return termsOfUse;
  }

  Future<Map<String, dynamic>> updateTermsOfUse(id, content) async {
    Map<String, dynamic> result;
    result = await termsOfUseRepository.updateTermsOfUse(id, content);
    notifyListeners();
    return result;
  }
}
