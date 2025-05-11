import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:inkscan_ocr_app/l10n/app_localizations.dart';
import 'package:inkscan_ocr_app/theme/colors.dart';
import 'package:inkscan_ocr_app/widgets/image_button.dart';
import 'package:inkscan_ocr_app/providers/theme_provider.dart';
import 'package:inkscan_ocr_app/screens/result.dart';
import 'package:inkscan_ocr_app/screens/saved.dart';
import 'package:inkscan_ocr_app/screens/settings.dart';
import 'package:provider/provider.dart';
import 'package:inkscan_ocr_app/methods/image_picker_methods.dart';

class Home extends StatefulWidget {
  final void Function(Locale) onLanguageChange;
  const Home({super.key, required this.onLanguageChange});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  late List<Widget> _pages; // Aktif sekmeyi takip etmek için

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomeContent(), // Ana ekran içeriği
      const Saved(), // Saved ekranı
      Settings(onLanguageChange: widget.onLanguageChange), // Settings ekranı
    ];
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor:
          themeProvider.isDarkTheme
              ? AppColors.darkBackground
              : AppColors.background,
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color:
                themeProvider.isDarkTheme
                    ? AppColors.darkActiveTab
                    : AppColors.activeTab,
            height: 1,
          ),
        ),
        backgroundColor:
            themeProvider.isDarkTheme
                ? AppColors.darkPrimary
                : AppColors.primary,
        title: Text(
          (AppLocalizations.of(context)!.appTitle),
          style: GoogleFonts.pattaya(
            color:
                themeProvider.isDarkTheme
                    ? AppColors.darkTextPrimary
                    : AppColors.textPrimary,
          ),
        ),
      ),
      body: _pages[_selectedIndex], // Aktif sayfayı göster
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 1,
            color:
                themeProvider.isDarkTheme
                    ? AppColors.darkActiveTab
                    : AppColors.activeTab,
          ),
          GNav(
            gap: 8,
            activeColor:
                themeProvider.isDarkTheme
                    ? AppColors.darkActiveTab
                    : AppColors.activeTab,
            color:
                themeProvider.isDarkTheme
                    ? AppColors.darkInActiveTab
                    : AppColors.inActiveTab,
            backgroundColor:
                themeProvider.isDarkTheme
                    ? AppColors.darkPrimary
                    : AppColors.primary,
            padding: const EdgeInsets.all(16),
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index; // Aktif sekmeyi değiştir
              });
            },
            tabs: [
              GButton(
                icon: Icons.home,
                text: (AppLocalizations.of(context)!.home),
              ),
              GButton(
                icon: Icons.save,
                text: (AppLocalizations.of(context)!.saved),
              ),
              GButton(
                icon: Icons.settings,
                text: (AppLocalizations.of(context)!.settings),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ImageButton(
            onTap: () => pickImageFromCamera(context),
            icon: Icons.camera_alt,
            text: (AppLocalizations.of(context)!.scanFromCamera),
            targetPage: Result(),
          ),
          const SizedBox(height: 10),
          ImageButton(
            onTap: () => pickImageFromGallery(context),
            icon: Icons.photo,
            text: (AppLocalizations.of(context)!.scanFromGallery),
            targetPage: Result(),
          ),
        ],
      ),
    );
  }
}
