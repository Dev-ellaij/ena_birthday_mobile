import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage3 extends StatefulWidget {
  const IntroPage3({super.key});

  @override
  State<IntroPage3> createState() => _IntroPage3State();
}

class _IntroPage3State extends State<IntroPage3>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool showText = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward().whenComplete(showHappyBirthdayText);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void showHappyBirthdayText() {
    setState(() {
      showText = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Fullscreen Background Image
          Image.asset(
            'assets/images/birthday_image.png', // Replace with your image path
            fit: BoxFit.cover, // Ensures the image covers the whole screen
          ),
          // Text Overlay
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (showText) ...[
                  Transform.translate(
                    offset: const Offset(0, -20),
                    child: Text(
                      'Chief Onyebuchi, Nwoke Oma’m\n'
                      'The Smart and Mighty, My Big Spender.\n'
                      'My Sweet Potato',
                      style: GoogleFonts.allura(
                        fontSize: 40,
                        color: Colors.white,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  AnimatedOpacity(
                    opacity: showText ? 1.0 : 0.0,
                    duration: const Duration(seconds: 2),
                    child: Text(
                      'I really want to say I’m sorry for my actions,\n'
                      'and it was so unreasonable for me to do such.\n'
                      'I promise it will not happen again 🙏.\n'
                      'I love you my baby.',
                      style: GoogleFonts.allura(
                        fontSize: 24,
                        color: Colors.white,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
