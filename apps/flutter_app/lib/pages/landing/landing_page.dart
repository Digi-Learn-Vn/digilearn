import 'package:flutter/material.dart';
import 'top_bar.dart';
import 'home_section.dart';
import 'explore_section.dart';
import 'aboutus_section.dart';
import 'bottom_bar.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  static final GlobalKey homeKey = GlobalKey();
  static final GlobalKey exploreKey = GlobalKey();
  static final GlobalKey aboutUsKey = GlobalKey();

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<int> _activeSection = ValueNotifier<int>(0);
  final ValueNotifier<bool> _isDarkTheme = ValueNotifier<bool>(true);

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
    _isDarkTheme.dispose();
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
          appBar: TopBar(
            isDarkTheme: _isDarkTheme,
            activeSection: _activeSection,
            scrollToSection: _scrollToSection,
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    HomeSection(
                      key: LandingPage.homeKey,
                      isDarkTheme: _isDarkTheme,
                    ),
                    ExploreSection(
                      key: LandingPage.exploreKey,
                      isDarkTheme: _isDarkTheme,
                    ),
                    AboutUsSection(
                      key: LandingPage.aboutUsKey,
                      isDarkTheme: _isDarkTheme,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: BottomBar(
                  isDarkTheme: _isDarkTheme,
                  toggleTheme: _toggleTheme,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onScroll() {
    final double offset = _scrollController.offset;
    final double screenHeight = MediaQuery.of(context).size.height;

    if (offset < screenHeight * 0.5) {
      _activeSection.value = 0;
    } else if (offset < screenHeight * 1) {
      _activeSection.value = 1;
    } else {
      _activeSection.value = 2;
    }
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    print('Scrolling to section: $key');
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      print('Context is null for key: $key');
    }
  }
}
