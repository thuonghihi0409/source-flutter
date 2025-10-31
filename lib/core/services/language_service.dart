import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService extends ChangeNotifier {
  final SharedPreferences _prefs;
  static const String _languageKey = 'selected_language';

  Locale _currentLocale = const Locale('vi'); // Default to Vietnamese

  LanguageService({required SharedPreferences prefs}) : _prefs = prefs {
    _loadSavedLanguage();
  }

  Locale get currentLocale => _currentLocale;

  String get currentLanguageCode => _currentLocale.languageCode;

  bool get isVietnamese => _currentLocale.languageCode == 'vi';
  bool get isEnglish => _currentLocale.languageCode == 'en';

  Future<void> _loadSavedLanguage() async {
    final savedLanguage = _prefs.getString(_languageKey);
    if (savedLanguage != null) {
      _currentLocale = Locale(savedLanguage);
      notifyListeners();
    }
  }

  Future<void> saveLanguage(Locale locale) async {
    await _prefs.setString(_languageKey, locale.languageCode);
    _currentLocale = locale;
    notifyListeners();
  }

  Future<void> setVietnamese() async {
    await saveLanguage(const Locale('vi'));
  }

  Future<void> setEnglish() async {
    await saveLanguage(const Locale('en'));
  }

  Future<void> toggleLanguage() async {
    if (isVietnamese) {
      await setEnglish();
    } else {
      await setVietnamese();
    }
  }

  static List<Locale> get supportedLocales => [
    const Locale('vi'),
    const Locale('en'),
  ];
}
