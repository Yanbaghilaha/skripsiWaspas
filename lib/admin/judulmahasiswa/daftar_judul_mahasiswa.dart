import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

import 'package:spk_app/models/list_judul_mahasiswa.dart';

import '../../material/colors.dart';

import 'lihat_judul_mahasiswa.dart';

class DaftarJudulMahasiswa extends StatefulWidget {
  const DaftarJudulMahasiswa({super.key});

  @override
  State<DaftarJudulMahasiswa> createState() => _DaftarJudulMahasiswaState();
}

class _DaftarJudulMahasiswaState extends State<DaftarJudulMahasiswa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: Column(
            children: [
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
                      size: 28,
                    ),
                  ),
                  Text(
                    "Daftar Judul Mahasiswa",
                    style: GoogleFonts.lato(
                      color: AppColors.orange,
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                    ),
                  ),
                  const Icon(null),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LihatJudulMahasiswa(),
                      ),
                    );
                  },
                  child: ListView.separated(
                    itemCount: daftarJudulMahasiswa.length,
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
                          border: Border.all(width: 1, color: Colors.white30),
                        ),
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
                                    daftarJudulMahasiswa[index].tema,
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
                                daftarJudulMahasiswa[index].namaMahasiswa,
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
            ],
          ),
        ),
      ),
    );
  }
}
