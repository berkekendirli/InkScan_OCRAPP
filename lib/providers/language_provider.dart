import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');
  String _scanningLanguage = 'eng';

  Locale get locale => _locale;
  String get scanningLanguage => _scanningLanguage;

  LocaleProvider() {
    _loadLocale();
    _loadScanningLanguage();
  }

  void setLocale(Locale locale) {
    _locale = locale;
    _saveLocale();
    notifyListeners();
  }

  void setScanningLanguage(String lang) {
    _scanningLanguage = lang;
    _saveScanningLanguage();
    notifyListeners();
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString('locale') ?? 'en';
    _locale = Locale(code);
    notifyListeners();
  }

  Future<void> _saveLocale() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('locale', _locale.languageCode);
  }

  Future<void> _loadScanningLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    _scanningLanguage = prefs.getString('scanningLanguage') ?? 'eng';
    notifyListeners();
  }

  Future<void> _saveScanningLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('scanningLanguage', _scanningLanguage);
  }
}
