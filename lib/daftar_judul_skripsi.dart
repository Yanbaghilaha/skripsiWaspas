import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:spk_app/extract_widget/top_navbar.dart';
import 'package:spk_app/material/colors.dart';

import 'extract_widget/text_field.dart';
import 'judul_screen/masukan_judul.dart';

class TentangJudulData {
  final String judul, nama;
  final String tema;
  final String deskripsi;

  TentangJudulData({
    required this.judul,
    required this.tema,
    required this.nama,
    required this.deskripsi,
  });

  factory TentangJudulData.fromJson(Map<String, dynamic> json) {
    return TentangJudulData(
      nama: json['nama'] ?? "",
      judul: json['judul'] ?? "",
      tema: json['tema'] ?? "",
      deskripsi: json['deskripsi'] ?? "",
    );
  }
}

class DaftarJudulSkripsi extends StatefulWidget {
  const DaftarJudulSkripsi({Key? key}) : super(key: key);

  @override
  _DaftarJudulSkripsiState createState() => _DaftarJudulSkripsiState();
}

class _DaftarJudulSkripsiState extends State<DaftarJudulSkripsi> {
  TentangJudulData? tentangJudulData;
  String activeUserEmail = "";
  String activeUserName = "";
  String tentangJudul = "";

  @override
  void initState() {
    super.initState();
    _getTentangJudulData();
    _getActiveUserEmail();
  }

  void _getActiveUserEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        activeUserEmail = user.email ?? "";
        activeUserName = user.displayName ?? "";
      });
    }
    print(activeUserEmail);
    print(activeUserName);
  }

  void _getTentangJudulData() async {
    if (activeUserEmail.isNotEmpty) {
      final userDoc = FirebaseFirestore.instance
          .collection('kriteria')
          .doc('14519930@gmail.com');
      final docSnapshot = await userDoc.get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        final tentangJudulDataMap = data?['tentangJudul'];

        if (tentangJudulDataMap != null) {
          setState(() {
            tentangJudulData = TentangJudulData.fromJson(tentangJudulDataMap);
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<TentangJudulData?> _getTentangJudulData() async {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final activeUserEmail = user.email ?? "";
        final userDoc =
            FirebaseFirestore.instance.collection('users').doc(activeUserEmail);
        final docSnapshot = await userDoc.get();

        if (docSnapshot.exists) {
          final data = docSnapshot.data();
          final tentangJudulDataMap = data?['tentangJudul'];

          if (tentangJudulDataMap != null) {
            return TentangJudulData.fromJson(tentangJudulDataMap);
          }
        }
      }
      return null;
    }

    return Scaffold(
      body: FutureBuilder<TentangJudulData?>(
        future: _getTentangJudulData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error fetching data"),
            );
          } else if (snapshot.data != null) {
            final tentangJudulData = snapshot.data!;
            return SafeArea(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const MyNavBar(judul: "Judul Kamu"),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tema Yang Diambil",
                              style: GoogleFonts.lato(
                                color: AppColors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              width: 160,
                              height: 70,
                              decoration: BoxDecoration(
                                color: AppColors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Center(
                                  child: Text(
                                    tentangJudulData.tema,
                                    style: GoogleFonts.lato(
                                      color: AppColors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Judul Kamu",
                              style: GoogleFonts.lato(
                                color: AppColors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            MyTextField(
                              onChanged: (value) {},
                              hintText: "Masukan Judul Anda Disini...",
                              labelText: "Judul Anda...",
                              maxLines: 1,
                              readOnly: true,
                              controller: TextEditingController(
                                text: tentangJudulData.judul,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Deskripsi Judul",
                              style: GoogleFonts.lato(
                                color: AppColors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            MyTextField(
                              onChanged: (value) {},
                              hintText: "Masukan Judul Anda Disini...",
                              labelText: "Judul Anda...",
                              maxLines: 5,
                              readOnly: true,
                              controller: TextEditingController(
                                text: tentangJudulData.deskripsi,
                              ),
                            ),
                          ],
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
                                  MaterialPageRoute(builder: (context) {
                                    return const MasukanJudul();
                                  }),
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
                                      "Tambah / Edit Kriteria",
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
                  )
                ],
              ),
            );
          } else {
            return SafeArea(
              child: Stack(
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
                            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                  MaterialPageRoute(builder: (context) {
                                    return const MasukanJudul();
                                  }),
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
              ),
            );
          }
        },
      ),
    );
  }
}
