import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:spk_app/admin/bobot/edit_bobot.dart';
import 'package:spk_app/extract_widget/top_navbar.dart';
import 'package:spk_app/material/colors.dart';
import 'package:spk_app/extract_widget/text_field.dart';

class DetailsDataKriteria extends StatefulWidget {
  final String jenis, nama, documentId;
  final double bobot;
  final Map<String, dynamic> subKriteria;

  const DetailsDataKriteria({
    super.key,
    required this.jenis,
    required this.bobot,
    required this.nama,
    required this.subKriteria,
    required this.documentId,
  });

  @override
  State<DetailsDataKriteria> createState() => DetailsDataKriteriaState();
}

class DetailsDataKriteriaState extends State<DetailsDataKriteria> {
  late TextEditingController _namaController;
  late Map<String, TextEditingController> _subKriteriaControllers;
  CollectionReference kriteriaCollection =
      FirebaseFirestore.instance.collection('kriteria');

  //final for controller in texfield

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.nama);
    _subKriteriaControllers = {};

    widget.subKriteria.forEach((key, value) {
      _subKriteriaControllers[key] = TextEditingController(
        text: value.toString(),
      );
    });
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

  void _updateSubKriteria(String subKriteriaName, String value) {
    setState(() {
      final subKriteriaController = _subKriteriaControllers[subKriteriaName];
      if (subKriteriaController != null) {
        subKriteriaController.text = value;
      }
    });
  }

  void hapusSubKriteria(String subKriteriaName) {
    print(
        "Before deletion - _subKriteriaControllers: $_subKriteriaControllers");

    setState(() {
      _subKriteriaControllers.remove(subKriteriaName);
    });

    print("After deletion - _subKriteriaControllers: $_subKriteriaControllers");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MyNavBar(
                    judul: "Details Data Kriteria",
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  //Bobot & Jenis
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            //bobot
                            Text(
                              "Bobot",
                              style: GoogleFonts.lato(
                                fontSize: 22,
                                color: AppColors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const EditBobot(),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.blue,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 3,
                                      horizontal: 10,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          widget.bobot.toString(),
                                          style: GoogleFonts.lato(
                                            fontSize: 18,
                                            color: AppColors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Icon(
                                          IconlyBold.edit,
                                          color: AppColors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.whiteLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 80,
                        width: 5,
                      ),

                      //Jenis
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Jenis",
                              style: GoogleFonts.lato(
                                fontSize: 22,
                                color: AppColors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.blue,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 3,
                                    horizontal: 10,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        widget.jenis,
                                        style: GoogleFonts.lato(
                                          fontSize: 18,
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Icon(
                                        IconlyBold.edit,
                                        color: AppColors.white,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  //Data Kriteria TextField
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Kriteria",
                        style: GoogleFonts.lato(
                          fontSize: 22,
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextField(
                        onChanged: (value) {},
                        isShowLabelText: false,
                        textController: "nama",
                        controller: _namaController,
                      )
                    ],
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  //data sub-kriteria
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Data Sub-Kriteria",
                              style: GoogleFonts.lato(
                                fontSize: 22,
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 320,
                          child: ListView.separated(
                            itemCount: widget.subKriteria.length,
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 20,
                              );
                            },
                            itemBuilder: (context, index) {
                              final subKriteriaName =
                                  widget.subKriteria.keys.elementAt(index);
                              final subKriteriaController =
                                  _subKriteriaControllers[subKriteriaName];

                              return Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: MyTextField(
                                      onChanged: (newValue) {
                                        _subKriteriaControllers
                                            .remove(subKriteriaName);
                                        _subKriteriaControllers[newValue] =
                                            TextEditingController(
                                                text: subKriteriaController
                                                    ?.text);
                                      },
                                      showHint: true,
                                      hintText: "Masukan Data Sub-Kriteria",
                                      controller: TextEditingController(
                                        text: subKriteriaName,
                                      ),
                                      // readOnly: true,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: MyTextField(
                                      onChanged: (value) {
                                        _updateSubKriteria(
                                            subKriteriaName, value);
                                      },
                                      textAlign: TextAlign.center,
                                      isShowLabelText: false,
                                      textColor: AppColors.green,
                                      hintText: "",
                                      readOnly: false,
                                      textController: "",
                                      labelText: "nilai",
                                      controller: TextEditingController(
                                          text: subKriteriaController?.text),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        hapusSubKriteria(subKriteriaName);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppColors.red,
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 5),
                                          child: Center(
                                            child: Icon(
                                              IconlyBold.delete,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
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
                          editKriteria();
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
