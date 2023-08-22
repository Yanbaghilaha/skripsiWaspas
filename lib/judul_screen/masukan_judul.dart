import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:spk_app/extract_widget/tema_skripsi.dart';
import 'package:spk_app/extract_widget/text_field.dart';
import 'package:spk_app/loading_screen/loading_screen_upload.dart';

import '../material/colors.dart';

class MasukanJudul extends StatefulWidget {
  const MasukanJudul({super.key});

  @override
  State<MasukanJudul> createState() => _MasukanJudulState();
}

class _MasukanJudulState extends State<MasukanJudul> {
  final TextEditingController judul = TextEditingController();
  final TextEditingController deskripsiJudul = TextEditingController();
  final List temaSkripsi = [
    [
      'SPK',
      false,
    ],
    [
      'Sispak',
      false,
    ],
    [
      'Kripto',
      false,
    ],
    [
      'Mikro',
      false,
    ],
    [
      'Data Mining',
      false,
    ],
    [
      'Jaringan',
      false,
    ],
  ];

  void temaTypeSelected(int index) {
    setState(() {
      for (int i = 0; i < temaSkripsi.length; i++) {
        temaSkripsi[i][1] = false;
      }
      temaSkripsi[index][1] = true;
    });
  }

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
                  //Judul screen
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          IconlyLight.arrow_left_2,
                          color: AppColors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(
                        child: Center(
                          child: Text(
                            "Masukan Judul Kamu",
                            style: GoogleFonts.lato(
                                fontSize: 26,
                                fontWeight: FontWeight.w900,
                                color: AppColors.orange),
                          ),
                        ),
                      ),
                      const Icon(null),
                    ],
                  ),

                  //end judul halaman
                  const SizedBox(
                    height: 20,
                  ),
                  //masukan Tema skripsi
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Masukan Tema",
                          style: GoogleFonts.lato(
                            color: AppColors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),

                        //button
                        Expanded(
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return TemaSkripsi(
                                text: temaSkripsi[index][0],
                                isSelected: temaSkripsi[index][1],
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
                            itemCount: temaSkripsi.length,
                          ),
                        )
                      ],
                    ),
                  ),
                  //end tema skripsi
                  const SizedBox(
                    height: 30,
                  ),
                  //Texfield
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
                        MyTextField(
                          onChanged: (value) {},
                          controller: judul,
                          hintText: "Masukan Judul Anda Disini...",
                          labelText: "Judul Anda...",
                          maxLines: 1,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        MyTextField(
                          onChanged: (value) {},
                          controller: deskripsiJudul,
                          hintText: "Deskripsi Judul Anda...",
                          labelText: "Dekripsi Judul Anda...",
                          maxLines: 5,
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoadingScreen2(),
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
                                "Berikan Ke Kaprodi",
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
      ),
    );
  }
}
