import 'package:flutter/material.dart';

class SavedTextsProvider extends ChangeNotifier {
  final List<String> _savedTexts = [];

  List<String> get savedTexts => _savedTexts;

  void addText(String text) {
    _savedTexts.insert(0, text);
    notifyListeners();
  }

  void removeText(int index) {
    _savedTexts.removeAt(index);
    notifyListeners();
  }

  void editText(int index, String newText) {
    _savedTexts[index] = newText;
    notifyListeners();
  }
}
