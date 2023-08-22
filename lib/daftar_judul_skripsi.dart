import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:spk_app/judul_screen/lihat_judul.dart';
import 'package:spk_app/material/colors.dart';
import 'package:spk_app/models/list_judul.dart';

import 'judul_screen/masukan_judul.dart';

class DaftarJudulSkripsi extends StatelessWidget {
  const DaftarJudulSkripsi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: Column(
            children: [
              //judul Halaman
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
                        "Daftar Judul Kamu",
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
              //List
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LihatJudul(),
                      ),
                    );
                  },
                  child: ListView.separated(
                    itemCount: daftarJudulSkripsi.length,
                    separatorBuilder: (context, index) {
                      return Container(
                        height: 16,
                      );
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            color: const Color(0xff282B34),
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(width: 1, color: Colors.white30)),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 60,
                              decoration: BoxDecoration(
                                color: AppColors.blue,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Center(
                                  child: Text(
                                    daftarJudulSkripsi[index].tema,
                                    style: GoogleFonts.lato(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 280,
                              child: Text(
                                daftarJudulSkripsi[index].judul,
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.white,
                                  fontSize: 18,
                                ),
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Icon(
                              IconlyLight.arrow_right_2,
                              color: AppColors.white,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              //EndList
              const SizedBox(
                height: 20,
              ),
              //add button
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MasukanJudul(),
                    ),
                  );
                },
                child: DottedBorder(
                  color: AppColors.blue,
                  dashPattern: const [12],
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          PhosphorIcons.plus,
                          size: 24,
                          color: AppColors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Tambah Juduls",
                          style: GoogleFonts.lato(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              )

              //end add button
            ],
          ),
        ),
      ),
    );
  }
}
