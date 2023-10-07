import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:spk_app/extract_widget/top_navbar.dart';
import 'package:spk_app/material/colors.dart';

import 'judul_screen/masukan_judul.dart';

class TentangJudulData {
  final String tema, deskripsi, judul, ulasan, deskripsiUlasan;
  final Timestamp waktu;
  String? key;

  TentangJudulData({
    required this.waktu,
    required this.ulasan,
    required this.deskripsiUlasan,
    required this.tema,
    required this.deskripsi,
    required this.judul,
  });

  factory TentangJudulData.fromJson(Map<String, dynamic> json) {
    return TentangJudulData(
      ulasan: json['ulasan'] ?? '',
      tema: json['tema'] ?? '',
      deskripsi: json['deskripsi'] ?? '',
      judul: json['judul'] ?? '',
      deskripsiUlasan: json['deskripsiUlasan'] ?? 'Belum Diulas',
      waktu: json['waktu'] ?? '',
    );
  }
}

class DaftarTemaSkripsiScreen extends StatefulWidget {
  const DaftarTemaSkripsiScreen({super.key});

  @override
  _DaftarTemaSkripsiScreenState createState() =>
      _DaftarTemaSkripsiScreenState();
}

class _DaftarTemaSkripsiScreenState extends State<DaftarTemaSkripsiScreen> {
  Future<List<TentangJudulData>> _getDaftarTemaSkripsi() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final activeUserEmail = user.email ?? "";
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(activeUserEmail);
      final docSnapshot = await userDoc.get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        final daftarTemaSkripsi = <TentangJudulData>[];

        // Iterasi melalui data tentangJudul
        data.forEach(
          (key, value) {
            if (key.startsWith('tentangJudul-')) {
              final temaSkripsi = TentangJudulData.fromJson(value);
              temaSkripsi.key = key;
              daftarTemaSkripsi.add(temaSkripsi);
            }
          },
        );

        // Mengurutkan daftar tema skripsi berdasarkan kunci
        daftarTemaSkripsi.sort((a, b) {
          final regex = RegExp(r'tentangJudul-(\d+)');
          final matchA = regex.firstMatch(a.key!);
          final matchB = regex.firstMatch(b.key!);
          if (matchA != null && matchB != null) {
            final nomorA = int.parse(matchA.group(1)!);
            final nomorB = int.parse(matchB.group(1)!);
            return nomorA.compareTo(nomorB);
          }
          return 0;
        });

        return daftarTemaSkripsi;
      }
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 30,
            horizontal: 10,
          ),
          child: FutureBuilder<List<TentangJudulData>>(
            future: _getDaftarTemaSkripsi(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Error fetching data"),
                );
              } else if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                final daftarJudul = snapshot.data!;

                return Stack(
                  children: [
                    Column(
                      children: [
                        const MyNavBar(judul: "Daftar Judul Kamu"),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 590,
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              final tentangJudulData = daftarJudul[index];
                              final DateTime dateTime =
                                  tentangJudulData.waktu.toDate();

                              String formatDate =
                                  DateFormat.yMMMd('en_us').format(dateTime);
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.whiteLight,
                                  border: Border.all(
                                    width: 2,
                                    color: AppColors.border,
                                  ),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
                                    vertical: 20,
                                    horizontal: 20,
                                  ),
                                  child: ExpansionTile(
                                    iconColor: AppColors.white,
                                    collapsedIconColor: AppColors.border,
                                    tilePadding: EdgeInsets.zero,
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${index + 1}",
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.lato(
                                            color: AppColors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 1,
                                                        horizontal: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: AppColors.orange,
                                                ),
                                                child: Text(
                                                  formatDate.toString(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.lato(
                                                    color: AppColors.primary,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                              Text(
                                                tentangJudulData.judul,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.lato(
                                                  color: AppColors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: AppColors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 10,
                                                        horizontal: 10,
                                                      ),
                                                      child: Text(
                                                        tentangJudulData.tema,
                                                        style: GoogleFonts.lato(
                                                          color:
                                                              AppColors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    width: 2,
                                                    height: 20,
                                                    color: AppColors.border,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: tentangJudulData
                                                                  .ulasan ==
                                                              "Belum Diulas"
                                                          ? AppColors.border
                                                          : tentangJudulData
                                                                      .ulasan ==
                                                                  "Diterima"
                                                              ? AppColors.green
                                                              : AppColors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 10,
                                                        horizontal: 10,
                                                      ),
                                                      child: Text(
                                                        tentangJudulData.ulasan,
                                                        style: GoogleFonts.lato(
                                                          color:
                                                              AppColors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    expandedAlignment: Alignment.centerLeft,
                                    children: [
                                      const SizedBox(
                                        height: 30,
                                      ),

                                      //Judul
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            width: 2,
                                            color: AppColors.border,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Judul",
                                                style: GoogleFonts.lato(
                                                  color: AppColors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: 1,
                                                color: AppColors.border,
                                              ),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                              Text(
                                                tentangJudulData.judul,
                                                style: GoogleFonts.lato(
                                                  color: AppColors.white,
                                                  fontSize: 18,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            width: 2,
                                            color: AppColors.border,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Deskripsi",
                                                style: GoogleFonts.lato(
                                                  color: AppColors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: 1,
                                                color: AppColors.border,
                                              ),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                              Text(
                                                tentangJudulData.deskripsi,
                                                style: GoogleFonts.lato(
                                                  color: AppColors.white,
                                                  fontSize: 18,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      //deskripsi Ulasan
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            width: 2,
                                            color: AppColors.border,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Deskripsi Ulasan",
                                                style: GoogleFonts.lato(
                                                  color: AppColors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: 1,
                                                color: AppColors.border,
                                              ),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                              Text(
                                                tentangJudulData
                                                    .deskripsiUlasan,
                                                style: GoogleFonts.lato(
                                                  color: tentangJudulData
                                                              .deskripsiUlasan ==
                                                          'Belum Diulas'
                                                      ? AppColors.red
                                                      : AppColors.green,
                                                  fontSize: 18,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 20,
                              );
                            },
                            itemCount: daftarJudul.length,
                          ),
                        ),
                      ],
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
                                      builder: (context) {
                                        return const MasukanJudul();
                                      },
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
                                        "Tambah Judul",
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 50,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            LottieBuilder.asset(
                              'assets/animation/no-data.json',
                              height: 300,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  Text(
                                    "Data Judul Kamu Belum ada Nih!",
                                    style: GoogleFonts.lato(
                                      color: AppColors.orange,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Masukan Yuk...",
                                    style: GoogleFonts.lato(
                                      color: AppColors.orange,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
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
                              flex: 3,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.red,
                                  ),
                                  child: const Icon(
                                    IconlyLight.arrow_left_2,
                                    color: AppColors.white,
                                    weight: 10,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 12,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const MasukanJudul();
                                      },
                                    ),
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.violet,
                                  ),
                                  child: Text(
                                    "Tambah Judul",
                                    style: GoogleFonts.lato(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
