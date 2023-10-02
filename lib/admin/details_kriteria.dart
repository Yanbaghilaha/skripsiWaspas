import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:spk_app/admin/bobot/edit_bobot.dart';
import 'package:spk_app/extract_widget/top_navbar.dart';
import 'package:spk_app/material/colors.dart';
import 'package:spk_app/extract_widget/text_field.dart';

import '../extract_widget/pop_up_success.dart';
import 'alternatifOrTemaSkripsi/daftar_tema_skripsi.dart';

class DetailsDataKriteria extends StatefulWidget {
  final TextEditingController? controllerLeft;
  final TextEditingController? controllerRight;
  final String jenis, nama, documentId;
  final double bobot;
  final Map<String, dynamic> subKriteria;

  const DetailsDataKriteria({
    Key? key,
    required this.jenis,
    required this.bobot,
    required this.nama,
    required this.subKriteria,
    required this.documentId,
    this.controllerLeft,
    this.controllerRight,
  }) : super(key: key);

  @override
  State<DetailsDataKriteria> createState() => DetailsDataKriteriaState();
}

class DetailsDataKriteriaState extends State<DetailsDataKriteria> {
  late TextEditingController _namaController;
  late Map<String, TextEditingController> _subKriteriaControllers;
  CollectionReference kriteriaCollection =
      FirebaseFirestore.instance.collection('kriteria');
  List<Map<String, dynamic>> subkriteriaList = [];

  late TextEditingController? controllerSubKriteriaName,
      controllerSubKriteriaValue;
  String _currentJenis = "";

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
    setState(() {});
  }

  Future<void> editKriteria() async {
    String newNama = _namaController.text;
    Map<String, dynamic> newSubKriteria = {};

    _subKriteriaControllers.forEach((key, controller) {
      String subKriteriaName = key;
      String subKriteriaValue = controller.text;

      // Periksa apakah nilai bukan angka
      if (subKriteriaValue.isNotEmpty &&
          int.tryParse(subKriteriaValue) != null) {
        newSubKriteria[subKriteriaName] = int.parse(subKriteriaValue);
      } else {
        // Jika nama berubah, tambahkan nama baru
        if (subKriteriaName != subKriteriaValue) {
          newSubKriteria[subKriteriaValue] =
              widget.subKriteria[subKriteriaName];
        }
      }
    });

    try {
      await kriteriaCollection.doc(widget.documentId).update({
        'nama': newNama,
        'subKriteria': newSubKriteria,
      });
    } catch (error) {
      // Handle error
      print('Error updating data: $error');
    }
  }

  void _updateSubKriteria(String subKriteriaName, String value) {
    final subKriteriaController = _subKriteriaControllers[subKriteriaName];
    if (subKriteriaController != null) {
      subKriteriaController.text = value;
    }
  }

  //hapus
  void _deleteSubKriteria(String subKriteriaName) {
    if (_subKriteriaControllers.containsKey(subKriteriaName)) {
      setState(() {
        _subKriteriaControllers.remove(subKriteriaName);
      });
    }
    _removeSubKriteriaFromFirestore(subKriteriaName);
  }

  Future<void> _removeSubKriteriaFromFirestore(String subKriteriaName) async {
    try {
      // Buat referensi ke koleksi "kriteria" (sesuaikan dengan nama koleksi Anda)
      DocumentReference kriteriaDocRef = FirebaseFirestore.instance
          .collection('kriteria')
          .doc(widget.documentId);

      // Hapus data subkriteria dari Firestore
      await kriteriaDocRef.update({
        'subKriteria.$subKriteriaName': FieldValue.delete(),
      });
    } catch (error) {
      // Tangani kesalahan jika ada
      print('Error deleting data from Firestore: $error');
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    for (var controller in _subKriteriaControllers.values) {
      controller.dispose();
    }

    super.dispose();
  }

  Future<void> tambahDataKeFirestore(
      String namaSubKriteria, String nilai) async {
    try {
      // Buat referensi ke koleksi "kriteria" (sesuaikan dengan nama koleksi Anda)
      DocumentReference kriteriaDocRef = FirebaseFirestore.instance
          .collection('kriteria')
          .doc(widget.documentId);

      // Tambahkan data subkriteria baru ke Firestore tanpa menghapus yang sudah ada
      await kriteriaDocRef.update(
        {'subKriteria.$namaSubKriteria': int.parse(nilai)},
      );
    } catch (error) {
      // Tangani kesalahan jika ada
      print('Error adding data to Firestore: $error');
    }
  }

  Future<void> _updateJenisFirestore(String newJenis) async {
    try {
      await kriteriaCollection.doc(widget.documentId).update({
        'jenis': newJenis,
      });
    } catch (error) {
      // Handle error
      print('Error updating jenis: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('kriteria')
            .doc(widget.documentId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator(); // Menampilkan loading jika data belum tersedia
          }

          Map<String, dynamic>? subKriteriaData =
              snapshot.data!.get('subKriteria');

          subKriteriaData ??= {};

          final sortedSubKriteria = subKriteriaData.entries.toList()
            ..sort((a, b) => a.value.compareTo(b.value));
          final data = snapshot.data!.data() as Map<String, dynamic>;
          final jenis = data['jenis'] as String; // Ambil jenis dari Firestore
          return SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 10,
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
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
                                            builder: (context) =>
                                                const EditBobot(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.blue,
                                          borderRadius:
                                              BorderRadius.circular(40),
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
                                    GestureDetector(
                                      onTap: () async {
                                        showModalBottomSheet(
                                          context: context,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          builder: (BuildContext context) {
                                            return Container(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 30,
                                                        vertical: 30),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color:
                                                                AppColors.blue),
                                                        child: ListTile(
                                                          title: const Text(
                                                              'Benefit'),
                                                          onTap: () async {
                                                            await _updateJenisFirestore(
                                                                'Benefit');
                                                            setState(() {
                                                              _currentJenis =
                                                                  'Benefit';
                                                            });
                                                            Navigator.pop(
                                                                context);
                                                            setState(() {});
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color:
                                                                AppColors.blue),
                                                        child: ListTile(
                                                          title: const Text(
                                                              'Cost'),
                                                          onTap: () async {
                                                            await _updateJenisFirestore(
                                                                'Cost');
                                                            setState(() {
                                                              _currentJenis =
                                                                  'Cost';
                                                            });
                                                            Navigator.pop(
                                                                context);
                                                            setState(() {});
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.blue,
                                          borderRadius:
                                              BorderRadius.circular(40),
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
                                                  jenis,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Data Sub-Kriteria",
                                      style: GoogleFonts.lato(
                                        fontSize: 22,
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          builder: (BuildContext context) {
                                            TextEditingController
                                                controllerField =
                                                TextEditingController();
                                            TextEditingController
                                                controllerValue =
                                                TextEditingController();

                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    bottom:
                                                        MediaQuery.of(context)
                                                            .viewInsets
                                                            .bottom),
                                                child: MyPopup(
                                                  controller:
                                                      TextEditingController(),
                                                  isTextField: true,
                                                  isHaveTwoTextField: true,
                                                  controllerLeft:
                                                      controllerField,
                                                  controllerRight:
                                                      controllerValue,
                                                  hintTextLeft:
                                                      "Data Sub Kriteria",
                                                  hintTextRight: "0",
                                                  onPressed: () async {
                                                    setState(() {});
                                                    final namaSubKriteria =
                                                        controllerField.text;
                                                    final nilai =
                                                        controllerValue.text;
                                                    tambahDataKeFirestore(
                                                        namaSubKriteria, nilai);
                                                    showModalBottomSheet(
                                                      context: context,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      builder: (context) {
                                                        return const PopUp3(
                                                          text:
                                                              "Sukses Ditambahkan",
                                                          lottieAssets:
                                                              "assets/animation/checklist.json",
                                                        );
                                                      },
                                                    );
                                                  },
                                                  judul:
                                                      "Tambahkan Sub Kriteria",
                                                  hintText:
                                                      "Masukan Sub Kriteria",
                                                  buttonText: "Tambah",
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.blue,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: 16,
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Tambah",
                                                style: GoogleFonts.lato(
                                                  fontSize: 18,
                                                  color: AppColors.white,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Icon(
                                                PhosphorIcons.plus_bold,
                                                size: 18,
                                                color: AppColors.white,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 700,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(
                                        height: 10,
                                      );
                                    },
                                    itemCount: sortedSubKriteria.length,
                                    itemBuilder: (context, index) {
                                      final subKriteriaEntry =
                                          sortedSubKriteria[index];
                                      final subKriteriaName =
                                          subKriteriaEntry.key;
                                      final subKriteriaValue =
                                          subKriteriaEntry.value;

                                      return Row(
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: MyTextField(
                                              onTap: (value) {},
                                              onChanged: (newName) {
                                                _updateSubKriteria(
                                                    subKriteriaName, newName);
                                              },
                                              isShowLabelText: false,
                                              textColor: AppColors.white,
                                              hintText: "",
                                              readOnly: false,
                                              textController: "",
                                              labelText: "nilai",
                                              controller: TextEditingController(
                                                text: subKriteriaName,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: MyTextField(
                                              onTap: (value) {},
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
                                                text:
                                                    subKriteriaValue.toString(),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () async {
                                                await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  context: context,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  builder: (context) {
                                                    return MyPopup(
                                                      height: 567,
                                                      controller:
                                                          TextEditingController(),
                                                      onPressed: () async {
                                                        _deleteSubKriteria(
                                                            subKriteriaName);

                                                        showModalBottomSheet(
                                                          context: context,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                          ),
                                                          builder: (context) {
                                                            return const PopUp3(
                                                              text:
                                                                  "Sukses Dihapus",
                                                              lottieAssets:
                                                                  "assets/animation/checklist.json",
                                                            );
                                                          },
                                                        );
                                                      },
                                                      judul:
                                                          "Apakah Anda Yakin Ingin Dihapus?",
                                                      hintText: "",
                                                      isTextField: false,
                                                      imageAssets:
                                                          "assets/animation/sad-animation.json",
                                                      buttonText: "Hapus",
                                                      buttonColor:
                                                          AppColors.red,
                                                    );
                                                  },
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: AppColors.red,
                                                ),
                                                child: const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 20,
                                                      horizontal: 5),
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
                                isScrollControlled: true,
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                builder: (context) {
                                  return MyPopup(
                                    height: 567,
                                    controller: TextEditingController(),
                                    onPressed: () async {
                                      editKriteria();

                                      showModalBottomSheet(
                                        context: context,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        builder: (context) {
                                          return const PopUp3(
                                            text: "Sukses Diupdate",
                                            lottieAssets:
                                                "assets/animation/checklist.json",
                                          );
                                        },
                                      );
                                    },
                                    judul: "Apakah Anda Yakin Ingin Update?",
                                    hintText: "",
                                    isTextField: false,
                                    imageAssets: "assets/animation/review.json",
                                    buttonText: "Update",
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
          );
        },
      ),
    );
  }
}
