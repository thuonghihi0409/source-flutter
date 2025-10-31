class TimezoneUtils {
  /// Convert UTC DateTime to local timezone
  static DateTime toLocal(DateTime utcDateTime) {
    return utcDateTime.toLocal();
  }

  /// Parse UTC string and convert to local DateTime
  static DateTime parseToLocal(String utcString) {
    try {
      final utcDateTime = DateTime.parse(utcString);
      return utcDateTime.toLocal();
    } catch (e) {
      return DateTime.now();
    }
  }

  /// Get current local time
  static DateTime now() {
    return DateTime.now();
  }

  /// Format DateTime to local timezone string
  static String formatToLocalString(DateTime dateTime) {
    final localDateTime = dateTime.toLocal();
    return '${localDateTime.day.toString().padLeft(2, '0')}-${localDateTime.month.toString().padLeft(2, '0')}-${localDateTime.year} ${localDateTime.hour.toString().padLeft(2, '0')}:${localDateTime.minute.toString().padLeft(2, '0')}';
  }

  /// Calculate duration between current local time and target local time
  static Duration? calculateDurationToTarget(String targetUtcString) {
    try {
      final targetLocal = parseToLocal(targetUtcString);
      final now = DateTime.now();
      final difference = targetLocal.difference(now);
      return difference.isNegative ? null : difference;
    } catch (e) {
      return null;
    }
  }

  /// Check if current time is before target time (both in local timezone)
  static bool isBefore(String targetUtcString) {
    try {
      final targetLocal = parseToLocal(targetUtcString);
      final now = DateTime.now();
      return now.isBefore(targetLocal);
    } catch (e) {
      return false;
    }
  }

  /// Check if current time is after target time (both in local timezone)
  static bool isAfter(String targetUtcString) {
    try {
      final targetLocal = parseToLocal(targetUtcString);
      final now = DateTime.now();
      return now.isAfter(targetLocal);
    } catch (e) {
      return false;
    }
  }
}
