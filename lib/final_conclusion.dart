import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:spk_app/daftar_judul_skripsi.dart';

import 'package:spk_app/extract_widget/percentage_matkul.dart';
import 'package:spk_app/loading_screen/loading_screen.dart';
import 'package:spk_app/material/colors.dart';

class FinalConclusion extends StatefulWidget {
  final List<String> alternatif;
  final List<double> totalWeightedSumColumn;
  const FinalConclusion({
    super.key,
    required this.alternatif,
    required this.totalWeightedSumColumn,
  });

  @override
  State<FinalConclusion> createState() => _FinalConclusionState();
}

class _FinalConclusionState extends State<FinalConclusion> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> sortedAlternatif = [];

    for (int i = 0; i < widget.alternatif.length; i++) {
      sortedAlternatif.add({
        'alternatif': widget.alternatif[i],
        'totalWeightedSum': widget.totalWeightedSumColumn[i]
      });
    }
    sortedAlternatif.sort(
      (a, b) => b['totalWeightedSum'].compareTo(
        a['totalWeightedSum'],
      ),
    );

    return Scaffold(
      body: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 1)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen(); // Tampilkan halaman loading
          } else if (snapshot.connectionState == ConnectionState.done) {
            // Setelah loading selesai, tampilkan tampilan utama
            return SafeArea(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 10),
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
                              sortedAlternatif[0]['alternatif'].toString(),
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
                          child: ListView.separated(
                            itemCount: sortedAlternatif.length,
                            separatorBuilder: (context, index) {
                              return Container(
                                color: Colors.white10,
                                width: double.infinity,
                                height: 1,
                              );
                            },
                            itemBuilder: (context, index) {
                              return PercentageMatkul(
                                namaMatkul: sortedAlternatif[index]
                                    ['alternatif'],
                                percentage: sortedAlternatif[index]
                                        ['totalWeightedSum']
                                    .toStringAsFixed(2),
                                lengthPercent: sortedAlternatif[index]
                                    ['totalWeightedSum'] as double,
                              );
                            },
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
                              Navigator.popUntil(
                                context,
                                (route) {
                                  return route.isFirst;
                                },
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
                                    builder: (context) =>
                                        const DaftarTemaSkripsiScreen(),
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
            );
          } else {
            return Container(); // Penanganan jika terjadi kesalahan
          }
        },
      ),
    );
  }
}
