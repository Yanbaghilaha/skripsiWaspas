import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spk_app/admin/alternatifOrTemaSkripsi/daftar_tema_skripsi.dart';
import 'package:spk_app/material/colors.dart';

import '../extract_widget/top_navbar.dart';

class EditSubKriteria extends StatefulWidget {
  final Map<String, dynamic> subKriteria;
  final String documentId;

  const EditSubKriteria({
    super.key,
    required this.subKriteria,
    required this.documentId,
  });

  @override
  _EditSubKriteriaState createState() => _EditSubKriteriaState();
}

class _EditSubKriteriaState extends State<EditSubKriteria> {
  late TextEditingController _namaController;
  List<String> newFields = [];
  CollectionReference kriteriaCollection =
      FirebaseFirestore.instance.collection('kriteria');
  late Map<String, TextEditingController> _subKriteriaControllers;

  List<MapEntry<String, int>> getSortedSubKriteria() {
    final subKriteriaList = <MapEntry<String, int>>[];

    widget.subKriteria.forEach((key, value) {
      subKriteriaList.add(MapEntry<String, int>(key, value as int));
    });

    subKriteriaList.sort((a, b) => a.value.compareTo(b.value));

    return subKriteriaList;
  }

  Future<void> editKriteria() async {
    String newNama = _namaController.text;
    Map<String, dynamic> newSubKriteria = {};

    _subKriteriaControllers.forEach((key, controller) {
      newSubKriteria[key] = int.parse(controller.text);
    });

    try {
      await kriteriaCollection.doc(widget.documentId).update({
        'nama': newNama,
        'subKriteria': newSubKriteria,
      });

      Navigator.of(context).pop(); // Navigate back
    } catch (error) {
      // Handle error
      print('Error updating data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final sortedSubKriteria = getSortedSubKriteria();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: Column(
                children: [
                  const MyNavBar(judul: "Edit Sub Kriteria"),
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
                      ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (index < sortedSubKriteria.length) {
                            final subKriteriaName =
                                sortedSubKriteria[index].key;
                            final subKriteriaValue =
                                sortedSubKriteria[index].value;
                            final subKriteriaController = TextEditingController(
                              text: subKriteriaValue.toString(),
                            );

                            return Dismissible(
                              key: UniqueKey(),
                              onDismissed: (direction) {
                                setState(() {
                                  newFields.removeAt(index);
                                });
                              },
                              background: Container(
                                alignment: Alignment.centerRight,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    builder: (context) {
                                      return MyPopup(
                                        controller: TextEditingController(),
                                        onPressed: () {
                                          final newValue = int.parse(
                                              subKriteriaController.text);

                                          editKriteria();
                                        },
                                        isHaveTwoTextField: true,
                                        controllerLeft: TextEditingController(
                                            text: subKriteriaName),
                                        controllerRight: TextEditingController(
                                          text: subKriteriaController.text,
                                        ),
                                        isTextField: true,
                                        judul: "Update SubKriteria",
                                        hintText: "hintText",
                                        buttonText: "Update",
                                      );
                                    },
                                  );
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppColors.blue,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 10),
                                          child: Text(
                                            subKriteriaName,
                                            style: GoogleFonts.lato(
                                              fontSize: 18,
                                              color: AppColors.white,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppColors.blue,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 10),
                                          child: Center(
                                            child: Text(
                                              subKriteriaController.text,
                                              style: GoogleFonts.lato(
                                                fontSize: 18,
                                                color: AppColors.white,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            // final newFieldController = TextEditingController();
                            return Dismissible(
                              key: UniqueKey(),
                              onDismissed: (direction) {
                                setState(() {
                                  newFields.removeAt(
                                      index - sortedSubKriteria.length);
                                });
                              },
                              background: Container(
                                alignment: Alignment.centerRight,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppColors.blue,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 10),
                                          child: Text(
                                            "",
                                            style: GoogleFonts.lato(
                                              fontSize: 18,
                                              color: AppColors.white,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppColors.blue,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 10),
                                          child: Center(
                                            child: Text(
                                              "",
                                              style: GoogleFonts.lato(
                                                fontSize: 18,
                                                color: AppColors.white,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemCount: sortedSubKriteria.length + newFields.length,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            newFields.add('');
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
                        onPressed: () {},
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
                                "Simpan",
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
