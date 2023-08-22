import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spk_app/admin/tambah_sub_kriteria.dart';
import 'package:spk_app/extract_widget/top_navbar.dart';
import 'package:spk_app/material/colors.dart';

import '../extract_widget/tema_skripsi.dart';
import '../extract_widget/text_field.dart';
import 'alternatifOrTemaSkripsi/daftar_tema_skripsi.dart';

class TambahDataKriteria extends StatefulWidget {
  const TambahDataKriteria({super.key});

  @override
  State<TambahDataKriteria> createState() => _TambahDataKriteriaState();
}

class _TambahDataKriteriaState extends State<TambahDataKriteria> {
  final TextEditingController kriteria = TextEditingController();
  String selectedJenisAtribut = "";

  List atribut = [
    [
      "Cost",
      false,
    ],
    [
      "Benefit",
      false,
    ],
  ];
  void temaTypeSelected(int index) {
    setState(
      () {
        for (int i = 0; i < atribut.length; i++) {
          atribut[i][1] = false;
        }
        atribut[index][1] = true;
      },
    );
    selectedJenisAtribut = atribut[index][0];
  }

  void tambahData(String kriteria, String jenis) async {
    try {
      // Membuat data yang akan ditambahkan ke Firestore
      Map<String, dynamic> newData = {
        'bobot': 0,
        'jenis': jenis,
        'nama': kriteria,
      };

      // Menambahkan data baru ke koleksi 'kriteria' pada Firestore
      await FirebaseFirestore.instance
          .collection('kriteria')
          .doc(kriteria) // Menggunakan kriteria sebagai nama dokumen
          .set(newData);

      // Tampilkan notifikasi atau pesan sukses jika diperlukan
      print('Data kriteria berhasil ditambahkan ke Firestore.');
    } catch (e) {
      print('Error: $e');
      // Tampilkan notifikasi atau pesan error jika diperlukan
    }
  }

  void tambahKriteria() {
    tambahData(kriteria.text, selectedJenisAtribut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              //data kriteria
              child: Column(
                children: [
                  const MyNavBar(
                    judul: " Kriteria",
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Data Kriteria",
                        style: GoogleFonts.lato(
                          color: AppColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      MyTextField(
                        onChanged: (value) {},
                        isShowLabelText: false,
                        hintText: "Masukan Kriteria",
                        controller: kriteria,
                        labelText: "Masukan Data Kriteria",
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  //jenis Atribut
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jenis Atribut",
                          style: GoogleFonts.lato(
                            color: AppColors.white,
                            fontSize: 20,
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
                                text: atribut[index][0],
                                isSelected: atribut[index][1],
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
                            itemCount: atribut.length,
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
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            builder: (BuildContext context) {
                              return MyPopup(
                                isTextField: false,
                                height: 507,
                                imageAssets:
                                    "assets/animation/confirmation-animation.json",
                                controller: TextEditingController(),
                                buttonColor: AppColors.blue,
                                onPressed: () async {
                                  tambahKriteria();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const TambahSubKriteria(),
                                    ),
                                  );
                                },
                                judul: "Apa Anda Yakin Ingin Menambahnya",
                                hintText: "Masukan Tema Skripsi",
                                buttonText: "Tambah",
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
                                "Tambah Data",
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
