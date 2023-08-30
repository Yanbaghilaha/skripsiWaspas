import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spk_app/extract_widget/top_navbar.dart';

import '../extract_widget/text_field.dart';
import '../material/colors.dart';

class TambahSubKriteria extends StatefulWidget {
  final String kriteria;
  const TambahSubKriteria({
    super.key,
    required this.kriteria,
  });

  @override
  State<TambahSubKriteria> createState() => _TambahSubKriteriaState();
}

class _TambahSubKriteriaState extends State<TambahSubKriteria> {
  final TextEditingController kriteriaController = TextEditingController();
  CollectionReference kriteriaCollection =
      FirebaseFirestore.instance.collection('kriteria');
  List<Map<String, dynamic>> subkriteriaList = [];

  Map<String, dynamic> getSubKriteriaMap() {
    Map<String, dynamic> subKriteriaMap = {};

    for (var subkriteria in subkriteriaList) {
      if (subkriteria['nama'].isNotEmpty && subkriteria['nilai'] > 1) {
        subKriteriaMap[subkriteria['nama']] = subkriteria['nilai'];
      }
    }

    return subKriteriaMap;
  }

  void tambahDataSubKriteria() async {
    Map<String, dynamic> newSubKriteria = getSubKriteriaMap();

    try {
      await kriteriaCollection.doc(widget.kriteria).update({
        'subKriteria': newSubKriteria,
      });

      Navigator.pop(context);
    } catch (error) {
      print('Error updating subkriteria: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    kriteriaController.text = widget.kriteria;
  }

  //samaikan dengan nama metode (tambahDataSubKriteria)//
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
                  const MyNavBar(judul: "Tambah Sub Kriteria"),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Masukan Sub Kriteria & Nilai",
                        style: GoogleFonts.lato(
                          color: AppColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 600,
                        child: ListView.separated(
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
                                            int.tryParse(value) ?? 2;
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
                                )
                              ],
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                          itemCount: subkriteriaList.length,
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
                          //tamabah subkriteria
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
                                "Tambah Subkriteria",
                                style: GoogleFonts.lato(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.white),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                width: 16,
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
