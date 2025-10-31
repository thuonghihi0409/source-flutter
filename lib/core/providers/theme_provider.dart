import 'package:flutter/material.dart';

import '../services/theme_service.dart';

class ThemeProvider extends ChangeNotifier {
  final ThemeService _themeService = ThemeService();

  AppThemeColor get currentTheme => _themeService.currentTheme;
  Color get primaryColor => _themeService.primaryColor;
  Color get primaryLightColor => _themeService.primaryLightColor;
  Color get primaryDarkColor => _themeService.primaryDarkColor;
  String get themeName => _themeService.themeName;
  List<AppThemeColor> get availableThemes => _themeService.availableThemes;
  LinearGradient get primaryGradient => _themeService.primaryGradient;
  Color get shadowColor => _themeService.shadowColor;

  // Khởi tạo theme
  Future<void> initializeTheme() async {
    await _themeService.initializeTheme();
    _themeService.addListener(_onThemeChanged);
  }

  // Thay đổi theme
  Future<void> setTheme(AppThemeColor theme) async {
    await _themeService.setTheme(theme);
  }

  // Lắng nghe thay đổi theme
  void _onThemeChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    _themeService.removeListener(_onThemeChanged);
    super.dispose();
  }
}
