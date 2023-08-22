import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

import '../extract_widget/text_field2.dart';
import '../material/colors.dart';

class LihatJudul extends StatelessWidget {
  const LihatJudul({super.key});

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
                      size: 24,
                    ),
                  ),
                  SizedBox(
                    child: Center(
                      child: Text(
                        "Riwayat Judul",
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
              const SizedBox(
                height: 20,
              ),

              //status
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //status text
                    Text(
                      "Status",
                      style: GoogleFonts.lato(
                        color: AppColors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    //status text end

                    //statusType
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.red,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        child: Text(
                          "Ditolak",
                          style: GoogleFonts.lato(
                            color: AppColors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    //statusType End
                  ],
                ),
              ),
              //status end

              const SizedBox(
                height: 30,
              ),

              //Pick Tema skripsi\
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //status text
                    Text(
                      "Tema yang dipiliih:",
                      style: GoogleFonts.lato(
                        color: AppColors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 30),
                        child: Text(
                          "Sispak",
                          style: GoogleFonts.lato(
                            color: AppColors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //End Pick TEma skripsi

              const SizedBox(
                height: 30,
              ),
              //deskripsi judul
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //status text
                    Text(
                      "Judul & Deksripsi",
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
                      myText: "Sistem Pendukung Keputusan",
                      labelText: "",
                      readOnly: false,
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const MyTextField2(
                      myText: "Sistem Pendukung Keputusan",
                      labelText: "",
                      readOnly: false,
                      maxLines: 5,
                    ),
                  ],
                ),
              ),
              //end deskripsi judul
            ],
          ),
        ),
      ),
    );
  }
}
