import 'package:flutter/material.dart';

class GenericSection extends StatelessWidget {
  final GlobalKey key;
  final String title;
  final Color color;
  final ValueNotifier<bool> isDarkTheme;

  const GenericSection({
    required this.key,
    required this.title,
    required this.color,
    required this.isDarkTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      color: color,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: isDarkTheme.value ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}
