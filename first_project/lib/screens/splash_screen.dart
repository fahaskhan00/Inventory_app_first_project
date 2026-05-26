import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    checkIntro();
  }

  Future<void> checkIntro() async {
    final box = Hive.box('appBox');

    final introShown = box.get('introShown') ?? false;

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,

        MaterialPageRoute(
          builder:
              (context) =>
                  introShown ? const HomeScreen() : const IntroScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: const CircularProgressIndicator(
          color: Color(0xFFFF8C42),
          strokeWidth: 3,
        ),
      ),
    );
  }
}
