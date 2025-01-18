import 'package:flutter/material.dart';

import 'pages/onboarding_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        sliderTheme: SliderThemeData(
          activeTrackColor: Colors.brown,
          inactiveTrackColor: Colors.brown[100],
          thumbColor: Colors.brown,
          overlayColor: Colors.brown.withOpacity(0.2),
        ),
      ),
      home: const OnboardingPage(), // Initial page
    );
  }
}
