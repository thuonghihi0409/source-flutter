import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../error/exceptions.dart';
import 'token_manager.dart';

class HttpService {
  static const String baseUrl = 'https://mvp-api-dev.depay.ai';

  final TokenManager? tokenManager;
  Function()? onRefreshToken;
  Function()? onUnauthorized;

  HttpService({this.tokenManager, this.onRefreshToken, this.onUnauthorized});

  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool requiresAuth = false,
    bool isRetry = false,
    bool skipTokenRefresh = false,
  }) async {
    try {
      // Check if token needs refresh before making request
      if (requiresAuth &&
          tokenManager != null &&
          !isRetry &&
          !skipTokenRefresh &&
          tokenManager!.shouldRefreshToken()) {
        print('🔄 Token needs refresh, refreshing before request...');
        await _refreshTokenIfNeeded();
      }

      final url = Uri.parse('$baseUrl$endpoint');

      final requestHeaders = <String, String>{
        'Content-Type': 'application/json',
        ...?headers,
      };

      // Add auth token if required
      if (requiresAuth && tokenManager != null) {
        final token = tokenManager!.getAccessToken();
        if (token != null) {
          requestHeaders['Authorization'] = 'Bearer $token';
        }
      }

      final response = await http.post(
        url,
        headers: requestHeaders,
        body: body != null ? jsonEncode(body) : null,
      );

      // Log response
      print('=== HTTP POST ===');
      print('URL: $url');
      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');
      print('=================');

      // Handle empty response
      if (response.body.isEmpty || response.body == '') {
        if (response.statusCode >= 200 && response.statusCode < 300) {
          return {'success': true, 'message': 'Success'};
        } else {
          throw Exception('Request failed with status ${response.statusCode}');
        }
      }

      final responseData = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Handle both array and object responses
        if (responseData is List) {
          return {'data': responseData};
        } else if (responseData is Map<String, dynamic>) {
          return responseData;
        } else {
          return {'data': responseData};
        }
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        // Try to refresh token and retry request once
        if (!isRetry && requiresAuth && tokenManager != null) {
          print('🔄 401/403 error, attempting to refresh token and retry...');
          final refreshed = await _refreshTokenIfNeeded();
          if (refreshed) {
            print('✅ Token refreshed, retrying request...');
            return await post(
              endpoint,
              body: body,
              headers: headers,
              requiresAuth: requiresAuth,
              isRetry: true,
            );
          }
        }

        // Unauthorized - token expired or invalid and refresh failed
        // Call unauthorized callback to handle logout
        onUnauthorized?.call();
        throw UnauthorizedException(
          responseData['message'] ?? 'Phiên đăng nhập đã hết hạn',
        );
      } else {
        // Handle error message - could be String or List
        String errorMessage = 'Request failed';
        if (responseData is Map<String, dynamic>) {
          final message = responseData['message'];
          if (message is List) {
            errorMessage = message.join(', ');
          } else if (message is String) {
            errorMessage = message;
          }
        }

        throw ServerException(errorMessage, statusCode: response.statusCode);
      }
    } on UnauthorizedException {
      rethrow;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw NetworkException('Network error: $e');
    }
  }

  Future<Map<String, dynamic>> put(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool requiresAuth = false,
  }) async {
    try {
      // Check if token needs refresh
      if (requiresAuth &&
          tokenManager != null &&
          tokenManager!.shouldRefreshToken()) {
        onRefreshToken?.call();
      }

      final url = Uri.parse('$baseUrl$endpoint');

      final requestHeaders = <String, String>{
        'Content-Type': 'application/json',
        ...?headers,
      };

      // Add auth token if required
      if (requiresAuth && tokenManager != null) {
        final token = tokenManager!.getAccessToken();
        if (token != null) {
          requestHeaders['Authorization'] = 'Bearer $token';
        }
      }

      final response = await http.put(
        url,
        headers: requestHeaders,
        body: body != null ? jsonEncode(body) : null,
      );

      // Log response
      print('=== HTTP PUT ===');
      print('URL: $url');
      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');
      print('================');

      // Handle empty response
      if (response.body.isEmpty || response.body == '') {
        if (response.statusCode >= 200 && response.statusCode < 300) {
          return {'success': true, 'message': 'Success'};
        } else {
          throw Exception('Request failed with status ${response.statusCode}');
        }
      }

      final responseData = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Handle both array and object responses
        if (responseData is List) {
          return {'data': responseData};
        } else if (responseData is Map<String, dynamic>) {
          return responseData;
        } else {
          return {'data': responseData};
        }
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        // Unauthorized - token expired or invalid
        // Call unauthorized callback to handle logout
        onUnauthorized?.call();
        throw UnauthorizedException(
          responseData['message'] ?? 'Phiên đăng nhập đã hết hạn',
        );
      } else {
        // Handle error message - could be String or List
        String errorMessage = 'Request failed';
        if (responseData is Map<String, dynamic>) {
          final message = responseData['message'];
          if (message is List) {
            errorMessage = message.join(', ');
          } else if (message is String) {
            errorMessage = message;
          }
        }

        throw ServerException(errorMessage, statusCode: response.statusCode);
      }
    } on UnauthorizedException {
      rethrow;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw NetworkException('Network error: $e');
    }
  }

  Future<Map<String, dynamic>> patch(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool requiresAuth = false,
  }) async {
    try {
      // Check if token needs refresh
      if (requiresAuth &&
          tokenManager != null &&
          tokenManager!.shouldRefreshToken()) {
        onRefreshToken?.call();
      }

      final url = Uri.parse('$baseUrl$endpoint');

      final requestHeaders = <String, String>{
        'Content-Type': 'application/json',
        ...?headers,
      };

      // Add auth token if required
      if (requiresAuth && tokenManager != null) {
        final token = tokenManager!.getAccessToken();
        if (token != null) {
          requestHeaders['Authorization'] = 'Bearer $token';
        }
      }

      final response = await http.patch(
        url,
        headers: requestHeaders,
        body: body != null ? jsonEncode(body) : null,
      );

      // Log response
      print('=== HTTP PATCH ===');
      print('URL: $url');
      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');
      print('==================');

      // Handle empty response
      if (response.body.isEmpty || response.body == '') {
        if (response.statusCode >= 200 && response.statusCode < 300) {
          return {'success': true, 'message': 'Success'};
        } else {
          throw Exception('Request failed with status ${response.statusCode}');
        }
      }

      final responseData = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Handle both array and object responses
        if (responseData is List) {
          return {'data': responseData};
        } else if (responseData is Map<String, dynamic>) {
          return responseData;
        } else {
          return {'data': responseData};
        }
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        // Unauthorized - token expired or invalid
        // Call unauthorized callback to handle logout
        onUnauthorized?.call();
        throw UnauthorizedException(
          responseData['message'] ?? 'Phiên đăng nhập đã hết hạn',
        );
      } else {
        // Handle error message - could be String or List
        String errorMessage = 'Request failed';
        if (responseData is Map<String, dynamic>) {
          final message = responseData['message'];
          if (message is List) {
            errorMessage = message.join(', ');
          } else if (message is String) {
            errorMessage = message;
          }
        }

        throw ServerException(errorMessage, statusCode: response.statusCode);
      }
    } on UnauthorizedException {
      rethrow;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw NetworkException('Network error: $e');
    }
  }

  Future<Map<String, dynamic>> delete(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    bool requiresAuth = false,
  }) async {
    try {
      // Check if token needs refresh
      if (requiresAuth &&
          tokenManager != null &&
          tokenManager!.shouldRefreshToken()) {
        onRefreshToken?.call();
      }

      var url = Uri.parse('$baseUrl$endpoint');

      if (queryParameters != null) {
        url = url.replace(queryParameters: queryParameters);
      }

      final requestHeaders = <String, String>{
        'Content-Type': 'application/json',
        ...?headers,
      };

      // Add auth token if required
      if (requiresAuth && tokenManager != null) {
        final token = tokenManager!.getAccessToken();
        if (token != null) {
          requestHeaders['Authorization'] = 'Bearer $token';
        }
      }

      final response = await http.delete(url, headers: requestHeaders);

      // Log response
      print('=== HTTP DELETE ===');
      print('URL: $url');
      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');
      print('===================');

      // Handle empty response
      if (response.body.isEmpty || response.body == '') {
        if (response.statusCode >= 200 && response.statusCode < 300) {
          return {'success': true, 'message': 'Success'};
        } else {
          throw Exception('Request failed with status ${response.statusCode}');
        }
      }

      final responseData = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Handle both array and object responses
        if (responseData is List) {
          return {'data': responseData};
        } else if (responseData is Map<String, dynamic>) {
          return responseData;
        } else {
          return {'data': responseData};
        }
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        // Unauthorized - token expired or invalid
        // Call unauthorized callback to handle logout
        onUnauthorized?.call();
        throw UnauthorizedException(
          responseData['message'] ?? 'Phiên đăng nhập đã hết hạn',
        );
      } else {
        // Handle error message - could be String or List
        String errorMessage = 'Request failed';
        if (responseData is Map<String, dynamic>) {
          final message = responseData['message'];
          if (message is List) {
            errorMessage = message.join(', ');
          } else if (message is String) {
            errorMessage = message;
          }
        }

        throw ServerException(errorMessage, statusCode: response.statusCode);
      }
    } on UnauthorizedException {
      rethrow;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw NetworkException('Network error: $e');
    }
  }

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    bool requiresAuth = false,
    bool isRetry = false,
    bool skipTokenRefresh = false,
  }) async {
    try {
      // Check if token needs refresh before making request
      if (requiresAuth &&
          tokenManager != null &&
          !isRetry &&
          !skipTokenRefresh &&
          tokenManager!.shouldRefreshToken()) {
        print('🔄 Token needs refresh, refreshing before request...');
        await _refreshTokenIfNeeded();
      }

      var url = Uri.parse('$baseUrl$endpoint');

      if (queryParameters != null) {
        url = url.replace(queryParameters: queryParameters);
      }

      final requestHeaders = <String, String>{
        'Content-Type': 'application/json',
        ...?headers,
      };

      // Add auth token if required
      if (requiresAuth && tokenManager != null) {
        final token = tokenManager!.getAccessToken();
        if (token != null) {
          requestHeaders['Authorization'] = 'Bearer $token';
        }
      }

      final response = await http.get(url, headers: requestHeaders);

      // Log response
      print('=== HTTP GET ===');
      print('URL: $url');
      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');
      print('================');

      // Handle empty response
      if (response.body.isEmpty || response.body == '') {
        if (response.statusCode >= 200 && response.statusCode < 300) {
          return {'success': true, 'message': 'Success'};
        } else {
          throw Exception('Request failed with status ${response.statusCode}');
        }
      }

      final responseData = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Handle both array and object responses
        if (responseData is List) {
          return {'data': responseData};
        } else if (responseData is Map<String, dynamic>) {
          return responseData;
        } else {
          return {'data': responseData};
        }
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        // Try to refresh token and retry request once
        if (!isRetry && requiresAuth && tokenManager != null) {
          print('🔄 401/403 error, attempting to refresh token and retry...');
          final refreshed = await _refreshTokenIfNeeded();
          if (refreshed) {
            print('✅ Token refreshed, retrying request...');
            return await get(
              endpoint,
              headers: headers,
              queryParameters: queryParameters,
              requiresAuth: requiresAuth,
              isRetry: true,
            );
          }
        }

        // Unauthorized - token expired or invalid and refresh failed
        // Call unauthorized callback to handle logout
        onUnauthorized?.call();
        throw UnauthorizedException(
          responseData['message'] ?? 'Phiên đăng nhập đã hết hạn',
        );
      } else {
        // Handle error message - could be String or List
        String errorMessage = 'Request failed';
        if (responseData is Map<String, dynamic>) {
          final message = responseData['message'];
          if (message is List) {
            errorMessage = message.join(', ');
          } else if (message is String) {
            errorMessage = message;
          }
        }

        throw ServerException(errorMessage, statusCode: response.statusCode);
      }
    } on UnauthorizedException {
      rethrow;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw NetworkException('Network error: $e');
    }
  }

  Future<bool> _refreshTokenIfNeeded() async {
    try {
      if (tokenManager == null) return false;

      final refreshToken = tokenManager!.getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        print('⚠️ No refresh token available');
        onUnauthorized?.call();
        return false;
      }

      print('🔄 Refreshing access token...');
      final response = await http.post(
        Uri.parse('$baseUrl/auth/refresh-token'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refresh_token': refreshToken}),
      );

      print('Refresh token response: ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final newAccessToken = responseData['access_token'] ?? '';

        if (newAccessToken.isNotEmpty) {
          await tokenManager!.saveTokens(
            accessToken: newAccessToken,
            refreshToken: refreshToken,
          );
          print('✅ Access token refreshed successfully');
          return true;
        }
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        // Refresh token expired
        print('⚠️ Refresh token expired, logging out...');
        onUnauthorized?.call();
      }

      return false;
    } catch (e) {
      print('❌ Error refreshing token: $e');
      return false;
    }
  }

  /// Upload file to server
  Future<Map<String, dynamic>> uploadFile(
    String endpoint, {
    required File file,
    required String fieldName,
    Map<String, String>? additionalFields,
    Map<String, String>? headers,
    bool requiresAuth = false,
    bool isRetry = false,
  }) async {
    try {
      // Check if token needs refresh before making request
      if (requiresAuth &&
          tokenManager != null &&
          !isRetry &&
          tokenManager!.shouldRefreshToken()) {
        print('🔄 Token needs refresh, refreshing before upload...');
        await _refreshTokenIfNeeded();
      }

      final url = Uri.parse('$baseUrl$endpoint');

      // Create multipart request
      final request = http.MultipartRequest('POST', url);

      // Add headers
      final requestHeaders = <String, String>{...?headers};

      // Add auth token if required
      if (requiresAuth && tokenManager != null) {
        final token = tokenManager!.getAccessToken();
        if (token != null) {
          requestHeaders['Authorization'] = 'Bearer $token';
        }
      }

      request.headers.addAll(requestHeaders);

      // Add file with proper content type
      final multipartFile = await http.MultipartFile.fromPath(
        fieldName,
        file.path,
        contentType: _getContentType(file.path),
      );
      request.files.add(multipartFile);

      // Add additional fields
      if (additionalFields != null) {
        request.fields.addAll(additionalFields);
      }

      // Log multipart request details
      print('📤 Multipart request details:');
      print('📤 Field name: $fieldName');
      print('📤 File path: ${file.path}');
      print('📤 Content type: ${multipartFile.contentType}');
      print('📤 Additional fields: $additionalFields');

      // Send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      // Log response
      print('=== HTTP UPLOAD ===');
      print('URL: $url');
      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');
      print('===================');

      // Handle empty response
      if (response.body.isEmpty || response.body == '') {
        if (response.statusCode >= 200 && response.statusCode < 300) {
          return {'success': true, 'message': 'Upload successful'};
        } else {
          throw ServerException(
            'Upload failed with status ${response.statusCode}',
            statusCode: response.statusCode,
          );
        }
      }

      final responseData = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return responseData;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        // Try to refresh token and retry request once
        if (!isRetry && requiresAuth && tokenManager != null) {
          print(
            '🔄 401/403 error, attempting to refresh token and retry upload...',
          );
          final refreshed = await _refreshTokenIfNeeded();
          if (refreshed) {
            print('✅ Token refreshed, retrying upload...');
            return await uploadFile(
              endpoint,
              file: file,
              fieldName: fieldName,
              additionalFields: additionalFields,
              headers: headers,
              requiresAuth: requiresAuth,
              isRetry: true,
            );
          }
        }

        // Unauthorized - token expired or invalid and refresh failed
        throw UnauthorizedException(
          'Upload unauthorized: ${responseData['message'] ?? 'Authentication failed'}',
        );
      } else {
        throw ServerException(
          'Upload failed: ${responseData['message'] ?? 'Unknown error'}',
          statusCode: response.statusCode,
        );
      }
    } on UnauthorizedException {
      rethrow;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw NetworkException('Upload network error: $e');
    }
  }

  /// Get content type based on file extension
  MediaType? _getContentType(String filePath) {
    final extension = filePath.toLowerCase().split('.').last;
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return MediaType('image', 'jpeg');
      case 'png':
        return MediaType('image', 'png');
      case 'mp4':
        return MediaType('video', 'mp4');
      default:
        return null;
    }
  }
}
