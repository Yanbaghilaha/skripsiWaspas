import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spk_app/admin/bobot/edit_bobot.dart';
import 'package:spk_app/extract_widget/top_navbar.dart';

import '../extract_widget/text_field.dart';
import '../material/colors.dart';

class TambahSubKriteriaSample extends StatefulWidget {
  final String kriteria;

  const TambahSubKriteriaSample({super.key, required this.kriteria});

  @override
  _TambahSubKriteriaSampleState createState() =>
      _TambahSubKriteriaSampleState();
}

class _TambahSubKriteriaSampleState extends State<TambahSubKriteriaSample> {
  List<Map<String, dynamic>> subkriteriaList = [];

  void tambahDataSubKriteria() async {
    Map<String, dynamic> newSubKriteria = {};

    for (var subkriteria in subkriteriaList) {
      newSubKriteria[subkriteria['nama']] = subkriteria['nilai'];
    }

    try {
      await FirebaseFirestore.instance
          .collection('kriteria')
          .doc(widget.kriteria)
          .update({
        'subKriteria': newSubKriteria,
      });

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const EditBobot()));
    } catch (error) {
      print('Error updating subkriteria: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const MyNavBar(judul: "Masukan Sub Kriteria"),
                const SizedBox(
                  height: 30,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final subkriteria = subkriteriaList[index];
                    final controller = TextEditingController(
                      text: subkriteria['nama'],
                    );
                    final nilaiController = TextEditingController(
                      text: subkriteria['nilai'].toString(),
                    );
                    return Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: MyTextField(
                            onChanged: (value) {
                              setState(() {
                                subkriteriaList[index]['nama'] = value;
                              });
                            },
                            showHint: true,
                            hintText: "Masukan Data Sub-Kriteria",
                            controller: controller,
                            readOnly: false,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: MyTextField(
                            onChanged: (value) {
                              setState(() {
                                subkriteriaList[index]['nilai'] =
                                    int.tryParse(value) ?? 0;
                              });
                            },
                            textAlign: TextAlign.center,
                            isShowLabelText: false,
                            textColor: AppColors.green,
                            hintText: "0",
                            readOnly: false,
                            labelText: "Data Sub Kriteria",
                            controller: nilaiController,
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemCount: subkriteriaList.length,
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      subkriteriaList.add({'nama': '', 'nilai': 0});
                    });
                  },
                  child: Container(
                    width: 220,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Tambah Field",
                                style: GoogleFonts.lato(
                                  color: AppColors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Icon(
                                PhosphorIcons.plus_bold,
                                color: AppColors.white,
                              ),
                            ],
                          )),
                    ),
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
                          tambahDataSubKriteria(); // Panggil metode tambahDataSubKriteria saat tombol ditekan
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
                              const Icon(Icons.save), // Ikonya "Simpan"
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Simpan", // Teks tombol
                                style: GoogleFonts.lato(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.white,
                                ),
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
      ),
    );
  }
}
