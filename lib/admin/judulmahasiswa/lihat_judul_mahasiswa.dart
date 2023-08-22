// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spk_app/extract_widget/text_field2.dart';
import 'package:spk_app/extract_widget/top_navbar.dart';

import '../../extract_widget/tema_skripsi.dart';
import '../../material/colors.dart';

class LihatJudulMahasiswa extends StatefulWidget {
  const LihatJudulMahasiswa({super.key});

  @override
  State<LihatJudulMahasiswa> createState() => _LihatJudulMahasiswaState();
}

class _LihatJudulMahasiswaState extends State<LihatJudulMahasiswa> {
  final List temaSkripsi = [
    ['SPK', false],
    ['Sispak', false],
    ['Kripto', false],
    ['Mikro', false],
    ['Data Mining', false],
    ['Jaringan', false],
  ];
  final List ulaskan = [
    ['Tolak', false],
    ['Terima', false],
  ];
  void temaTypeSelected(int index) {
    setState(() {
      for (int i = 0; i < ulaskan.length; i++) {
        ulaskan[i][1] = false;
      }
      ulaskan[index][1] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 10,
            ),
            child: Column(
              children: [
                const MyNavBar(judul: "Dikdik Yanbaghilaha"),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tema Yang Dipilih",
                        style: GoogleFonts.lato(
                          color: AppColors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Expanded(
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return TemaSkripsi(
                              text: temaSkripsi[index][0],
                              isSelected: temaSkripsi[index][1],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 10,
                            );
                          },
                          itemCount: temaSkripsi.length,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Input Deskripsi Judul",
                        style: GoogleFonts.lato(
                          color: AppColors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const MyTextField2(
                        readOnly: true,
                        labelText: "Judul Anda",
                        myText:
                            "Sistem Pendukun Keputusan Dalam Menentukan Tema Skrpisi",
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const MyTextField2(
                        readOnly: true,
                        labelText: "Deskripsi Judul Anda",
                        myText: "Contoh ini adlaah lorem ipsum apalah",
                        maxLines: 5,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ulaskan",
                        style: GoogleFonts.lato(
                          color: AppColors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Expanded(
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return TemaSkripsi(
                              text: ulaskan[index][0],
                              isSelected: ulaskan[index][1],
                              onTap: () {
                                temaTypeSelected(index);
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 10,
                            );
                          },
                          itemCount: ulaskan.length,
                        ),
                      ),
                    ],
                  ),
                ),
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
                  const SizedBox(
                    height: 30,
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: TextButton(
                      onPressed: () async {},
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
                              "Ulaskan",
                              style: GoogleFonts.lato(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.white),
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
          )
        ],
      ),
    ));
  }
}
