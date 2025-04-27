import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({Key? key, required this.isDarkTheme}) : super(key: key);

  final ValueNotifier<bool> isDarkTheme;

  @override
  _HomeSectionState createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _textAnimation;
  late Animation<Offset> _logoAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _textAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _logoAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSizeTitle = screenWidth > 600 ? 54.0 : 32.0;
    final fontSizeSubtitle = screenWidth > 600 ? 16.0 : 12.0;
    final buttonFontSize = screenWidth > 600 ? 32.0 : 20.0;

    return AnimatedBuilder(
      animation: widget.isDarkTheme,
      builder: (context, child) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width,
          color: widget.isDarkTheme.value ? Colors.white : Colors.black,
          // padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: SlideTransition(
                    position: _textAnimation,
                    child: _buildTextSection(
                        fontSizeTitle, fontSizeSubtitle, buttonFontSize),
                  ),
                ),
                const SizedBox(height: 20),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SlideTransition(
                      position: _logoAnimation,
                      child: _buildLogo(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'assets/bravo.png',
      fit: BoxFit.contain,
    );
  }

  Widget _buildTextSection(
      double fontSizeTitle, double fontSizeSubtitle, double buttonFontSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'From Learning to Mastery. Start Your Journey Today',
          style: TextStyle(
            fontSize: fontSizeTitle,
            fontWeight: FontWeight.bold,
            color: widget.isDarkTheme.value ? Colors.black : Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'DIGILEARN empowers you to explore science deeply and apply your knowledge with confidence. Join us to learn, practice, and achieve your academic goals.',
          style: TextStyle(
            fontSize: fontSizeSubtitle,
            color: widget.isDarkTheme.value ? Colors.black : Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: BorderSide.none,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            backgroundColor:
                widget.isDarkTheme.value ? Colors.black : Colors.white,
            foregroundColor:
                widget.isDarkTheme.value ? Colors.white : Colors.black,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Create Account',
                style: TextStyle(fontSize: buttonFontSize),
              ),
            ],
          ),
        )
      ],
    );
  }
}
