// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:spk_app/extract_widget/top_navbar.dart';

import '../../extract_widget/text_field_popup.dart';
import '../../material/colors.dart';

class DaftarTemaSkripsi extends StatefulWidget {
  const DaftarTemaSkripsi({super.key});

  @override
  State<DaftarTemaSkripsi> createState() => _DaftarTemaSkripsiState();
}

class _DaftarTemaSkripsiState extends State<DaftarTemaSkripsi> {
  List<String> matkulList = [];

  //lihat data
  Future<void> _fetchAlternatives() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("alternatif").get();

      List<String> tempAlternatives = [];
      for (var document in querySnapshot.docs) {
        String alternativeName = document.id;
        tempAlternatives.add(alternativeName);
      }

      setState(() {
        matkulList = tempAlternatives;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  void changeDocumentName(String oldName, String newName) async {
    CollectionReference alternatifCollection =
        FirebaseFirestore.instance.collection('alternatif');

    // Get data from the old document
    DocumentSnapshot oldDocument =
        await alternatifCollection.doc(oldName).get();
    Map<String, dynamic> oldData = oldDocument.data() as Map<String, dynamic>;

    if (oldData.isNotEmpty) {
      // Create a new document with the new name and old data
      await alternatifCollection.doc(newName).set(oldData);

      // Delete the old document
      await alternatifCollection.doc(oldName).delete();

      print('Document name changed successfully.');
    } else {
      print('Old document not found or has no data.');
    }
  }

  void editAlternatif(String oldName, String newName) async {
    try {
      final alternativeRef =
          FirebaseFirestore.instance.collection('alternatif');

      final oldDocRef = alternativeRef.doc(oldName);
      final newDocRef = alternativeRef.doc(newName);

      final oldData = (await oldDocRef.get()).data() as Map<String, dynamic>;

      if (oldData != null) {
        await newDocRef.set(oldData);
        await oldDocRef.delete();

        print('Data alternatif berhasil diperbarui: $oldName -> $newName');
        _fetchAlternatives(); // Update the list of alternatives
      } else {
        print(
            'Data alternatif "$oldName" tidak ditemukan atau tidak memiliki data.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  //tambah data (*)
  void tambahAlternatif(String newAlternative) async {
    try {
      final alternativeRef =
          FirebaseFirestore.instance.collection('alternatif');

      final docRef = alternativeRef.doc(newAlternative);

      if (!(await docRef.get()).exists) {
        await docRef.set({});

        print('Data alternatif baru berhasil ditambahkan: $newAlternative');
        _fetchAlternatives(); // Update the list of alternatives
      } else {
        print('Data alternatif "$newAlternative" sudah ada.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  //hapus data (*)
  void hapusAlernatif(String alternative) async {
    try {
      await FirebaseFirestore.instance
          .collection("alternatif")
          .doc(alternative)
          .delete();

      _fetchAlternatives(); // Panggil kembali untuk memperbarui tampilan
    } catch (e) {
      print("Error deleting alternative: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    matkulList = [];
    _fetchAlternatives();
  }

  final TextEditingController controller = TextEditingController();

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
              children: [
                //judul screen
                const MyNavBar(judul: "Daftar Tema Skripsi"),
                //end judul screen

                const SizedBox(
                  height: 30,
                ),
                //list tema skripsi
                if (matkulList.isNotEmpty)
                  Expanded(
                    flex: 2,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 10,
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.blue,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 10),
                                  child: Text(
                                    matkulList[index],
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
                              width: 10,
                            ),

                            //edit
                            Flexible(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.orange,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      builder: (BuildContext context) {
                                        TextEditingController controller =
                                            TextEditingController(
                                          text: matkulList[index],
                                        ); // Menggunakan TextEditingController

                                        return MyPopup(
                                          controller:
                                              controller, // Menggunakan controller yang sudah didefinisikan
                                          isTextField: true,
                                          onPressed: () async {
                                            String newDocumentName =
                                                controller.text;

                                            if (newDocumentName.isNotEmpty &&
                                                newDocumentName !=
                                                    matkulList[index]) {
                                              editAlternatif(
                                                matkulList[index],
                                                newDocumentName,
                                              );

                                              Navigator.pop(
                                                  context); // Tutup bottom sheet setelah berhasil diperbarui
                                            } else {
                                              print(
                                                  "Tidak ada perubahan atau data kosong");
                                            }
                                          },
                                          judul: "Edit Tema Skripsi",
                                          hintText: "Masukan Tema Skripsi",
                                          buttonText: "Edit",
                                        );
                                      },
                                    );
                                  },
                                  child: const Icon(
                                    IconlyBold.edit,
                                    color: AppColors.blue,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(
                              width: 10,
                            ),

                            //hapus
                            Flexible(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
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
                                          buttonColor: AppColors.red,
                                          imageAssets:
                                              "assets/animation/sad-animation.json",
                                          controller: controller,
                                          onPressed: () {
                                            hapusAlernatif(matkulList[index]);
                                            Navigator.pop(context);
                                          },
                                          judul:
                                              "Apa Anda Yakin Ingin Menghapusnya",
                                          hintText: "Masukan Tema Skripsi",
                                          buttonText: "Hapus",
                                        );
                                      },
                                    );
                                  },
                                  child: const Icon(
                                    IconlyBold.delete,
                                    color: AppColors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 16,
                        );
                      },
                      itemCount: matkulList.length,
                    ),
                  ),
                //end list tema skripsi
              ],
            ),
          ),

          //Tambah tema
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
                        final value = await showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          context: context,
                          builder: (BuildContext build) {
                            return MyPopup(
                              buttonText: "Tambah",
                              hintText: "Masukan Tema Skripsi",
                              isTextField: true,
                              judul: "Tambah Tema Skripsi",
                              controller: controller,
                              onPressed: () {
                                String newAlternative = controller.text;
                                if (newAlternative.isNotEmpty) {
                                  tambahAlternatif(newAlternative);
                                  _fetchAlternatives();
                                }
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                        // ignore: avoid_print
                        print(value);
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
                              "Tambah Tema",
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
    ));
  }
}

class MyPopup extends StatelessWidget {
  const MyPopup({
    super.key,
    required this.controller,
    required this.onPressed,
    required this.judul,
    required this.hintText,
    required this.buttonText,
    this.imageAssets = "",
    this.isTextField = true,
    this.height = 300,
    this.buttonColor = AppColors.blue,
    this.onChange,
  });

  final TextEditingController controller;
  final VoidCallback onPressed;
  final String judul, hintText, buttonText, imageAssets;
  final Color buttonColor;
  final bool isTextField;
  final double height;
  final Function? onChange;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              judul,
              style: GoogleFonts.lato(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
            isTextField
                ? TextFieldPopUp(
                    hintText: hintText,
                    controller: controller,
                    onChange: (v) {
                      onChange!(v);
                    },
                  )
                : LottieBuilder.asset(imageAssets, height: 300),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        child: Text(
                          "Batal",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            fontSize: 24,
                            color: Colors.black38,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                //right button
                Expanded(
                  child: TextButton(
                    onPressed: onPressed,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: buttonColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        child: Text(
                          buttonText,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            fontSize: 24,
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
