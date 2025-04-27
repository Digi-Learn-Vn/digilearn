import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomBar extends StatelessWidget {
  final ValueNotifier<bool> isDarkTheme;
  final VoidCallback toggleTheme;

  const BottomBar({required this.isDarkTheme, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = screenWidth > 600 ? 16.0 : 14.0;
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () async {
                    final url = Uri.parse('https://enterprise.example.com');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  },
                  child: Text(
                    'Open Enterprise',
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w500,
                      color: isDarkTheme.value ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ),
              Wrap(
                spacing: screenWidth > 600 ? 20 : 10,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  _buildLink(
                      'Documentation', 'https://docs.example.com', fontSize),
                  _buildLink('Github', 'https://github.com/example', fontSize),
                  _buildLink(
                      'Twitter', 'https://twitter.com/example', fontSize),
                  _buildLink(
                      'Contact Us', 'https://example.com/contact', fontSize),
                  IconButton(
                    icon: Icon(
                      isDarkTheme.value ? Icons.dark_mode : Icons.light_mode,
                      size: 20,
                    ),
                    onPressed: toggleTheme,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLink(String label, String url, double fontSize) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          }
        },
        child: Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            color: isDarkTheme.value ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}
