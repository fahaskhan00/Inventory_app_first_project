
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          /// TOP WAVE DESIGN
          Positioned(
            top: -120,
            left: -50,
            child: Container(
              height: 320,
              width: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFFFFA726), Color(0xFFFF6F00)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),

          Positioned(
            top: -160,
            right: -80,
            child: Container(
              height: 280,
              width: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange.withOpacity(0.15),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                /// SKIP BUTTON
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () async {
                          await saveIntroStatus();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "SKIP",
                          style: TextStyle(
                            color: Color(0xFFFF6F00),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                /// PAGE VIEW
                Expanded(
                  child: PageView.builder(
                    controller: controller,
                    itemCount: pages.length,
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /// IMAGE CARD
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(35),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.orange.withOpacity(0.15),
                                    blurRadius: 30,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                pages[index]["image"]!,
                                height: 260,
                              ),
                            ),

                            const SizedBox(height: 50),

                            /// TITLE
                            Text(
                              pages[index]["title"]!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),

                            const SizedBox(height: 16),

                            /// DESCRIPTION
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Text(
                                pages[index]["desc"]!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 1.6,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                /// INDICATORS
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    pages.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.all(5),
                      width: currentIndex == index ? 28 : 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color:
                            currentIndex == index
                                ? Color(0xFFFF6F00)
                                : Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                /// BUTTON
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (currentIndex == pages.length - 1) {
                          await saveIntroStatus();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        } else {
                          controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        shadowColor: Colors.orange.withOpacity(0.4),
                        backgroundColor: const Color(0xFFFF6F00),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: Text(
                        currentIndex == pages.length - 1
                            ? "Get Started"
                            : "Next",
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
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
