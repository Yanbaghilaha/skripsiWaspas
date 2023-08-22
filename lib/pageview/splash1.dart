import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash1 extends StatelessWidget {
  const Splash1({super.key});

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
                color: const Color(0xffE2AF7F),
                borderRadius: BorderRadius.circular(20)),
            child: Image.asset('assets/login1.png'),
          ),
          const SizedBox(
            height: 30,
          ),

          //selamat Datang
          Text(
            "Halo, Selamat Datang",
            style: GoogleFonts.lato(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),

          const SizedBox(
            height: 10,
          ),
          //Small text
          Text(
            "Selamat datang di aplikasi Sistem Pendukung Keputusan Tema Skripsi. Aplikasi ini membantu mahasiswa dalam mengambil keputusan yang tepat dalam menentukan tema skripsi",
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
