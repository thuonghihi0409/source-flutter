class ApiConfig {
  // API endpoints
  static const String loginEndpoint = '/api/method/login';
  static const String logoutEndpoint = '/api/method/logout';
  static const String apiKeyEndpoint =
      '/api/method/frappe.core.doctype.user.user.generate_keys';
  static const String passwordChangeEndpoint =
      '/api/method/frappe.core.doctype.user.user.update_password';
  static const String domainCheckEndpoint =
      '/api/method/frappe.core.doctype.domain.domain.check_domain';
  static const String employeeResourceEndpoint = '/api/resource/Employee';

  // Headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/x-www-form-urlencoded',
  };

  // Build Authorization header for API requests
  static String buildAuthHeader(String apiKey, String apiSecret) {
    return 'token $apiKey:$apiSecret';
  }

  static String buildUrl(String? domain) {
    if (domain != null && domain.isNotEmpty) {
      return 'https://$domain.hexerp.com';
    }
    throw Exception('Domain is required');
  }

  // Build API endpoint URL
  static String buildApiUrl(String? domain, String endpoint) {
    final baseUrl = buildUrl(domain);

    final normalizedEndpoint = endpoint.startsWith('/')
        ? endpoint
        : '/$endpoint';
    return '$baseUrl$normalizedEndpoint';
  }
}
