import 'package:flutter/material.dart';
import 'dart:async'; // For Timer
import 'home_screen.dart'; // Make sure this is the correct path to your home screen

class SplashScreen extends StatefulWidget {
  // هذه الخصائص ليست ضرورية للشاشة الابتدائية إذا كنت تستخدمها فقط للانتقال
  // ولكن بما أنك مررتها في main.dart، فلنعدلها لتستقبلها.
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const SplashScreen({super.key, required this.isDarkMode, required this.onThemeChanged});


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Start a timer for 3 seconds
    Timer(const Duration(seconds: 3), () {
      // Navigate to the HomeScreen after the splash screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            isDarkMode: widget.isDarkMode,
            onThemeChanged: widget.onThemeChanged,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Or your preferred background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/app_icon.png', // Make sure this path is correct in pubspec.yaml
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            // إذا كنت تريد نصًا هنا، يمكنك إضافته وترجمته
            // Text('app_title'.tr(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const CircularProgressIndicator(), // Loading indicator
          ],
        ),
      ),
    );
  }
}