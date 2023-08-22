import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash3 extends StatelessWidget {
  const Splash3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10, left: 10, top: 100),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 350,
            decoration: BoxDecoration(
                color: const Color(0xffFF94C1),
                borderRadius: BorderRadius.circular(20)),
            child: Image.asset('assets/login3a.png'),
          ),
          const SizedBox(
            height: 30,
          ),

          //selamat Datang
          Text(
            "Tentukan Tema skripsi yang anda inginkan",
            style: GoogleFonts.lato(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),

          const SizedBox(
            height: 10,
          ),
          //Small text
          Text(
            "Jelajahi dan Tentukan Tema Tesis Anda dengan Bijak. dengan kuesioner yang kami berikan",
            style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                height: 1.7,
                letterSpacing: .4),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
