import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inkscan_ocr_app/l10n/app_localizations.dart';
import 'package:inkscan_ocr_app/methods/api_methods.dart';
import 'package:inkscan_ocr_app/providers/language_provider.dart';
import 'package:inkscan_ocr_app/providers/saved_texts_provider.dart';
import 'package:inkscan_ocr_app/theme/colors.dart';
import 'package:inkscan_ocr_app/widgets/text_functionality_button.dart';
import 'package:inkscan_ocr_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class Result extends StatefulWidget {
  final Uint8List? imageBytes;
  const Result({super.key, this.imageBytes});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  late TextEditingController _textController;
  late FlutterTts _flutterTts;

  @override
  void initState() {
    super.initState();
    _flutterTts = FlutterTts();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _textController = TextEditingController(
      text: (AppLocalizations.of(context)!.processing),
    );
    _processImage();
  }

  Future<void> _processImage() async {
    if (widget.imageBytes == null) return;

    final selectedLanguage =
        Provider.of<LocaleProvider>(context, listen: false).scanningLanguage;

    final resultText = await sendImageToBackend(
      widget.imageBytes!,
      selectedLanguage,
    );
    setState(() {
      _textController.text = resultText;
    });
  }

  Future<void> _speakText() async {
    final text = _textController.text;
    if (text.isNotEmpty) {
      final lowerCaseText = text.toLowerCase();
      final selectedLanguage =
          Provider.of<LocaleProvider>(context, listen: false).scanningLanguage;
      final ttsLanguage = selectedLanguage == 'tur' ? 'tr-TR' : 'en-US';

      await _flutterTts.setLanguage(ttsLanguage);
      await _flutterTts.setSpeechRate(0.5); // Konuşma hızı
      await _flutterTts.speak(lowerCaseText); // Metni sese dönüştür
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _flutterTts.stop();
    super.dispose();
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
          (AppLocalizations.of(context)!.result),
          style: GoogleFonts.pattaya(
            color:
                themeProvider.isDarkTheme
                    ? AppColors.darkTextPrimary
                    : AppColors.textPrimary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            themeProvider.isDarkTheme
                                ? AppColors.darkTextPrimary
                                : AppColors.textPrimary,
                      ),
                    ),
                    child:
                        widget.imageBytes != null
                            ? Image.memory(
                              widget.imageBytes!,
                            ) // Seçilen görüntüyü göster
                            : const Text('No image selected.'),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    style: GoogleFonts.roboto(
                      color:
                          themeProvider.isDarkTheme
                              ? AppColors.darkTextPrimary
                              : AppColors.textPrimary,
                    ),
                    controller: _textController,
                    maxLines: null, // Çok satırlı metin için
                    decoration: InputDecoration(
                      focusColor:
                          themeProvider.isDarkTheme
                              ? AppColors.darkTextPrimary
                              : AppColors.textPrimary,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color:
                              themeProvider.isDarkTheme
                                  ? AppColors.darkTextPrimary
                                  : AppColors.textPrimary,
                          width: 2.0,
                        ),
                      ),

                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      labelText:
                          (AppLocalizations.of(context)!.recognizedLabel),
                      labelStyle: GoogleFonts.roboto(
                        color:
                            themeProvider.isDarkTheme
                                ? AppColors.darkTextPrimary
                                : AppColors.textPrimary,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: FunctionButtons(
                            onTap: () {
                              final textToSave = _textController.text.trim();
                              if (textToSave.isNotEmpty) {
                                Provider.of<SavedTextsProvider>(
                                  context,
                                  listen: false,
                                ).addText(textToSave);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      AppLocalizations.of(context)!.savebutton,
                                    ),
                                  ),
                                );
                              }
                            },
                            icon: Icons.save,
                            text: (AppLocalizations.of(context)!.save),
                          ),
                        ),
                        Expanded(
                          child: FunctionButtons(
                            icon: Icons.upload,
                            text: (AppLocalizations.of(context)!.export),
                          ),
                        ),
                        Expanded(
                          child: FunctionButtons(
                            onTap: () {
                              final textToShare = _textController.text;
                              Share.share(textToShare);
                            },
                            icon: Icons.share,
                            text: (AppLocalizations.of(context)!.share),
                          ),
                        ),
                        Expanded(
                          child: FunctionButtons(
                            onTap: _speakText, // TTS işlevini çağır
                            icon: Icons.volume_up,
                            text: (AppLocalizations.of(context)!.listen),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
