import 'package:flutter/material.dart';
import 'pages/landing_page.dart'; // <-- Import file LandingPage ở đây

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Academy App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandingPage(), // <-- Đặt LandingPage làm trang đầu tiên
    );
  }
}
