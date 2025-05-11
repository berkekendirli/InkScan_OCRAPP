import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inkscan_ocr_app/l10n/app_localizations.dart';
import 'package:inkscan_ocr_app/theme/colors.dart';
import 'package:inkscan_ocr_app/providers/language_provider.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class Settings extends StatefulWidget {
  final void Function(Locale) onLanguageChange;
  const Settings({super.key, required this.onLanguageChange});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LocaleProvider>(context);

    return Scaffold(
      backgroundColor:
          themeProvider.isDarkTheme
              ? AppColors.darkBackground
              : AppColors.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CountryFlag.fromCountryCode(
                            languageProvider.locale.languageCode == 'en'
                                ? 'us'
                                : 'tr',
                            shape: const Circle(),
                            height: 36,
                            width: 36,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            languageProvider.locale.languageCode == 'en'
                                ? 'Language'
                                : 'Dil',
                            style: GoogleFonts.roboto(
                              color:
                                  themeProvider.isDarkTheme
                                      ? AppColors.darkTextPrimary
                                      : AppColors.textPrimary,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color:
                            themeProvider.isDarkTheme
                                ? AppColors.darkTextPrimary
                                : AppColors.textPrimary,
                        size: 18,
                      ),
                      DropdownButton<Locale>(
                        isDense: true,
                        value: languageProvider.locale,
                        underline: const SizedBox(),
                        items: [
                          DropdownMenuItem(
                            value: const Locale('en'),
                            child: Text(
                              'English',
                              style: GoogleFonts.roboto(
                                color:
                                    themeProvider.isDarkTheme
                                        ? AppColors.darkTextPrimary
                                        : AppColors.textPrimary,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: const Locale('tr'),
                            child: Text(
                              'Türkçe',
                              style: GoogleFonts.roboto(
                                color:
                                    themeProvider.isDarkTheme
                                        ? AppColors.darkTextPrimary
                                        : AppColors.textPrimary,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                        onChanged: (Locale? newLocale) {
                          if (newLocale != null) {
                            languageProvider.setLocale(newLocale);
                            widget.onLanguageChange(newLocale);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Divider(
                  color:
                      themeProvider.isDarkTheme
                          ? AppColors.darkActiveTab
                          : AppColors.activeTab,
                  thickness: 1,
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CountryFlag.fromCountryCode(
                            languageProvider.scanningLanguage == 'eng'
                                ? 'us'
                                : 'tr',
                            shape: const Circle(),
                            height: 36,
                            width: 36,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            languageProvider.locale.languageCode == 'en'
                                ? 'Scanning Language'
                                : 'Tarama Dili',
                            style: GoogleFonts.roboto(
                              color:
                                  themeProvider.isDarkTheme
                                      ? AppColors.darkTextPrimary
                                      : AppColors.textPrimary,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color:
                            themeProvider.isDarkTheme
                                ? AppColors.darkTextPrimary
                                : AppColors.textPrimary,
                        size: 18,
                      ),
                      DropdownButton<String>(
                        isDense: true,
                        value:
                            languageProvider
                                .scanningLanguage, // OCR için seçili dil
                        underline: const SizedBox(),
                        items: [
                          DropdownMenuItem(
                            value: 'eng',
                            child: Text(
                              'English',
                              style: GoogleFonts.roboto(
                                color:
                                    themeProvider.isDarkTheme
                                        ? AppColors.darkTextPrimary
                                        : AppColors.textPrimary,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'tur',
                            child: Text(
                              'Türkçe',
                              style: GoogleFonts.roboto(
                                color:
                                    themeProvider.isDarkTheme
                                        ? AppColors.darkTextPrimary
                                        : AppColors.textPrimary,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                        onChanged: (String? newLanguage) {
                          if (newLanguage != null) {
                            languageProvider.setScanningLanguage(newLanguage);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Divider(
                  color:
                      themeProvider.isDarkTheme
                          ? AppColors.darkActiveTab
                          : AppColors.activeTab,
                  thickness: 1,
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            themeProvider.isDarkTheme
                                ? Icons.dark_mode_outlined
                                : Icons.light_mode_outlined,
                            color:
                                themeProvider.isDarkTheme
                                    ? AppColors.darkIconPrimary
                                    : AppColors.iconPrimary,
                            size: 36,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            themeProvider.isDarkTheme
                                ? (AppLocalizations.of(
                                  context,
                                )!.switch_theme_light)
                                : (AppLocalizations.of(
                                  context,
                                )!.switch_theme_dark),
                            style: GoogleFonts.roboto(
                              color:
                                  themeProvider.isDarkTheme
                                      ? AppColors.darkTextPrimary
                                      : AppColors.textPrimary,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color:
                            themeProvider.isDarkTheme
                                ? AppColors.darkTextPrimary
                                : AppColors.textPrimary,
                        size: 18,
                      ),
                      Switch(
                        activeColor:
                            themeProvider.isDarkTheme
                                ? AppColors.darkInActiveTab
                                : AppColors.inActiveTab,
                        inactiveTrackColor:
                            themeProvider.isDarkTheme
                                ? AppColors.darkAccent
                                : AppColors.accent,

                        value: themeProvider.isDarkTheme,
                        onChanged: (value) {
                          themeProvider.toggleTheme();
                        },
                      ),
                    ],
                  ),
                ),
                Divider(
                  color:
                      themeProvider.isDarkTheme
                          ? AppColors.darkActiveTab
                          : AppColors.activeTab,
                  thickness: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
