import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:korean_bubble_tea/pages/intro_pagetwo.dart';

class IntroPage1 extends StatefulWidget {
  const IntroPage1({super.key});

  @override
  State<IntroPage1> createState() => _IntroPage1State();
}

class _IntroPage1State extends State<IntroPage1>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  bool showText = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward().whenComplete(() {
        setState(() {
          showText = true;
        });
      });

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const IntroPage2()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Fullscreen Background Image with Fade Animation
          AnimatedBuilder(
            animation: _fadeAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeAnimation.value,
                child: Image.asset(
                  'assets/buchi3.JPG', // Replace with your image path
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
          // Overlay content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (showText)
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Chief Onyebuchi, Nwoke Oma’m\n'
                          'The Smart and Mighty, My Big Spender.\n'
                          'My Sweet Potato',
                          textStyle: GoogleFonts.allura(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.5,
                          ),
                          speed: const Duration(milliseconds: 100),
                          textAlign: TextAlign.center,
                        ),
                      ],
                      isRepeatingAnimation: false,
                      onFinished: () {
                        // Navigate to the next page when the animation finishes
                        _navigateToNextPage();
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
