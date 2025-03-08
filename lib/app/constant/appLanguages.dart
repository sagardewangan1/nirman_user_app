import 'package:qixer/model/LanguageModel.dart';

class AppLanguages {
  static List<LanguageModel> languages = [
    LanguageModel(
        languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(
        languageName: 'Arabic', countryCode: 'SA', languageCode: 'ar'),
    LanguageModel(languageName: 'हिंदी', countryCode: 'IN', languageCode: 'hi'),
    LanguageModel(
        languageName: 'Bangla', countryCode: 'BD', languageCode: 'bn'),
  ];
}
