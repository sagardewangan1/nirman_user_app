import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/constant/appLanguages.dart';

class LanguageController extends ChangeNotifier {
  late final SharedPreferences? sharedPreferences;
  LanguageController({required this.sharedPreferences}) {
    _loadCurrentTheme();
  }
  Locale? _appLocale;
  Locale? get appLocale => _appLocale;

  String _languageTitle = "English";
  String get languageTitle => _languageTitle;

  Future<void> changeLanguage(Locale type) async {
    _appLocale = type;
    print("📢 Selected Locale: $_appLocale");

    String languageCode = type.languageCode;

    // ✅ Find the matching language from `AppLanguages.languages`
    final selectedLang = AppLanguages.languages.firstWhere(
      (lang) => lang.languageCode == languageCode,
      orElse: () => AppLanguages.languages.first,
    );

    // ✅ Update `_languageTitle` based on selected language
    _languageTitle = selectedLang.languageName ?? '';
    print("🌍 Updated Language Title: $_languageTitle");

    bool isValidLanguage =
        AppLanguages.languages.any((lang) => lang.languageCode == languageCode);
    if (isValidLanguage) {
      sharedPreferences?.setString("nirmanLang", languageCode);
      sharedPreferences?.setString("nirmanLangTitle", _languageTitle);
    } else {
      sharedPreferences?.setString("nirmanLang", "ar");
      sharedPreferences?.setString("nirmanLangTitle", "Arabic");
    }
    notifyListeners();
  }

  void _loadCurrentTheme() async {
    _appLocale = Locale(sharedPreferences!.getString("nirmanLang") ?? 'en');
    _languageTitle =
        sharedPreferences!.getString("nirmanLangTitle") ?? 'English';
    notifyListeners();
  }

  int _langIndex = 0;
  int get langIndex => _langIndex;
  setLangIndex(int index) {
    _langIndex = index;
    notifyListeners();
  }
}
