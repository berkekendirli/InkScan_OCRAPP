import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inkscan_ocr_app/theme/colors.dart';
import 'package:inkscan_ocr_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class FunctionButtons extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final String text;
  const FunctionButtons({
    this.onTap,
    required this.icon,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  themeProvider.isDarkTheme
                      ? AppColors.darkTextPrimary
                      : AppColors.textPrimary,
            ),
            color:
                themeProvider.isDarkTheme
                    ? AppColors.darkButtonBackground
                    : AppColors.buttonBackground,
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color:
                      themeProvider.isDarkTheme
                          ? AppColors.darkButtonText
                          : AppColors.buttonText,
                ),
                const SizedBox(width: 8),
                Text(
                  text,
                  style: GoogleFonts.roboto(
                    color:
                        themeProvider.isDarkTheme
                            ? AppColors.darkButtonText
                            : AppColors.buttonText,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
