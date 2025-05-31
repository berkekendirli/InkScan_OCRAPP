import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedTextsProvider extends ChangeNotifier {
  List<String> _savedTexts = [];
  List<String> get savedTexts => _savedTexts;

  SavedTextsProvider() {
    _loadSavedTexts();
  }

  void addText(String text) {
    _savedTexts.insert(0, text);
    _saveSavedTexts();
    notifyListeners();
  }

  void removeText(int index) {
    _savedTexts.removeAt(index);
    _saveSavedTexts();
    notifyListeners();
  }

  void editText(int index, String newText) {
    _savedTexts[index] = newText;
    _saveSavedTexts();
    notifyListeners();
  }

  Future<void> _loadSavedTexts() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('savedTexts') ?? [];
    _savedTexts = saved;
    notifyListeners();
  }

  Future<void> _saveSavedTexts() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('savedTexts', _savedTexts);
  }
}
