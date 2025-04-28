import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final ValueNotifier<bool> isDarkTheme;
  final VoidCallback toggleTheme;

  const BottomBar({required this.isDarkTheme, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: IconButton(
          icon: Icon(
            isDarkTheme.value ? Icons.dark_mode : Icons.light_mode,
            size: 20,
          ),
          onPressed: toggleTheme,
        ),
      ),
    );
  }
}
