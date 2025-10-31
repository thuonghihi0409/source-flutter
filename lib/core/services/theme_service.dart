import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeColor {
  blue, // Màu xanh mặc định (primary hiện tại)
  red, // Màu đỏ
  yellow, // Màu vàng
  pink, // Màu hồng
  purple, // Màu tím
}

class ThemeService extends ChangeNotifier {
  static const String _themeKey = 'app_theme_color';
  AppThemeColor _currentTheme = AppThemeColor.blue;

  AppThemeColor get currentTheme => _currentTheme;

  // Định nghĩa các màu sắc chính cho từng theme
  static const Map<AppThemeColor, Color> _primaryColors = {
    AppThemeColor.blue: Color(0xFF5176C0), // Xanh (màu hiện tại)
    AppThemeColor.red: Color(0xFFE53E3E), // Đỏ
    AppThemeColor.yellow: Color(0xFFD69E2E), // Vàng
    AppThemeColor.pink: Color(0xFFED64A6), // Hồng
    AppThemeColor.purple: Color(0xFF805AD5), // Tím
  };

  // Định nghĩa các màu sắc phụ cho từng theme
  static const Map<AppThemeColor, Color> _primaryLightColors = {
    AppThemeColor.blue: Color(0xFF7292CF), // Xanh nhạt
    AppThemeColor.red: Color(0xFFFC8181), // Đỏ nhạt
    AppThemeColor.yellow: Color(0xFFF6E05E), // Vàng nhạt
    AppThemeColor.pink: Color(0xFFF687B3), // Hồng nhạt
    AppThemeColor.purple: Color(0xFF9F7AEA), // Tím nhạt
  };

  static const Map<AppThemeColor, Color> _primaryDarkColors = {
    AppThemeColor.blue: Color(0xFF2855AE), // Xanh đậm
    AppThemeColor.red: Color(0xFFC53030), // Đỏ đậm
    AppThemeColor.yellow: Color(0xFFB7791F), // Vàng đậm
    AppThemeColor.pink: Color(0xFFD53F8C), // Hồng đậm
    AppThemeColor.purple: Color(0xFF553C9A), // Tím đậm
  };

  static const Map<AppThemeColor, String> _themeNames = {
    AppThemeColor.blue: 'Xanh',
    AppThemeColor.red: 'Đỏ',
    AppThemeColor.yellow: 'Vàng',
    AppThemeColor.pink: 'Hồng',
    AppThemeColor.purple: 'Tím',
  };

  Color get primaryColor => _primaryColors[_currentTheme]!;
  Color get primaryLightColor => _primaryLightColors[_currentTheme]!;
  Color get primaryDarkColor => _primaryDarkColors[_currentTheme]!;
  String get themeName => _themeNames[_currentTheme]!;

  // Lấy danh sách tất cả theme colors
  List<AppThemeColor> get availableThemes => AppThemeColor.values;

  // Khởi tạo theme từ SharedPreferences
  Future<void> initializeTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_themeKey) ?? AppThemeColor.blue.index;
    _currentTheme = AppThemeColor.values[themeIndex];
    notifyListeners();
  }

  // Thay đổi theme
  Future<void> setTheme(AppThemeColor theme) async {
    if (_currentTheme != theme) {
      _currentTheme = theme;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_themeKey, theme.index);
      notifyListeners();
    }
  }

  // Tạo gradient cho theme hiện tại
  LinearGradient get primaryGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryDarkColor, primaryLightColor],
  );

  // Tạo shadow color cho theme hiện tại
  Color get shadowColor => primaryColor.withOpacity(0.2);

  // Static method để lấy màu cho một theme cụ thể
  static Color getPrimaryColorForTheme(AppThemeColor theme) {
    return _primaryColors[theme]!;
  }
}
