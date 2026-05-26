import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/intro_screen_widget/background.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_application_1/colors/app_colors.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import '../widgets/intro_screen_widget/indicator.dart';
import '../widgets/intro_screen_widget/skip_button.dart';
import '../widgets/intro_screen_widget/page_view.dart';
import '../widgets/intro_screen_widget/next_button.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  // SAVE INTRO STATUS
  Future<void> saveIntroStatus() async {
    final box = Hive.box('appBox');

    await box.put('introShown', true);
  }

  final PageController controller = PageController();

  int currentIndex = 0;

  final List<Map<String, String>> pages = [
    {
      "title": "Track Your Inventory",

      "desc": "Manage all your items in one place easily.",

      "image": "assets/images/invfirstr.png",
    },

    {
      "title": "Organize Smartly",

      "desc": "Categorize and manage items efficiently.",

      "image": "assets/images/invsecondr.png",
    },

    {
      "title": "View Sales & Stats",

      "desc": "Monitor your business growth in real-time.",

      "image": "assets/images/invthirdr.png",
    },
  ];

  // GO HOME
  Future<void> goHome() async {
    await saveIntroStatus();

    Navigator.pushReplacement(
      context,

      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  // NEXT PAGE
  void nextPage() {
    controller.nextPage(
      duration: const Duration(milliseconds: 300),

      curve: Curves.easeIn,
    );
  }

  // PAGE CHANGE
  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      body: Stack(
        children: [
          const IntroBackground(),

          SafeArea(
            child: Column(
              children: [
                SkipButton(onTap: goHome),

                Expanded(
                  child: IntroPageView(
                    controller: controller,

                    pages: pages,

                    onPageChanged: onPageChanged,
                  ),
                ),

                IntroIndicator(
                  currentIndex: currentIndex,

                  length: pages.length,
                ),

                const SizedBox(height: 35),

                IntroNextButton(
                  text:
                      currentIndex == pages.length - 1 ? "Get Started" : "Next",

                  onTap: () {
                    if (currentIndex == pages.length - 1) {
                      goHome();
                    } else {
                      nextPage();
                    }
                  },
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
