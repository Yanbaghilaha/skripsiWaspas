import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:spk_app/home_screen.dart';

import 'package:spk_app/material/colors.dart';

class LoadingScreen2 extends StatefulWidget {
  const LoadingScreen2({super.key});

  @override
  State<LoadingScreen2> createState() => _LoadingScreen2State();
}

class _LoadingScreen2State extends State<LoadingScreen2> {
  bool _isLoading = true;
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _isLoading = false;
      });
    });
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(
              milliseconds: 500,
            ),
            transitionBuilder: (child, animation) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, -.02),
                  end: const Offset(0.0, 0.0),
                ).animate(animation),
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            },
            child: _isLoading
                ? Align(
                    alignment: Alignment.center,
                    key: const ValueKey(1),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 300,
                            // height: 100,
                            child: Lottie.asset(
                                'assets/animation/animation-upload.json',
                                fit: BoxFit.cover),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Loading...",
                            style: GoogleFonts.lato(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Align(
                    alignment: Alignment.center,
                    key: const ValueKey(2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(null),
                        Column(
                          children: [
                            Lottie.asset(
                              'assets/animation/checklist.json',
                            ),
                            Text(
                              "Success Terkirim...",
                              style: GoogleFonts.lato(
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 30),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 20,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.orange,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Menu Utama",
                                    style: GoogleFonts.lato(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.blue),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
