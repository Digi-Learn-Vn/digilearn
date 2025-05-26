import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const baseUrl =
    'http://127.0.0.1:8000/api/accounts'; // Updated to match the backend port

final storage = FlutterSecureStorage();

Future<Map<String, dynamic>> login(String username, String password) async {
  final response = await http.post(
    Uri.parse('$baseUrl/login/'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'username': username, 'password': password}),
  );
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    // Store JWT tokens if present
    if (data['access'] != null && data['refresh'] != null) {
      await storeTokens(data['access'], data['refresh']);
    }
    return {
      'status': response.statusCode,
      'message': 'Login successful',
      'data': data,
    };
  } else {
    return {
      'status': response.statusCode,
      'message': 'Login failed: ${response.body}',
    };
  }
}

Future<Map<String, dynamic>> register(
  String username,
  String profilename,
  String email,
  String password,
  String repassword,
) async {
  final response = await http.post(
    Uri.parse('$baseUrl/signup/'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'username': username,
      'name': profilename,
      'email': email,
      'password': password,
      'reenter_password': repassword,
    }),
  );

  if (response.statusCode == 200) {
    return {
      'status': response.statusCode,
      'message': 'Registration successful',
    };
  } else {
    return {
      'status': response.statusCode,
      'message': 'Registration failed: ${response.body}',
    };
  }
}

Future<void> storeTokens(String access, String refresh) async {
  await storage.write(key: 'accessToken', value: access);
  await storage.write(key: 'refreshToken', value: refresh);
}

Future<String?> getAccessToken() async {
  return await storage.read(key: 'accessToken');
}

Future<String?> getRefreshToken() async {
  return await storage.read(key: 'refreshToken');
}

Future<void> clearTokens() async {
  await storage.delete(key: 'accessToken');
  await storage.delete(key: 'refreshToken');
}

Future<bool> refreshAccessToken() async {
  final refreshToken = await getRefreshToken();
  if (refreshToken == null) return false;
  final response = await http.post(
    Uri.parse('$baseUrl/refresh-token/'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'refresh': refreshToken}),
  );
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    await storeTokens(data['access'], refreshToken);
    return true;
  } else {
    await clearTokens();
    return false;
  }
}

Future<http.Response?> authenticatedRequest(String url,
    {String method = 'GET', Map<String, dynamic>? body}) async {
  String? accessToken = await getAccessToken();
  if (accessToken == null) {
    bool refreshed = await refreshAccessToken();
    if (!refreshed) return null;
    accessToken = await getAccessToken();
  }
  final headers = {
    'Authorization': 'Bearer $accessToken',
    'Content-Type': 'application/json',
  };
  final uri = Uri.parse(url);
  if (method == 'GET') {
    return await http.get(uri, headers: headers);
  } else if (method == 'POST') {
    return await http.post(uri,
        headers: headers, body: body != null ? jsonEncode(body) : null);
  }
  return null;
}

Future<void> logout() async {
  await clearTokens();
}

Future<Map<String, dynamic>?> getUserProfile() async {
  final url = '$baseUrl/user/';
  final response = await authenticatedRequest(url);

  if (response != null && response.statusCode == 200) {
    print('User profile response: ${response.body}');
    return jsonDecode(response.body);
  } else {
    return null;
  }
}
