import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_app/core/theme/theme_provider.dart';

class DiscussPage extends StatefulWidget {
  const DiscussPage({Key? key}) : super(key: key);

  @override
  _DiscussPageState createState() => _DiscussPageState();
}

class _DiscussPageState extends State<DiscussPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.isDarkTheme ? Colors.white : Colors.black,
      appBar: AppBar(
        backgroundColor:
            themeProvider.isDarkTheme ? Colors.white : Colors.black,
        elevation: 0,
        title: Column(children: [
          const SizedBox(height: 14),
          Row(
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    GoRouter.of(context).go('/');
                  },
                  child: Image.asset(
                    themeProvider.isDarkTheme
                        ? 'assets/logo_dark.png'
                        : 'assets/logo_light.png',
                    height: 40,
                  ),
                ),
              ),
              const SizedBox(width: 32),
              _NavLink(
                label: 'Explore',
                isActive: false,
                onTap: () {
                  GoRouter.of(context).go('/explore');
                },
                isDarkTheme: themeProvider.isDarkTheme,
                fontSize: 16,
              ),
              const SizedBox(width: 16),
              _NavLink(
                label: 'Discuss',
                isActive: false,
                onTap: () {
                  GoRouter.of(context).go('/discuss');
                },
                isDarkTheme: themeProvider.isDarkTheme,
                fontSize: 16,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: themeProvider.isDarkTheme
                          ? Colors.black
                          : Colors.white,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
              child: Divider(
                color: themeProvider.isDarkTheme ? Colors.black : Colors.white,
                thickness: 0.2,
              )),
        ]),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Discuss Pages',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: themeProvider.isDarkTheme ? Colors.white : Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLink("Privacy Policy", "https://yourdomain.com/privacy", 12),
            const SizedBox(width: 16),
            _buildLink("Terms of Service", "https://yourdomain.com/terms", 12),
            const SizedBox(width: 16),
            Text(
              "© 2025 Your Company",
              style: TextStyle(
                fontSize: 12,
                color: themeProvider.isDarkTheme ? Colors.black : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLink(String label, String url, double fontSize) {
    final themeProvider = Provider.of<ThemeProvider>(context);

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
            color: themeProvider.isDarkTheme ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final bool isDarkTheme;
  final double fontSize;
  final BoxDecoration decoration;

  const _NavLink({
    required this.label,
    required this.isActive,
    required this.onTap,
    required this.isDarkTheme,
    required this.fontSize,
    this.decoration = const BoxDecoration(),
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(
              bottom: 4.0), // Added space between text and bottom line
          decoration: decoration,
          child: Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isDarkTheme ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
