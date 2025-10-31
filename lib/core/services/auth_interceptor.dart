import 'dart:async';

import 'package:http/http.dart' as http;

import 'token_manager.dart';

class AuthInterceptor {
  final TokenManager tokenManager;
  final Function() onRefreshToken;

  AuthInterceptor({required this.tokenManager, required this.onRefreshToken});

  Future<http.Response> send(
    http.Request request,
    Future<http.StreamedResponse> Function(http.Request) send,
  ) async {
    // Check if token needs refresh before making request
    if (tokenManager.shouldRefreshToken()) {
      await onRefreshToken();
    }

    // Add token to headers
    final token = tokenManager.getAccessToken();
    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    // Send request
    final streamedResponse = await send(request);
    final response = await http.Response.fromStream(streamedResponse);

    // If unauthorized, try to refresh token and retry
    if (response.statusCode == 401) {
      await onRefreshToken();

      // Retry request with new token
      final newToken = tokenManager.getAccessToken();
      if (newToken != null) {
        request.headers['Authorization'] = 'Bearer $newToken';
        final retryStreamedResponse = await send(request);
        return await http.Response.fromStream(retryStreamedResponse);
      }
    }

    return response;
  }
}
