import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inkscan_ocr_app/theme/colors.dart';
import 'package:inkscan_ocr_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class ImageButton extends StatelessWidget {
  final Widget targetPage;
  final IconData icon;
  final VoidCallback? onTap;
  final String text;
  const ImageButton({
    this.onTap,
    required this.icon,
    required this.text,
    required this.targetPage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return InkWell(
      onTap:
          onTap ??
          () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => targetPage),
            );
          },
      child: Ink(
        height: 100,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color:
                themeProvider.isDarkTheme
                    ? AppColors.darkButtonText
                    : AppColors.buttonText,
          ),
          color:
              themeProvider.isDarkTheme
                  ? AppColors.darkButtonBackground
                  : AppColors.buttonBackground,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color:
                  themeProvider.isDarkTheme
                      ? AppColors.darkIconPrimary
                      : AppColors.iconPrimary,
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: GoogleFonts.roboto(
                color:
                    themeProvider.isDarkTheme
                        ? AppColors.darkButtonText
                        : AppColors.buttonText,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
