import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const baseUrl =
    'http://127.0.0.1:8000/accounts'; // Replace with your IP on real device

final storage = FlutterSecureStorage();

Future<Map<String, dynamic>> login(String username, String password) async {
  final response = await http.post(
    Uri.parse('$baseUrl/login/'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'username': username, 'password': password}),
  );
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
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

  print('Register API response status: ${response.statusCode}');
  print('Register API response body: ${response.body}');

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

Future<Map<String, dynamic>> getCookieData() async {
  final response = await http.get(
    Uri.parse('$baseUrl/cookie/'),
    headers: {'Content-Type': 'application/json'},
  );

  print('Cookie API response status: ${response.statusCode}');
  print('Cookie API response headers: ${response.headers}');

  if (response.statusCode == 200) {
    final cookies = response.headers['set-cookie'];
    if (cookies != null) {
      return {
        'status': response.statusCode,
        'message': 'Cookie data retrieved successfully',
        'cookies': cookies,
      };
    } else {
      return {
        'status': response.statusCode,
        'message': 'No cookies found in the response',
      };
    }
  } else {
    return {
      'status': response.statusCode,
      'message': 'Failed to retrieve cookie data: ${response.body}',
    };
  }
}
