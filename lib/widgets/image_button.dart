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
      customBorder: const CircleBorder(),
      onTap:
          onTap ??
          () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => targetPage),
            );
          },
      child: Ink(
        width: 175,
        height: 175,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              themeProvider.isDarkTheme
                  ? AppColors.darkButtonBackground
                  : AppColors.buttonBackground,
          border: Border.all(
            color:
                themeProvider.isDarkTheme
                    ? AppColors.darkButtonText
                    : AppColors.buttonText,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color:
                  themeProvider.isDarkTheme
                      ? AppColors.darkIconPrimary
                      : AppColors.iconPrimary,
              size: 40,
            ),
            const SizedBox(height: 10),
            Text(
              text,
              style: GoogleFonts.roboto(
                fontSize: 16,
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
