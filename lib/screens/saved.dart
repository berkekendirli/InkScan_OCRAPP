import 'package:flutter/material.dart';
import 'package:inkscan_ocr_app/l10n/app_localizations.dart';
import 'package:inkscan_ocr_app/providers/saved_texts_provider.dart';
import 'package:inkscan_ocr_app/screens/saved_detail.dart';
import 'package:inkscan_ocr_app/theme/colors.dart';
import 'package:inkscan_ocr_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class Saved extends StatelessWidget {
  const Saved({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final savedTexts = Provider.of<SavedTextsProvider>(context).savedTexts;

    return Scaffold(
      backgroundColor:
          themeProvider.isDarkTheme
              ? AppColors.darkBackground
              : AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            savedTexts.isEmpty
                ? Center(child: Text(AppLocalizations.of(context)!.emptyScan))
                : ListView.builder(
                  itemCount: savedTexts.length,
                  itemBuilder: (context, index) {
                    final text = savedTexts[index];
                    final lines = text.split('\n');
                    String preview = lines.take(2).join('\n');
                    if (lines.length > 2) preview += '\n...';
                    return Card(
                      child: ListTile(
                        title: Text(preview),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => SavedDetailScreen(
                                    text: text,
                                    index: index,
                                  ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
