import 'package:flutter/material.dart';
import 'package:inkscan_ocr_app/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:inkscan_ocr_app/providers/language_provider.dart';
import 'package:inkscan_ocr_app/providers/theme_provider.dart';
import 'package:inkscan_ocr_app/screens/home.dart';
import 'package:provider/provider.dart';

class Inkscan extends StatefulWidget {
  const Inkscan({super.key});

  @override
  State<Inkscan> createState() => _InkscanState();
}

class _InkscanState extends State<Inkscan> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LocaleProvider>(context);

    return SafeArea(
      child: MaterialApp(
        theme: ThemeData(
          brightness:
              themeProvider.isDarkTheme ? Brightness.dark : Brightness.light,
        ),
        debugShowCheckedModeBanner: false,
        locale: languageProvider.locale,
        supportedLocales: const [Locale('en'), Locale('tr')],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: Home(
          onLanguageChange: (locale) {
            languageProvider.setLocale(locale);
          },
        ),
      ),
    );
  }
}
