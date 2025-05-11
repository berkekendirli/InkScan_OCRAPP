import 'package:flutter/material.dart';
import 'package:inkscan_ocr_app/theme/colors.dart';
import 'package:inkscan_ocr_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class Saved extends StatelessWidget {
  const Saved({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor:
          themeProvider.isDarkTheme
              ? AppColors.darkBackground
              : AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [Text('Saved Scans Page')]),
      ),
    );
  }
}
