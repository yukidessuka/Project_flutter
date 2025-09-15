import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'home_screen.dart';
import 'signin_screen.dart';

class FancyOnBoarding extends StatefulWidget {
  const FancyOnBoarding({super.key});

  @override
  State<FancyOnBoarding> createState() => _FancyOnBoardingState();
}

class _FancyOnBoardingState extends State<FancyOnBoarding>
    with TickerProviderStateMixin {
  final PageController _controller = PageController(viewportFraction: 0.8);
  int currentPage = 0;

  late AnimationController gradientController;
  late AnimationController doodleController;
  late AnimationController buttonController;

  bool showConfetti = false;

  final List<Map<String, String>> pages = [
    {
      "title": "Welcome to Galleria",
      "subtitle": "A cozy world with PomPomPurin & friends!",
      "image": "photo/pompompurin1.jpg",
    },
    {
      "title": "Explore Artworks",
      "subtitle": "Discover cute galleries made by fans.",
      "image": "photo/pompompurin2.jpg",
    },
    {
      "title": "Upload & Share",
      "subtitle": "Post your art & pudding creations!",
      "image": "photo/pompompurin3.jpg",
    },
    {
      "title": "Join Community",
      "subtitle": "Make friends and share the joy of art.",
      "image": "photo/pompompurin4.jpg",
    },
  ];

  Future<void> finishOnBoarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('ON_BOARDING', false);
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthScreen()),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    /// Gradient animation
    gradientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);

    /// Floating doodles animation
    doodleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    /// Button bounce animation
    buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
      lowerBound: 0.9,
      upperBound: 1.1,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    gradientController.dispose();
    doodleController.dispose();
    buttonController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: gradientController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.lerp(
                    const Color(0xFFFFF4D6),
                    const Color(0xFFFFD369),
                    gradientController.value,
                  )!,
                  Color.lerp(
                    const Color(0xFFFFD369),
                    const Color(0xFFFFA726),
                    gradientController.value,
                  )!,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                /// PageView + Card
                Column(
                  children: [
                    const SizedBox(height: 80),
                    Expanded(
                      child: PageView.builder(
                        controller: _controller,
                        physics: const BouncingScrollPhysics(),
                        onPageChanged: (index) =>
                            setState(() => currentPage = index),
                        itemCount: pages.length,
                        itemBuilder: (context, index) {
                          final scale = currentPage == index ? 1.0 : 0.85;
                          final page = pages[index];
                          return AnimatedScale(
                            scale: scale,
                            duration: const Duration(milliseconds: 300),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.brown.withOpacity(0.2),
                                      blurRadius: 15,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Image.asset(
                                        page["image"]!,
                                        height: 260,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      page["title"]!,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFA3774A),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: Text(
                                        page["subtitle"]!,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFF8C5E3C),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    if (currentPage == pages.length - 1)
                                      Center(
                                        child: Lottie.asset(
                                          "photo/confetti.json",
                                          repeat: false,
                                          height: 180,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    /// Dots indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        pages.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: currentPage == index ? 18 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: currentPage == index
                                ? const Color(0xFFFFD369)
                                : const Color(0xFFFFE29A),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    /// Navigation buttons (Back, Skip, Next)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// Back
                          if (currentPage > 0)
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFE29A),
                                shape: const StadiumBorder(),
                              ),
                              onPressed: () => _controller.previousPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              ),
                              child: const Text(
                                "Back",
                                style: TextStyle(color: Color(0xFFA3774A)),
                              ),
                            )
                          else
                            const SizedBox(width: 70),

                          /// Skip
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFE29A),
                              shape: const StadiumBorder(),
                            ),
                            onPressed: finishOnBoarding,
                            child: const Text(
                              "Skip",
                              style: TextStyle(color: Color(0xFFA3774A)),
                            ),
                          ),

                          /// Next / Done
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFC107),
                              shape: const StadiumBorder(),
                            ),
                            onPressed: () {
                              if (currentPage == pages.length - 1) {
                                setState(() => showConfetti = true);
                              } else {
                                _controller.nextPage(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            child: Text(
                              currentPage == pages.length - 1 ? "Done" : "Next",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),

                /// Floating doodles (Now in front of card)
                IgnorePointer(
                  child: AnimatedBuilder(
                    animation: doodleController,
                    builder: (context, child) {
                      final offset = sin(doodleController.value * 2 * pi) * 10;
                      return Stack(
                        children: [
                          Positioned(
                            left: 40,
                            top: 120 + offset,
                            child: Image.asset(
                              "photo/heart_icon.png",
                              height: 70,
                            ),
                          ),
                          Positioned(
                            right: 50,
                            top: 200 - offset,
                            child: Image.asset(
                              "photo/heart_icon.png",
                              height: 60,
                            ),
                          ),
                          Positioned(
                            left: 90,
                            bottom: 180 + offset,
                            child: Image.asset(
                              "photo/heart_icon.png",
                              height: 65,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                /// Confetti on last page -> auto navigate
                if (showConfetti)
                  Center(
                    child: Lottie.asset(
                      "photo/success.json",
                      repeat: false,
                      onLoaded: (composition) async {
                        await Future.delayed(composition.duration);
                        finishOnBoarding();
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
