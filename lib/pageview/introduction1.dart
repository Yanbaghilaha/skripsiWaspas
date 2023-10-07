import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../material/colors.dart';

class ScreenIntro extends StatelessWidget {
  const ScreenIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Container(
          padding: const EdgeInsets.only(left: 20, top: 40, right: 20),
          decoration: BoxDecoration(
            color: AppColors.orange,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset('assets/intro1.png'),
        ),

        const SizedBox(
          height: 30,
        ),
        // Title
        Text(
          "Bagaimana Cara Kerjanya?",
          style: GoogleFonts.lato(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        // subtitle
        Text(
          "Kamu akan diberi beberapa pertanyaan skala opini kuesioner seputar Tema Skripsi yang berada di STIKOM Poltek Cirebon, yang nantinya akan digenerate oleh sistem",
          style: GoogleFonts.lato(
            color: Colors.white70,
            fontSize: 22,
            fontWeight: FontWeight.w500,
            height: 1.8,
          ),
          textAlign: TextAlign.justify,
        ),
      ]),
    );
  }
}
