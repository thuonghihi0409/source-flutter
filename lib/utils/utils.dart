import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

// Password utilities
class PasswordUtils {
  static bool isPasswordStrong(String password) {
    if (password.length < 8) return false;
    if (!password.contains(RegExp(r'[A-Z]'))) return false;
    if (!password.contains(RegExp(r'[a-z]'))) return false;
    if (!password.contains(RegExp(r'[0-9]'))) return false;
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return false;
    return true;
  }

  static String getPasswordStrengthMessage(
    String password,
    BuildContext context,
  ) {
    if (password.isEmpty) return '';
    if (password.length < 8)
      return AppLocalizations.of(context)!.passwordMinLengthMessage;
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return AppLocalizations.of(context)!.passwordUppercaseMessage;
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      return AppLocalizations.of(context)!.passwordLowercaseMessage;
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return AppLocalizations.of(context)!.passwordNumberMessage;
    }
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return AppLocalizations.of(context)!.passwordSpecialCharMessage;
    }
    return AppLocalizations.of(context)!.passwordStrongMessage;
  }
}

// Password generation utilities
class PasswordGenerator {
  static String generateStrongPassword() {
    const String lowercase = 'abcdefghijklmnopqrstuvwxyz';
    const String uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const String numbers = '0123456789';
    const String symbols = '!@#\$%^&*()_+-=[]{}|;:,.<>?';

    final random = DateTime.now().millisecondsSinceEpoch;
    int randomGenerator(int seed) => (seed * 9301 + 49297) % 233280;

    String password = '';

    // Đảm bảo có ít nhất 1 ký tự từ mỗi loại
    password += lowercase[randomGenerator(random) % lowercase.length];
    password += uppercase[randomGenerator(random + 1) % uppercase.length];
    password += numbers[randomGenerator(random + 2) % numbers.length];
    password += symbols[randomGenerator(random + 3) % symbols.length];

    // Thêm 4 ký tự ngẫu nhiên nữa để đủ 8 ký tự
    const String allChars = lowercase + uppercase + numbers + symbols;
    for (int i = 0; i < 4; i++) {
      password += allChars[randomGenerator(random + 4 + i) % allChars.length];
    }

    // Xáo trộn password
    final passwordList = password.split('');
    for (int i = passwordList.length - 1; i > 0; i--) {
      final j = randomGenerator(random + 10 + i) % (i + 1);
      final temp = passwordList[i];
      passwordList[i] = passwordList[j];
      passwordList[j] = temp;
    }

    return passwordList.join('');
  }

  static List<String> generatePasswordSuggestions({int count = 3}) {
    final List<String> suggestions = [];
    for (int i = 0; i < count; i++) {
      suggestions.add(generateStrongPassword());
    }
    return suggestions;
  }
}

// Date formatting utilities
class DateUtils {
  static String formatDateFromApi(String apiTimeString, BuildContext context) {
    try {
      final dateTime = DateTime.parse(apiTimeString);

      // Get localized day names from AppLocalizations
      final dayNames = [
        AppLocalizations.of(context)!.sunday,
        AppLocalizations.of(context)!.monday,
        AppLocalizations.of(context)!.tuesday,
        AppLocalizations.of(context)!.wednesday,
        AppLocalizations.of(context)!.thursday,
        AppLocalizations.of(context)!.friday,
        AppLocalizations.of(context)!.saturday,
      ];

      final dayIndex = dateTime.weekday == 7 ? 0 : dateTime.weekday;
      final dayName = dayNames[dayIndex];
      final day = dateTime.day.toString().padLeft(2, '0');
      final month = dateTime.month.toString().padLeft(2, '0');
      final year = dateTime.year;

      final dayLabel = AppLocalizations.of(context)!.day;

      return '$dayName $dayLabel $day/$month/$year';
    } catch (e) {
      final now = DateTime.now();
      final dayNames = [
        AppLocalizations.of(context)!.sunday,
        AppLocalizations.of(context)!.monday,
        AppLocalizations.of(context)!.tuesday,
        AppLocalizations.of(context)!.wednesday,
        AppLocalizations.of(context)!.thursday,
        AppLocalizations.of(context)!.friday,
        AppLocalizations.of(context)!.saturday,
      ];
      final dayIndex = now.weekday == 7 ? 0 : now.weekday;
      final dayName = dayNames[dayIndex];
      final day = now.day.toString().padLeft(2, '0');
      final month = now.month.toString().padLeft(2, '0');
      final year = now.year;
      final dayLabel = AppLocalizations.of(context)!.day;

      return '$dayName $dayLabel $day/$month/$year';
    }
  }
}
