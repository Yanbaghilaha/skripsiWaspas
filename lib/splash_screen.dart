import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:spk_app/controller/auth_page.dart';
import 'package:spk_app/pageview/splash1.dart';
import 'package:spk_app/pageview/splash2.dart';
import 'package:spk_app/pageview/splash3.dart';

import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final controller = PageController();

  bool isPageLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                isPageLast = (index == 2);
              });
            },
            children: const [
              Splash1(),
              Splash2(),
              Splash3(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.9),
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: const SlideEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    activeDotColor: Colors.white,
                  ),
                ),

                //button
                isPageLast
                    ? TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const AuthPage();
                              },
                            ),
                          );
                        },
                        child: Container(
                          width: 198,
                          height: 49,
                          decoration: BoxDecoration(
                            color: const Color(0xff5F5DCC),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Masuk Yuk",
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          controller.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        },
                        child: Container(
                          width: 198,
                          height: 49,
                          decoration: BoxDecoration(
                            color: const Color(0xff5F5DCC),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Selanjutnya",
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Icon(
                                  IconlyLight.arrow_right,
                                  size: 24,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
