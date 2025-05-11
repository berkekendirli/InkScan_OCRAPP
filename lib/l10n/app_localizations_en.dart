// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'InkScan';

  @override
  String get home => 'Home';

  @override
  String get saved => 'Saved';

  @override
  String get result => 'Scan Result';

  @override
  String get settings => 'Settings';

  @override
  String get scanFromCamera => 'Scan from Camera';

  @override
  String get scanFromGallery => 'Scan from Gallery';

  @override
  String get share => 'Share';

  @override
  String get save => 'Save';

  @override
  String get export => 'Convert';

  @override
  String get processing => 'Processing...';

  @override
  String get recognizedLabel => 'Recognized Text';

  @override
  String get switch_theme_light => 'Switch to Light Theme';

  @override
  String get switch_theme_dark => 'Switch to Dark Theme';

  @override
  String get listen => 'Listen';
}
