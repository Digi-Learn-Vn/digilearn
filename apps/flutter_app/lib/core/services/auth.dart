import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const baseUrl =
    'http://127.0.0.1:8000/accounts'; // Replace with your IP on real device

final storage = FlutterSecureStorage();

Future<Map<String, dynamic>> login(String username, String password) async {
  final response = await http.post(
    Uri.parse('$baseUrl/login/api'),
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
      'data': data
    };
  } else {
    return {
      'status': response.statusCode,
      'message': 'Login failed: ${response.body}'
    };
  }
}

Future<Map<String, dynamic>> register(
    String username, String email, String password) async {
  final response = await http.post(
    Uri.parse('$baseUrl/signup/api'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'username': username,
      'email': email,
      'password': password,
    }),
  );

  print('Register API response status: ${response.statusCode}');
  print('Register API response body: ${response.body}');

  if (response.statusCode == 201) {
    return {
      'status': response.statusCode,
      'message': 'Registration successful'
    };
  } else {
    return {
      'status': response.statusCode,
      'message': 'Registration failed: ${response.body}'
    };
  }
}
