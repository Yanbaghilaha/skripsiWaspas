import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:spk_app/final_conclusion.dart';

import 'package:spk_app/material/colors.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 3500), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const FinalConclusion()));
    });
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/animation/loading_animation.json'),
            Text(
              "Loading...",
              style: GoogleFonts.lato(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
