import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_app/core/theme/theme_provider.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
              const SizedBox(width: 16),
              _NavLink(
                label: 'Discuss',
                isActive: false,
                onTap: () {
                  GoRouter.of(context).go('/discuss');
                },
                isDarkTheme: themeProvider.isDarkTheme,
                fontSize: 16,
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
              child: Text(
                'Welcome to',
                style: TextStyle(
                  fontSize: 16,
                  color:
                      themeProvider.isDarkTheme ? Colors.black : Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: Row(
                children: [
                  Text(
                    'DigiLearn Explore',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.isDarkTheme
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      // TODO: Implement favorite functionality
                    },
                    icon: Icon(
                      Icons.favorite_border,
                      size: 32,
                      color: themeProvider.isDarkTheme
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                  SizedBox(width: 5),
                  IconButton(
                    onPressed: () {
                      // TODO: Implement favorite functionality
                    },
                    icon: Icon(
                      Icons.history,
                      size: 32,
                      color: themeProvider.isDarkTheme
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 75),
            SectionHeader(
              title: 'Featured',
              onMorePressed: () {},
              isDarkTheme: themeProvider.isDarkTheme,
            ),
            const SizedBox(height: 20),
            HorizontalCardCarousel(
              items: [
                {
                  'title': 'Custom Title 1',
                  'description': 'Custom description for card 1.',
                },
                {
                  'title': 'Custom Title 2',
                  'description': 'Custom description for card 2.',
                },
                {
                  'title': 'Custom Title 3',
                  'description': 'Custom description for card 3.',
                },
              ],
              cardWidth: 300,
              cardHeight: 300,
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            SizedBox(height: 50),
            SectionHeader(
              title: 'Learn',
              onMorePressed: () {},
              isDarkTheme: themeProvider.isDarkTheme,
            ),
            const SizedBox(height: 20),
            HorizontalCardCarousel(
              items: [
                {
                  'title': 'Card Title 1',
                  'description': 'Card description for card 1.',
                },
                {
                  'title': 'Card Title 2',
                  'description': 'Card description for card 2.',
                },
                {
                  'title': 'Card Title 3',
                  'description': 'Card description for card 3.',
                },
              ],
              cardWidth: 300,
              cardHeight: 300,
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            SizedBox(height: 50),
            Container(
              color: themeProvider.isDarkTheme ? Colors.white : Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLink(
                      "Privacy Policy", "https://yourdomain.com/privacy", 12),
                  const SizedBox(width: 16),
                  _buildLink(
                      "Terms of Service", "https://yourdomain.com/terms", 12),
                  const SizedBox(width: 16),
                  Text(
                    "© 2025 Your Company",
                    style: TextStyle(
                      fontSize: 12,
                      color: themeProvider.isDarkTheme
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ],
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

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onMorePressed;
  final bool isDarkTheme;

  const SectionHeader({
    Key? key,
    required this.title,
    required this.onMorePressed,
    required this.isDarkTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: isDarkTheme ? Colors.black : Colors.white,
            ),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: onMorePressed,
            child: Text(
              'More',
              style: TextStyle(
                fontSize: 16,
                color: isDarkTheme ? Colors.black : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HorizontalCardCarousel extends StatefulWidget {
  final List<Map<String, String>>
      items; // Added data structure to store item context
  final double cardWidth;
  final double cardHeight;
  final EdgeInsetsGeometry padding;

  const HorizontalCardCarousel({
    Key? key,
    required this.items, // Updated constructor to accept items
    required this.cardWidth,
    required this.cardHeight,
    required this.padding,
  }) : super(key: key);

  @override
  _HorizontalCardCarouselState createState() => _HorizontalCardCarouselState();
}

class _HorizontalCardCarouselState extends State<HorizontalCardCarousel> {
  final ScrollController _scrollController = ScrollController();
  bool _showButtons = false;
  final Map<int, double> _cardElevations = {}; // Store elevation for each card

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _showButtons = true),
      onExit: (_) => setState(() => _showButtons = false),
      child: Stack(
        children: [
          Row(
            children: [
              AnimatedOpacity(
                opacity: _showButtons ? 1.0 : 0.0,
                duration: Duration(milliseconds: 300),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    _scrollController.animateTo(
                      _scrollController.offset - widget.cardWidth,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onPanUpdate: (details) {
                    _scrollController.jumpTo(
                      _scrollController.offset - details.delta.dx,
                    );
                  },
                  child: SizedBox(
                    height: widget.cardHeight,
                    child: ListView.separated(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      padding: widget.padding,
                      itemCount: widget.items.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final item = widget.items[index];
                        final cardElevation = _cardElevations[index] ??
                            0.5; // Get elevation for the card

                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onEnter: (_) =>
                              setState(() => _cardElevations[index] = 4),
                          onExit: (_) =>
                              setState(() => _cardElevations[index] = 0.5),
                          child: GestureDetector(
                            onTap: () {
                              // Handle card click
                              print('Card ${index + 1} clicked');
                            },
                            child: Card(
                              elevation: cardElevation, // Use stored elevation
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Container(
                                width: widget.cardWidth,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white,
                                  boxShadow: [
                                    if (cardElevation > 0)
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 90,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        Icons.book,
                                        size: 48,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      item['title'] ?? 'Default Title',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      item['description'] ??
                                          'Default Description',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: _showButtons ? 1.0 : 0.0,
                duration: Duration(milliseconds: 300),
                child: IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    _scrollController.animateTo(
                      _scrollController.offset + widget.cardWidth,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
