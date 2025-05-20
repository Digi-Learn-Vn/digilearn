import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'landing_page.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final ValueNotifier<bool> isDarkTheme;
  final ValueNotifier<int> activeSection;
  final Function(GlobalKey) scrollToSection;

  const TopBar({
    required this.isDarkTheme,
    required this.activeSection,
    required this.scrollToSection,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = screenWidth > 600 ? 16.0 : 14.0;
    return AppBar(
      backgroundColor: isDarkTheme.value ? Colors.white : Colors.black,
      elevation: 0,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 14),
          Row(
            children: [
              Image.asset(
                isDarkTheme.value
                    ? 'assets/logo_dark.png'
                    : 'assets/logo_light.png',
                height: 40,
              ),
              const Spacer(),
              ValueListenableBuilder<int>(
                valueListenable: activeSection,
                builder: (context, activeSection, child) {
                  return Wrap(
                    spacing: screenWidth > 600 ? 20 : 10,
                    alignment: WrapAlignment.center,
                    children: [
                      _NavLink(
                        label: 'Home',
                        isActive: activeSection == 0,
                        onTap: () => scrollToSection(LandingPage.homeKey),
                        isDarkTheme: isDarkTheme.value,
                        fontSize: fontSize,
                      ),
                      _NavLink(
                        label: 'Explore',
                        isActive: activeSection == 1,
                        onTap: () => scrollToSection(LandingPage.exploreKey),
                        isDarkTheme: isDarkTheme.value,
                        fontSize: fontSize,
                      ),
                      _NavLink(
                        label: 'About Us',
                        isActive: activeSection == 2,
                        onTap: () => scrollToSection(LandingPage.aboutUsKey),
                        isDarkTheme: isDarkTheme.value,
                        fontSize: fontSize,
                      ),
                    ],
                  );
                },
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: () {
                  GoRouter.of(context).go('/account/signin');
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  backgroundColor:
                      isDarkTheme.value ? Colors.black : Colors.white,
                  foregroundColor:
                      isDarkTheme.value ? Colors.white : Colors.black,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Sign In', style: TextStyle(fontSize: fontSize)),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: isDarkTheme.value ? Colors.white : Colors.black,
                    ),
                  ],
                ),
              ),
            ],
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
            ),
            child: Divider(
              color: isDarkTheme.value ? Colors.black : Colors.white,
              thickness: 0.2,
            ),
          ),
        ],
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

  const _NavLink({
    required this.label,
    this.isActive = false,
    required this.onTap,
    required this.isDarkTheme,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
                color: isDarkTheme ? Colors.black : Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            if (isActive)
              Container(
                height: 2,
                width: 40,
                color: isDarkTheme ? Colors.black : Colors.white,
              ),
          ],
        ),
      ),
    );
  }
}
