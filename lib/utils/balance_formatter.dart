import 'package:intl/intl.dart';

class BalanceFormatter {
  /// Format balance based on token decimal
  /// decimal = 0: Integer format (1,000,000)
  /// decimal != 0: Up to 6 decimal places (1,000,000.111111)
  static String format(String balance, String symbol, [int? decimal]) {
    try {
      final numValue = double.tryParse(balance);
      if (numValue == null) return '0';

      // If decimal is 0, format as integer with thousand separators
      if (decimal == 0) {
        final formatter = NumberFormat('#,##0', 'en_US');
        return formatter.format(numValue.round());
      }

      // For decimal != 0, format with up to 6 decimal places
      final formatter = NumberFormat('#,##0.######', 'en_US');
      return formatter.format(numValue);
    } catch (e) {
      return balance;
    }
  }

  /// Legacy format method for backward compatibility
  /// VNDC: Integer format (1,000,200)
  /// Others: 3 decimal places (1,000.210)
  static String formatLegacy(String balance, String symbol) {
    try {
      final numValue = double.tryParse(balance);
      if (numValue == null) return '0';

      // VNDC - Integer format with thousand separators
      if (symbol.toUpperCase() == 'VNDC') {
        final formatter = NumberFormat('#,##0', 'en_US');
        return formatter.format(numValue.round());
      }

      // Other currencies - 3 decimal places with thousand separators
      final formatter = NumberFormat('#,##0.000', 'en_US');
      return formatter.format(numValue);
    } catch (e) {
      return balance;
    }
  }

  /// Format masked balance (hide actual value)
  static String formatMasked(String symbol) {
    // VNDC: Show more asterisks for integer
    if (symbol.toUpperCase() == 'VNDC') {
      return '********';
    }
    // Others: Show asterisks with decimal point
    return '*******';
  }
}
