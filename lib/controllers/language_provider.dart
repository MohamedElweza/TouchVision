import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  bool _isArabicMode = false;

  bool get isArabicMode => _isArabicMode;

  void setLanguageMode(bool isArabic) {
    _isArabicMode = isArabic;
    notifyListeners();
  }
}
