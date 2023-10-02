// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spk_app/admin/bobot/edit_bobot.dart';
import 'package:spk_app/extract_widget/top_navbar.dart';

import '../extract_widget/text_field.dart';
import '../material/colors.dart';

class TambahSubKriteria extends StatefulWidget {
  final String kriteria;

  const TambahSubKriteria({super.key, required this.kriteria});

  @override
  _TambahSubKriteriaState createState() => _TambahSubKriteriaState();
}

class _TambahSubKriteriaState extends State<TambahSubKriteria> {
  List<Map<String, dynamic>> subkriteriaList = [];
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < subkriteriaList.length; i++) {
      controllers.add(TextEditingController(
        text: subkriteriaList[i]['nama'],
      ));
    }
  }

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
    print(widget.kriteria);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: Column(
                children: [
                  const MyNavBar(judul: "Masukan Sub Kriteria"),
                  const SizedBox(
                    height: 30,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (index < subkriteriaList.length) {
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
                                  subkriteriaList[index]['nama'] = value;
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
                                  subkriteriaList[index]['nilai'] =
                                      int.tryParse(value) ?? 0;
                                },
                                textAlign: TextAlign.center,
                                isShowLabelText: false,
                                textColor: AppColors.green,
                                hintText: "0",
                                readOnly: false,
                                labelText: "Nilai",
                                controller: nilaiController,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
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
                      decoration: BoxDecoration(
                        color: AppColors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Tambah Field",
                              style: GoogleFonts.lato(
                                color: AppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              PhosphorIcons.plus_bold,
                              color: AppColors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
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
