import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

import 'package:spk_app/extract_widget/percentage_matkul.dart';
import 'package:spk_app/material/colors.dart';

import '../../daftar_judul_skripsi.dart';
import '../home_screen.dart';

class FinalConclusion extends StatelessWidget {
  const FinalConclusion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: Column(
                children: [
                  //text Congrats & Result
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Selamat!!",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        color: AppColors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Anda memiliki kemampuan yang mumpuni pada tema skripsi:",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        color: AppColors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.orange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: Text(
                        "Sistem Pendukung Keputusan",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          color: AppColors.blue,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  //end
                  const SizedBox(
                    height: 30,
                  ),
                  //percentage
                  Flexible(
                    child: ListView(
                      children: [
                        Column(
                          children: [
                            const PercentageMatkul(
                                namaMatkul: "Sistem Pendukung Keputusan",
                                percentage: "20"),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: Colors.white10,
                              width: double.maxFinite,
                              height: 1,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const PercentageMatkul(
                              namaMatkul: "Sistem Pakar",
                              percentage: "90",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: Colors.white10,
                              width: double.maxFinite,
                              height: 1,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const PercentageMatkul(
                              namaMatkul: "Mikrokontroler",
                              percentage: "90",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: Colors.white10,
                              width: double.maxFinite,
                              height: 1,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const PercentageMatkul(
                              namaMatkul: "Jaringan",
                              percentage: "90",
                            ),
                          ],
                        )
                      ],
                    ),
                  ),

                  //end percentage
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 20, top: 20),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  border: Border(
                    top: BorderSide(
                      color: Color(0xff2A3244),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.orange,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Menu",
                              style: GoogleFonts.lato(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.white),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DaftarJudulSkripsi(),
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
                            color: AppColors.violet,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Masukan Judul",
                                style: GoogleFonts.lato(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.white),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(
                                IconlyLight.arrow_right,
                                size: 24,
                                color: AppColors.white,
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
      ),
    );
  }
}
