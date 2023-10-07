import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:spk_app/loading_screen/loading_screen.dart';
import 'package:spk_app/material/colors.dart';

import 'package:spk_app/nilai/nilai.dart';

import 'home_screen.dart';

class NilaiDns extends StatefulWidget {
  const NilaiDns({super.key});

  @override
  State<NilaiDns> createState() => NilaiDnsState();
}

class NilaiDnsState extends State<NilaiDns> {
  final controller = PageController();

  bool isPageLast = false;

  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.violet,
                          ),
                          child: const Icon(
                            IconlyBold.home,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset('assets/nilai-dns.png'),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            "Nilai DNS",
                            style: GoogleFonts.lato(
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                                color: AppColors.orange),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: null,
                        ),
                        child: const Icon(null),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  //Avatar, Nama, & Kelas
                  SizedBox(
                    height: 580,
                    child: Expanded(
                      child: ListView(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: const Color(0xffFFB673),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Image.asset('assets/icons/avatar.png'),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Dikdik Yanbaghilaha",
                                    style: GoogleFonts.lato(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      height: 1.3,
                                    ),
                                  ),
                                  Text(
                                    "TI-3",
                                    style: GoogleFonts.lato(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      height: 1.3,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: double.infinity,
                            height: 1,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          SizedBox(
                            child: Column(
                              children: const [
                                SizedBox(
                                  height: 30,
                                ),
                                NilaiDnsList(
                                    namaMatkul: "Kriptografi", nilai: "A"),
                                SizedBox(
                                  height: 15,
                                ),
                                NilaiDnsList(
                                    namaMatkul: "Data Mining", nilai: "A"),
                                SizedBox(
                                  height: 15,
                                ),
                                NilaiDnsList(
                                    namaMatkul: "Mikrokontroler", nilai: "A"),
                                SizedBox(
                                  height: 15,
                                ),
                                NilaiDnsList(
                                    namaMatkul: "Sistem Pendukung Keputusan",
                                    nilai: "A"),
                                SizedBox(
                                  height: 15,
                                ),
                                NilaiDnsList(
                                    namaMatkul: "Sistem Pakar", nilai: "A"),
                                SizedBox(
                                  height: 15,
                                ),
                                NilaiDnsList(
                                    namaMatkul: "Jaringan", nilai: "A"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //Button
            Container(
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
                      Navigator.pop(
                        context,
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
                            "Kembali",
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
                            builder: (context) => const LoadingScreen(),
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
                              "Generate",
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
          ],
        ),
      ),
    );
  }
}
