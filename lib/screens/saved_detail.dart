import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inkscan_ocr_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../providers/saved_texts_provider.dart';

class SavedDetailScreen extends StatefulWidget {
  final String text;
  final int index;
  const SavedDetailScreen({super.key, required this.text, required this.index});

  @override
  State<SavedDetailScreen> createState() => _SavedDetailScreenState();
}

class _SavedDetailScreenState extends State<SavedDetailScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (AppLocalizations.of(context)!.saved),
          style: GoogleFonts.pattaya(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => Share.share(_controller.text),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Provider.of<SavedTextsProvider>(
                context,
                listen: false,
              ).removeText(widget.index);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _controller,
          maxLines: null,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          onChanged: (val) {
            Provider.of<SavedTextsProvider>(
              context,
              listen: false,
            ).editText(widget.index, val);
          },
        ),
      ),
    );
  }
}
