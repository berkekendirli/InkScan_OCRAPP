import 'package:flutter/material.dart';
import 'package:inkscan_ocr_app/inkscan.dart';
import 'package:inkscan_ocr_app/providers/language_provider.dart';
import 'package:inkscan_ocr_app/providers/saved_texts_provider.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => LocaleProvider()),
        ChangeNotifierProvider(create: (context) => SavedTextsProvider()),
      ],
      child: Inkscan(),
    ),
  );
}
