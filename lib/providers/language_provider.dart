import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');
  String _scanningLanguage = 'eng';

  Locale get locale => _locale;
  String get scanningLanguage => _scanningLanguage;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  void setScanningLanguage(String language) {
    _scanningLanguage = language;
    notifyListeners();
  }
}
