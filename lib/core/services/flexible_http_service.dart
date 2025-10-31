import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../error/exceptions.dart';
import 'token_manager.dart';

class FlexibleHttpService {
  static const String defaultBaseUrl = 'https://mvp-api-dev.depay.ai';

  final TokenManager? tokenManager;
  final Function()? onRefreshToken;
  final Function()? onUnauthorized;

  FlexibleHttpService({
    this.tokenManager,
    this.onRefreshToken,
    this.onUnauthorized,
  });

  void _printCurl(
    String method,
    Uri url,
    Map<String, String> headers,
    dynamic body,
  ) {
    final buffer = StringBuffer();
    buffer.write('curl -X $method "${url.toString()}"');
    headers.forEach((k, v) => buffer.write(' -H "$k: $v"'));
    if (body != null) {
      buffer.write(" --data '${body is String ? body : jsonEncode(body)}'");
    }
    log('=== CURL ===');
    log(buffer.toString());
    log('============');
  }

  Future<dynamic> get(
    String endpoint, {
    String? customBaseUrl, // 👈 cho phép truyền base URL khác
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    bool requiresAuth = false,
    bool isRetry = false,
  }) async {
    try {
      if (requiresAuth &&
          tokenManager != null &&
          !isRetry &&
          tokenManager!.shouldRefreshToken()) {
        await _refreshTokenIfNeeded();
      }

      final base = customBaseUrl ?? defaultBaseUrl;
      var url = Uri.parse('$base$endpoint');
      if (queryParameters != null) {
        url = url.replace(queryParameters: queryParameters);
      }

      final requestHeaders = _buildHeaders(headers, requiresAuth);
      _printCurl('GET', url, requestHeaders, null); // In curl

      final response = await http.get(url, headers: requestHeaders);

      _log('GET', url, response);

      return _handleResponse(response, requiresAuth, () async {
        if (!isRetry) {
          final refreshed = await _refreshTokenIfNeeded();
          if (refreshed) {
            return await get(
              endpoint,
              customBaseUrl: customBaseUrl,
              headers: headers,
              queryParameters: queryParameters,
              requiresAuth: requiresAuth,
              isRetry: true,
            );
          }
        }
      });
    } catch (e) {
      throw NetworkException('Network error: $e');
    }
  }

  Future<dynamic> post(
    String endpoint, {
    String? customBaseUrl,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool requiresAuth = false,
    bool isRetry = false,
  }) async {
    try {
      if (requiresAuth &&
          tokenManager != null &&
          !isRetry &&
          tokenManager!.shouldRefreshToken()) {
        await _refreshTokenIfNeeded();
      }

      final base = customBaseUrl ?? defaultBaseUrl;
      final url = Uri.parse('$base$endpoint');

      final requestHeaders = _buildHeaders(headers, requiresAuth);

      _printCurl('POST', url, requestHeaders, body); // In curl

      final response = await http.post(
        url,
        headers: requestHeaders,
        body: body != null ? jsonEncode(body) : null,
      );

      _log('POST', url, response);

      return _handleResponse(response, requiresAuth, () async {
        if (!isRetry) {
          final refreshed = await _refreshTokenIfNeeded();
          if (refreshed) {
            return await post(
              endpoint,
              customBaseUrl: customBaseUrl,
              body: body,
              headers: headers,
              requiresAuth: requiresAuth,
              isRetry: true,
            );
          }
        }
      });
    } catch (e) {
      throw NetworkException('Network error: $e');
    }
  }

  // PUT
  Future<dynamic> put(
    String endpoint, {
    String? customBaseUrl,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool requiresAuth = false,
  }) async {
    final base = customBaseUrl ?? defaultBaseUrl;
    final url = Uri.parse('$base$endpoint');
    final requestHeaders = _buildHeaders(headers, requiresAuth);
    final response = await http.put(
      url,
      headers: requestHeaders,
      body: body != null ? jsonEncode(body) : null,
    );
    _log('PUT', url, response);
    _printCurl('PUT', url, requestHeaders, body);
    return _handleResponse(response, requiresAuth);
  }

  // PATCH
  Future<dynamic> patch(
    String endpoint, {
    String? customBaseUrl,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool requiresAuth = false,
  }) async {
    final base = customBaseUrl ?? defaultBaseUrl;
    final url = Uri.parse('$base$endpoint');
    final requestHeaders = _buildHeaders(headers, requiresAuth);
    final response = await http.patch(
      url,
      headers: requestHeaders,
      body: body != null ? jsonEncode(body) : null,
    );
    _log('PATCH', url, response);
    _printCurl('PATCH', url, requestHeaders, body);
    return _handleResponse(response, requiresAuth);
  }

  // DELETE
  Future<dynamic> delete(
    String endpoint, {
    String? customBaseUrl,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    bool requiresAuth = false,
  }) async {
    final base = customBaseUrl ?? defaultBaseUrl;
    var url = Uri.parse('$base$endpoint');
    if (queryParameters != null) {
      url = url.replace(queryParameters: queryParameters);
    }

    final requestHeaders = _buildHeaders(headers, requiresAuth);
    final response = await http.delete(url, headers: requestHeaders);
    _log('DELETE', url, response);
    _printCurl('DELETE', url, requestHeaders, null);
    return _handleResponse(response, requiresAuth);
  }

  // 🧩 Common methods
  Map<String, String> _buildHeaders(
    Map<String, String>? headers,
    bool requiresAuth,
  ) {
    final requestHeaders = {'Content-Type': 'application/json', ...?headers};
    if (requiresAuth && tokenManager != null) {
      final token = tokenManager!.getAccessToken();
      if (token != null) {
        requestHeaders['Authorization'] = 'Bearer $token';
      }
    }
    return requestHeaders;
  }

  void _log(String method, Uri url, http.Response response) {
    print('=== HTTP $method ===');
    print('URL: $url');
    print('Status: ${response.statusCode}');
    print('Body: ${response.body}');
    print('====================');
  }

  dynamic _handleResponse(
    http.Response response,
    bool requiresAuth, [
    Future<dynamic> Function()? onRetry,
  ]) async {
    if (response.body.isEmpty) {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {'success': true, 'message': 'Success'};
      }
      throw Exception('Request failed with status ${response.statusCode}');
    }

    final data = jsonDecode(response.body);
    final code = response.statusCode;

    if (code >= 200 && code < 300) return data;

    if ((code == 401 || code == 403) && requiresAuth && onRetry != null) {
      return await onRetry();
    }

    if (code == 401 || code == 403) {
      throw UnauthorizedException(
        data is Map<String, dynamic>
            ? data['message'] ?? 'Phiên đăng nhập đã hết hạn'
            : 'Phiên đăng nhập đã hết hạn',
      );
    }

    throw ServerException(
      data is Map<String, dynamic>
          ? data['message'] ?? 'Request failed'
          : 'Request failed',
      statusCode: code,
    );
  }

  Future<bool> _refreshTokenIfNeeded() async {
    if (tokenManager == null) return false;

    final refreshToken = tokenManager!.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      onUnauthorized?.call();
      return false;
    }

    final response = await http.post(
      Uri.parse('$defaultBaseUrl/auth/refresh-token'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh_token': refreshToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final newAccessToken = data['access_token'] ?? '';
      if (newAccessToken.isNotEmpty) {
        await tokenManager!.saveTokens(
          accessToken: newAccessToken,
          refreshToken: refreshToken,
        );
        return true;
      }
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      onUnauthorized?.call();
    }
    return false;
  }
}
