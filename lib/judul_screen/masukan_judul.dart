// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spk_app/extract_widget/text_field.dart';
import 'package:spk_app/extract_widget/top_navbar.dart';
import 'package:spk_app/loading_screen/loading_screen_upload.dart';

import '../extract_widget/tema_skripsi.dart';
import '../material/colors.dart';

class MasukanJudul extends StatefulWidget {
  const MasukanJudul({Key? key}) : super(key: key);

  @override
  _MasukanJudulState createState() => _MasukanJudulState();
}

class _MasukanJudulState extends State<MasukanJudul> {
  String activeUserEmail = ""; // Simpan email user yang aktif
  final TextEditingController judul = TextEditingController();
  final TextEditingController deskripsiJudul = TextEditingController();
  Map<String, bool> temaSkripsi = {};
  String selectedTema = "";

  @override
  void initState() {
    super.initState();
    // getUserInfo();
    getTemaSkripsiData();
  }

  // void getUserInfo() async {
  //   final User? user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     setState(() {
  //       activeUserEmail = user.email ?? "";
  //     });
  //   }
  // }

  void getTemaSkripsiData() async {
    try {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('alternatif').get();

      final fetchedTemaSkripsi = querySnapshot.docs
          .map((doc) => doc.id)
          .toList()
          .cast<String>(); // Ambil daftar tema skripsi dari dokumen

      setState(() {
        temaSkripsi = {for (var item in fetchedTemaSkripsi) item: false};
      });
    } catch (error) {
      print('Error fetching tema skripsi data: $error');
    }
  }

  void temaTypeSelected(String tema) {
    setState(() {
      temaSkripsi.updateAll((key, value) => false);
      temaSkripsi[tema] = true;
      selectedTema = tema;
    });
  }

  bool isJudulEmpty = false; // State untuk menandai apakah judul kosong
  bool isDeskripsiEmpty = false;

  void simpanData() async {
    if (judul.text.isEmpty) {
      setState(() {
        isJudulEmpty = true;
      });
      return;
    } else {
      setState(() {
        isJudulEmpty = false;
      });
    }

    if (deskripsiJudul.text.isEmpty) {
      setState(() {
        isDeskripsiEmpty = true;
      });
      return;
    } else {
      setState(() {
        isDeskripsiEmpty = false;
      });
    }
    Future<List<Map<String, dynamic>>?> _getTentangJudulData(
        String userEmail) async {
      try {
        final userDoc =
            FirebaseFirestore.instance.collection('users').doc(userEmail);
        final docSnapshot = await userDoc.get();

        if (docSnapshot.exists) {
          final data = docSnapshot.data();
          final List<Map<String, dynamic>> tentangJudulDataList = [];

          for (int i = 0; data?['tentangJudul-$i'] != null; i++) {
            final tentangJudulDataMap = data?['tentangJudul-$i'];
            tentangJudulDataList.add(
              Map<String, dynamic>.from(tentangJudulDataMap),
            );
          }

          return tentangJudulDataList;
        }
      } catch (error) {
        print('Error fetching data: $error');
      }
      return null;
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final activeUserEmail = user.email;
        final tentangJudulData =
            await _getTentangJudulData(activeUserEmail.toString());

        if (tentangJudulData != null) {
          // Menentukan nomor unik untuk kunci
          final nomor = tentangJudulData.length;

          // Buat objek data baru
          final newData = {
            'tema': selectedTema,
            'deskripsi': deskripsiJudul.text,
            'judul': judul.text,
            'ulasan': "Belum Diulas",
            'waktu': FieldValue.serverTimestamp(),
          };

          // Perbarui dokumen Firestore dengan kunci yang sesuai
          await FirebaseFirestore.instance
              .collection('users')
              .doc(activeUserEmail)
              .update({
            'tentangJudul-$nomor': newData,
          });

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoadingScreen2()),
          );
        }
      }
    } catch (error) {
      print('Error saving data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: Column(
                  children: [
                    const MyNavBar(judul: "Input Judul Kamu"),
                    const SizedBox(
                      height: 20,
                    ),
                    // masukan Tema skripsi
                    SizedBox(
                      height: 470,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Masukan Tema",
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Flexible(
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final tema = temaSkripsi.keys.elementAt(index);
                                return TemaSkripsi(
                                  text: tema,
                                  isSelected: temaSkripsi[tema] ?? false,
                                  onTap: () {
                                    temaTypeSelected(tema);
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
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Input Judul",
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
                                  controller: deskripsiJudul,
                                  hintText: "Deskripsi Judul Anda...",
                                  labelText: "Dekripsi Judul Anda...",
                                  maxLines: 6,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
                      fit: FlexFit.tight,
                      child: TextButton(
                        onPressed: () {
                          simpanData();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 20,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.blue,
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
