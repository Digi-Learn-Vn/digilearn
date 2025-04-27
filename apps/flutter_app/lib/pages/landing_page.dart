import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _marketKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _blogKey = GlobalKey();

  final ValueNotifier<int> _activeSection = ValueNotifier<int>(0);
  final ValueNotifier<bool> _isDarkTheme =
      ValueNotifier<bool>(true); // Theme notifier initialized to true

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _activeSection.dispose();
    _isDarkTheme.dispose(); // Dispose theme notifier
    super.dispose();
  }

  void _toggleTheme() {
    _isDarkTheme.value = !_isDarkTheme.value;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isDarkTheme,
      builder: (context, isDarkTheme, child) {
        return Scaffold(
          appBar: _buildTopBar(),
          body: Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    _buildHomeSection(context),
                    _buildSection(context, _aboutKey, 'About Section',
                        _isDarkTheme.value ? Colors.white : Colors.black),
                    _buildSection(context, _marketKey, 'Market Section',
                        _isDarkTheme.value ? Colors.white : Colors.black),
                    _buildSection(context, _servicesKey, 'Services Section',
                        _isDarkTheme.value ? Colors.white : Colors.black),
                    _buildSection(context, _blogKey, 'Blog Section',
                        _isDarkTheme.value ? Colors.white : Colors.black),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: _buildBottomBar(),
              ),
            ],
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildTopBar() {
    return AppBar(
      backgroundColor:
          _isDarkTheme.value ? Colors.white : Colors.black, // Fixed color
      elevation: 0, // No shadow
      title: Row(
        children: [
          Image.asset(
            _isDarkTheme.value
                ? 'assets/logo_dark.png'
                : 'assets/logo_light.png',
            height: 40,
          ),
          const Spacer(),
          ValueListenableBuilder<int>(
            valueListenable: _activeSection,
            builder: (context, activeSection, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _NavLink(
                    label: 'Home',
                    isActive: activeSection == 0,
                    onTap: () => _scrollToSection(_homeKey),
                    isDarkTheme: _isDarkTheme.value, // Pass theme state
                  ),
                  const SizedBox(width: 20),
                  _NavLink(
                    label: 'About',
                    isActive: activeSection == 1,
                    onTap: () => _scrollToSection(_aboutKey),
                    isDarkTheme: _isDarkTheme.value, // Pass theme state
                  ),
                  const SizedBox(width: 20),
                  _NavLink(
                    label: 'Market',
                    isActive: activeSection == 2,
                    onTap: () => _scrollToSection(_marketKey),
                    isDarkTheme: _isDarkTheme.value, // Pass theme state
                  ),
                  const SizedBox(width: 20),
                  _NavLink(
                    label: 'Services',
                    isActive: activeSection == 3,
                    onTap: () => _scrollToSection(_servicesKey),
                    isDarkTheme: _isDarkTheme.value, // Pass theme state
                  ),
                  const SizedBox(width: 20),
                  _NavLink(
                    label: 'Blog',
                    isActive: activeSection == 4,
                    onTap: () => _scrollToSection(_blogKey),
                    isDarkTheme: _isDarkTheme.value, // Pass theme state
                  ),
                ],
              );
            },
          ),
          const Spacer(),
          OutlinedButton(
            onPressed: () {
              // Handle sign-in action
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              backgroundColor: _isDarkTheme.value ? Colors.black : Colors.white,
              foregroundColor: _isDarkTheme.value ? Colors.white : Colors.black,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Sign In', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward,
                  size: 16,
                  color: _isDarkTheme.value ? Colors.white : Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeSection(BuildContext context) {
    return Container(
      key: _homeKey,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: _isDarkTheme.value ? Colors.white : Colors.black,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(115, 115, 0, 140),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextSection(),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 20),
            Flexible(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 115, 25),
                child: _buildLogo(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
      BuildContext context, GlobalKey key, String title, Color color) {
    // Accept context as a parameter
    return Container(
      key: key,
      height: MediaQuery.of(context).size.height, // Use context here
      color: color,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: _isDarkTheme.value ? Colors.black : Colors.white),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'assets/bravo.png',
      fit: BoxFit.contain,
    );
  }

  Widget _buildTextSection() {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'From Learning to Mastery. Start Your Journey Today',
            style: TextStyle(
              fontSize: 54,
              fontWeight: FontWeight.bold,
              color: _isDarkTheme.value ? Colors.black : Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'DIGILEARN empowers you to explore science deeply and apply your knowledge with confidence. Join us to learn, practice, and achieve your academic goals.',
            style: TextStyle(
              fontSize: 16,
              color: _isDarkTheme.value ? Colors.black : Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () {
              // Handle sign-in action
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              backgroundColor: _isDarkTheme.value ? Colors.black : Colors.white,
              foregroundColor: _isDarkTheme.value ? Colors.white : Colors.black,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Create Account',
                  style: TextStyle(fontSize: 32),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
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
                  fontSize: 16,
                  color: _isDarkTheme.value ? Colors.black : Colors.white,
                ),
              ),
            ),
          ),
          Row(
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () async {
                    final url = Uri.parse('https://docs.example.com');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  },
                  child: Text(
                    'Documentation',
                    style: TextStyle(
                        fontSize: 16,
                        color:
                            _isDarkTheme.value ? Colors.black : Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () async {
                    final url = Uri.parse('https://github.com/example');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  },
                  child: Text(
                    'Github',
                    style: TextStyle(
                        fontSize: 16,
                        color:
                            _isDarkTheme.value ? Colors.black : Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () async {
                    final url = Uri.parse('https://twitter.com/example');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  },
                  child: Text(
                    'Twitter',
                    style: TextStyle(
                        fontSize: 16,
                        color:
                            _isDarkTheme.value ? Colors.black : Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () async {
                    final url = Uri.parse('https://example.com/contact');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  },
                  child: Text(
                    'Contact Us',
                    style: TextStyle(
                        fontSize: 16,
                        color:
                            _isDarkTheme.value ? Colors.black : Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              IconButton(
                icon: Icon(
                  _isDarkTheme.value ? Icons.dark_mode : Icons.light_mode,
                ),
                onPressed: _toggleTheme, // Call theme toggle function
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onScroll() {
    final double offset = _scrollController.offset;
    final double screenHeight = MediaQuery.of(context).size.height;

    if (offset < screenHeight * 0.5) {
      _activeSection.value = 0; // Home
    } else if (offset < screenHeight * 1.5) {
      _activeSection.value = 1; // About
    } else if (offset < screenHeight * 2.5) {
      _activeSection.value = 2; // Market
    } else if (offset < screenHeight * 3.5) {
      _activeSection.value = 3; // Services
    } else {
      _activeSection.value = 4; // Blog
    }
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final bool isDarkTheme; // New parameter to accept theme state

  const _NavLink({
    required this.label,
    this.isActive = false,
    required this.onTap,
    required this.isDarkTheme, // Initialize the new parameter
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color:
                  isDarkTheme ? Colors.black : Colors.white, // Use theme state
            ),
          ),
          const SizedBox(height: 4), // Space between text and underline
          if (isActive)
            Container(
              height: 2, // Thickness of the underline
              width: 40, // Width of the underline
              color:
                  isDarkTheme ? Colors.black : Colors.white, // Use theme state
            ),
        ],
      ),
    );
  }
}
