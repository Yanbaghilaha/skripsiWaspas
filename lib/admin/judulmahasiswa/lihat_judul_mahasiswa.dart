// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spk_app/admin/alternatifOrTemaSkripsi/daftar_tema_skripsi.dart';
import 'package:spk_app/extract_widget/text_field2.dart';
import 'package:spk_app/extract_widget/top_navbar.dart';

import '../../extract_widget/pop_up_success.dart';
import '../../material/colors.dart';

class LihatJudulMahasiswa extends StatefulWidget {
  final String nama, judul, tema, tentangJudul;
  const LihatJudulMahasiswa({
    super.key,
    required this.nama,
    required this.judul,
    required this.tema,
    required this.tentangJudul,
  });

  @override
  State<LihatJudulMahasiswa> createState() => _LihatJudulMahasiswaState();
}

class _LihatJudulMahasiswaState extends State<LihatJudulMahasiswa> {
  final List ulaskan = [
    ['Tolak', false],
    ['Terima', false],
  ];
  final List<List<dynamic>> ulaskanOptions = [
    ['Tolak', false],
    ['Terima', false],
  ];

  String selectedUlasan = ''; // Variabel untuk menyimpan pilihan ulasan

  void selectUlasan(int index) {
    setState(() {
      selectedUlasan = ulaskanOptions[index][0];
    });
  }

  void _simpanUlasan() async {
    final userDoc = FirebaseFirestore.instance
        .collection('users')
        .doc('14519930@gmail.com');

    await userDoc.update({
      'ulasan': selectedUlasan,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ulasan tersimpan')),
    );
  }

  void temaTypeSelected(int index) {
    setState(
      () {
        for (int i = 0; i < ulaskan.length; i++) {
          ulaskan[i][1] = false;
        }
        ulaskan[index][1] = true;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          SizedBox(
            height: 720,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyNavBar(judul: widget.nama),
                      const SizedBox(
                        height: 30,
                      ),
                      Column(
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

                          //tema
                          SizedBox(
                            width: 150,
                            height: 60,
                            child: GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AppColors.border,
                                  ),
                                  color: AppColors.blue,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 35,
                                  ),
                                  child: Center(
                                    child: Text(
                                      widget.tema,
                                      style: GoogleFonts.lato(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 17,
                                      ),
                                    ),
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

                      //input deskripsi Judul
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Input Judul & Deskripsi Judul",
                              style: GoogleFonts.lato(
                                color: AppColors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            MyTextField2(
                              readOnly: true,
                              labelText: "",
                              myText: widget.tema,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            MyTextField2(
                              readOnly: true,
                              labelText: "",
                              myText: widget.tentangJudul,
                              maxLines: 5,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                            height: 30,
                          ),
                          for (int i = 0; i < ulaskanOptions.length; i++)
                            Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.blue),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: RadioListTile(
                                  title: Text(
                                    ulaskanOptions[i][0],
                                    style: GoogleFonts.lato(
                                      color: AppColors.white,
                                    ),
                                  ),
                                  value: ulaskanOptions[i][0],
                                  activeColor: AppColors.white,
                                  groupValue: selectedUlasan,
                                  onChanged: (value) => selectUlasan(i),
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
                      onPressed: () async {
                        await showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          builder: (context) {
                            return MyPopup(
                              height: 567,
                              controller: TextEditingController(),
                              onPressed: () {
                                _simpanUlasan();
                                Navigator.pop(context);
                                showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  builder: (context) {
                                    return const PopUp3(
                                      text: "Sukses Ditambahkan",
                                      lottieAssets:
                                          "assets/animation/checklist.json",
                                    );
                                  },
                                );
                              },
                              judul: "Apakah Anda Yakin Ingin Mengulaskan?",
                              hintText: "",
                              isTextField: false,
                              imageAssets: "assets/animation/review.json",
                              buttonText: "Ulaskan",
                            );
                          },
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
