import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsSection extends StatefulWidget {
  final ValueNotifier<bool> isDarkTheme;
  const AboutUsSection({Key? key, required this.isDarkTheme}) : super(key: key);

  @override
  _AboutUsSectionState createState() => _AboutUsSectionState();
}

class _AboutUsSectionState extends State<AboutUsSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth <= 600; // Define small screen threshold

    return Container(
      width: double.infinity,
      color: widget.isDarkTheme.value
          ? Colors.white
          : Colors.black, // light background
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/love.png'),
            height: screenWidth > 600
                ? 150
                : 100, // Adjust height based on screen width
            width: screenWidth > 600
                ? 150
                : 100, // Adjust width based on screen width
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 800),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'At DigiLearn, our mission is to empower you with knowledge and skills '
                'for a brighter future. We provide a rich library of educational '
                'resources across science, mathematics, and technology. Over the years, '
                'thousands of learners have grown, excelled, and unlocked new opportunities '
                'through our platform.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: widget.isDarkTheme.value
                      ? Colors.grey[600]
                      : Colors.white,
                ),
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
                    "Join Our Team",
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
                    color:
                        widget.isDarkTheme.value ? Colors.black : Colors.white,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 1000,
              ),
              child: Divider(
                color: widget.isDarkTheme.value ? Colors.black : Colors.white,
                thickness: 0.15,
              )),
          SizedBox(height: 16),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 900),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () async {
                            final url =
                                Uri.parse('https://enterprise.example.com');
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            }
                          },
                          child: Text(
                            'Open Enterprise',
                            style: TextStyle(
                              fontSize: 16,
                              color: widget.isDarkTheme.value
                                  ? Colors.black
                                  : Colors.white,
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
                              'Documentation', 'https://docs.example.com', 16),
                          Icon(Icons.remove,
                              size: 8,
                              color: widget.isDarkTheme.value
                                  ? Colors.black
                                  : Colors.white),
                          _buildLink(
                              'Github', 'https://github.com/example', 16),
                          Icon(Icons.remove,
                              size: 8,
                              color: widget.isDarkTheme.value
                                  ? Colors.black
                                  : Colors.white),
                          _buildLink(
                              'Twitter', 'https://twitter.com/example', 16),
                          Icon(Icons.remove,
                              size: 8,
                              color: widget.isDarkTheme.value
                                  ? Colors.black
                                  : Colors.white),
                          _buildLink(
                              'Contact Us', 'https://example.com/contact', 16),
                        ],
                      ),
                    ],
                  ),
                ]),
          ),
          const SizedBox(height: 16),
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
            color: widget.isDarkTheme.value ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}
