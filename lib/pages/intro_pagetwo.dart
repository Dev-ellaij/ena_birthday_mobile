import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage2 extends StatefulWidget {
  const IntroPage2({super.key});

  @override
  State<IntroPage2> createState() => _IntroPage2State();
}

class _IntroPage2State extends State<IntroPage2>
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
                          'I really want to say I’m sorry for my actions,\n'
                          'and it was so unreasonable for me to do such.\n'
                          'I promise it will not happen again 🙏.\n'
                          'I love you my baby.',
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
