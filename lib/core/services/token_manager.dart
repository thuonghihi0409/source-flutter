import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _tokenExpiryKey = 'token_expiry';

  final SharedPreferences _prefs;
  Timer? _refreshTimer;

  TokenManager({required SharedPreferences prefs}) : _prefs = prefs;

  // Save tokens
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _prefs.setString(_accessTokenKey, accessToken);
    await _prefs.setString(_refreshTokenKey, refreshToken);

    // Decode JWT to get expiry time
    final expiryTime = _getTokenExpiry(accessToken);
    if (expiryTime != null) {
      await _prefs.setString(_tokenExpiryKey, expiryTime.toIso8601String());
      _scheduleTokenRefresh(expiryTime);
    }
  }

  // Get access token
  String? getAccessToken() {
    return _prefs.getString(_accessTokenKey);
  }

  // Get refresh token
  String? getRefreshToken() {
    return _prefs.getString(_refreshTokenKey);
  }

  // Check if token is valid (not expired)
  bool isTokenValid() {
    final expiryString = _prefs.getString(_tokenExpiryKey);
    if (expiryString == null) return false;

    final expiryTime = DateTime.parse(expiryString);
    return DateTime.now().isBefore(expiryTime);
  }

  // Check if token needs refresh (will expire in next 5 minutes)
  bool shouldRefreshToken() {
    final expiryString = _prefs.getString(_tokenExpiryKey);
    if (expiryString == null) return false;

    final expiryTime = DateTime.parse(expiryString);
    final now = DateTime.now();
    final difference = expiryTime.difference(now);

    // Refresh if token will expire in next 5 minutes
    return difference.inMinutes <= 5;
  }

  // Clear tokens
  Future<void> clearTokens() async {
    await _prefs.remove(_accessTokenKey);
    await _prefs.remove(_refreshTokenKey);
    await _prefs.remove(_tokenExpiryKey);
    _refreshTimer?.cancel();
  }

  // Decode JWT to get expiry time
  DateTime? _getTokenExpiry(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;

      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));
      final Map<String, dynamic> payloadMap = json.decode(decoded);

      if (payloadMap['exp'] != null) {
        return DateTime.fromMillisecondsSinceEpoch(payloadMap['exp'] * 1000);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  // Schedule automatic token refresh
  void _scheduleTokenRefresh(DateTime expiryTime) {
    _refreshTimer?.cancel();

    final now = DateTime.now();
    final difference = expiryTime.difference(now);

    // Schedule refresh 5 minutes before expiry
    final refreshTime = difference.inMilliseconds - (5 * 60 * 1000);

    if (refreshTime > 0) {
      _refreshTimer = Timer(Duration(milliseconds: refreshTime), () {
        // Trigger refresh callback
        onTokenRefreshNeeded?.call();
      });
    }
  }

  // Callback for when token needs refresh
  Function()? onTokenRefreshNeeded;

  // Dispose timer
  void dispose() {
    _refreshTimer?.cancel();
  }
}
