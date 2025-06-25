import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String _langCode = 'en';

  String get langCode => _langCode;

  void changeLang(String code) {
    _langCode = code;
    notifyListeners();
  }
}