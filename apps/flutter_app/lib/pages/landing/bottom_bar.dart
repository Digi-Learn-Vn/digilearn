import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/core/theme/theme_provider.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: IconButton(
          icon: Icon(
            themeProvider.isDarkTheme ? Icons.dark_mode : Icons.light_mode,
            size: 20,
          ),
          onPressed: themeProvider.toggleTheme,
        ),
      ),
    );
  }
}
