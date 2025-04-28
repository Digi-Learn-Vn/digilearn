import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ExploreSection extends StatefulWidget {
  final ValueNotifier<bool> isDarkTheme;
  const ExploreSection({Key? key, required this.isDarkTheme}) : super(key: key);

  @override
  _ExploreSectionState createState() => _ExploreSectionState();
}

class _ExploreSectionState extends State<ExploreSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: -20).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSizeTitle = screenWidth > 600 ? 48.0 : 32.0;
    final fontSizeSubtitle = screenWidth > 600 ? 18.0 : 14.0;
    final cardWidth = screenWidth > 900 ? 280.0 : 220.0;
    final cardPadding = screenWidth > 900 ? 32.0 : 16.0;
    final isWide = screenWidth > 900;
    final isSmallScreen = screenWidth <= 600; // Define small screen threshold

    return SingleChildScrollView(
      // Wrap the entire content in a scrollable view
      child: Container(
        width: double.infinity,
        color: widget.isDarkTheme.value
            ? Colors.white
            : Colors.black, // light background
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _animation.value),
                          child: child,
                        );
                      },
                      child: Image(
                        image: AssetImage('assets/book.png'),
                        height: screenWidth > 600
                            ? 200
                            : 150, // Adjust height based on screen width
                        width: screenWidth > 600
                            ? 200
                            : 150, // Adjust width based on screen width
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              'Our Happy Journey',
              style: TextStyle(
                fontSize: fontSizeTitle,
                fontWeight: FontWeight.bold,
                color: widget.isDarkTheme.value ? Colors.black : Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'In every formula, every experiment, every discovery — you are finding a new piece of yourself.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSizeSubtitle,
                  color: widget.isDarkTheme.value
                      ? Colors.grey[600]
                      : Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 16),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () async {
                  final url = Uri.parse('https://enterprise.example.com');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Get Started",
                      style: TextStyle(
                        fontSize: 16,
                        color: widget.isDarkTheme.value
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: widget.isDarkTheme.value
                          ? Colors.black
                          : Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: isSmallScreen ? 32 : 80),
            // Cards row or column based on screen size
            Container(
              child: isSmallScreen
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSubjectCard(
                          context,
                          icon: 'assets/math.png',
                          title: 'Mathematics',
                          description:
                              'Explore mathematical concepts, exercises, and resources designed for all learning levels.',
                          cardWidth: cardWidth,
                          cardPadding: cardPadding,
                          accent: Colors.deepPurpleAccent,
                        ),
                        const SizedBox(height: 32),
                        _buildSubjectCard(
                          context,
                          icon: 'assets/physics.png',
                          title: 'Physics',
                          description:
                              'Dive into physics principles, exercises, experiments, and theoretical foundations.',
                          cardWidth: cardWidth,
                          cardPadding: cardPadding,
                          accent: Colors.orangeAccent,
                        ),
                        const SizedBox(height: 32),
                        _buildSubjectCard(
                          context,
                          icon: 'assets/chemistry.png',
                          title: 'Chemistry',
                          description:
                              'Access chemistry lessons, theory explorations, and homework help.',
                          cardWidth: cardWidth,
                          cardPadding: cardPadding,
                          accent: Colors.cyan,
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSubjectCard(
                          context,
                          icon: 'assets/math.png',
                          title: 'Mathematics',
                          description:
                              'Explore mathematical concepts, exercises, and resources designed for all learning levels.',
                          cardWidth: cardWidth,
                          cardPadding: cardPadding,
                          accent: Colors.deepPurpleAccent,
                        ),
                        SizedBox(width: isWide ? 32 : 16),
                        _buildSubjectCard(
                          context,
                          icon: 'assets/physics.png',
                          title: 'Physics',
                          description:
                              'Dive into physics principles, exercises, experiments, and theoretical foundations.',
                          cardWidth: cardWidth,
                          cardPadding: cardPadding,
                          accent: Colors.orangeAccent,
                        ),
                        SizedBox(width: isWide ? 32 : 16),
                        _buildSubjectCard(
                          context,
                          icon: 'assets/chemistry.png',
                          title: 'Chemistry',
                          description:
                              'Access chemistry lessons, theory explorations, and homework help.',
                          cardWidth: cardWidth,
                          cardPadding: cardPadding,
                          accent: Colors.cyan,
                        ),
                      ],
                    ),
            ),
            SizedBox(height: isSmallScreen ? 32 : 90),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectCard(BuildContext context,
      {required String icon,
      required String title,
      required String description,
      required double cardWidth,
      required double cardPadding,
      required Color accent}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageSize = screenWidth > 600 ? 150.0 : 100.0;
    final imageOffset = screenWidth > 600 ? -75.0 : -30.0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: cardWidth,
          padding: EdgeInsets.all(cardPadding),
          decoration: BoxDecoration(
            color: widget.isDarkTheme.value
                ? const Color.fromARGB(255, 243, 241, 248)
                : const Color.fromARGB(255, 55, 55, 55),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: widget.isDarkTheme.value ? Colors.white : Colors.black,
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: Icon(Icons.star, color: accent, size: 18),
              ),
              const SizedBox(height: 24),
              Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: widget.isDarkTheme.value ? Colors.black : Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: widget.isDarkTheme.value ? Colors.black : Colors.white,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: imageOffset, // Adjust dynamically based on screen size
          left: (cardWidth - imageSize) / 2, // Center the image horizontally
          child: Image.asset(icon, height: imageSize, width: imageSize),
        ),
      ],
    );
  }
}
