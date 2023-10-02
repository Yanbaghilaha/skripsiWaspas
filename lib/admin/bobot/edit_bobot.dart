// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

import '../../extract_widget/pop_up_success.dart';
import '../../extract_widget/text_field3.dart';
import '../../extract_widget/top_navbar.dart';
import '../../material/colors.dart';
import '../alternatifOrTemaSkripsi/daftar_tema_skripsi.dart';

class EditBobot extends StatefulWidget {
  const EditBobot({
    super.key,
  });

  @override
  State<EditBobot> createState() => _EditBobotState();
}

class _EditBobotState extends State<EditBobot> {
  TextEditingController bobotController = TextEditingController();
  TextEditingController controller = TextEditingController();
  double totalBobot = 0.0;

  //baca data kriteria -> bobot
  Future<QuerySnapshot<Map<String, dynamic>>> _getData() async {
    return FirebaseFirestore.instance.collection('kriteria').get();
  }

  double _calculateTotalBobot(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> kriteriaList,
  ) {
    double totalBobot = 0.0;
    for (final kriteriaDoc in kriteriaList) {
      final kriteriaData = kriteriaDoc.data();
      final bobot = kriteriaData['bobot'] as double;
      totalBobot += bobot;
    }
    return totalBobot;
  }

  //updatebobot
  void _updateBobot(String docId, double newBobot) async {
    try {
      await FirebaseFirestore.instance
          .collection('kriteria')
          .doc(docId)
          .update({'bobot': newBobot});
      print('Bobot berhasil diperbarui di Firestore.$newBobot');

      final updatedData = await _getData();
      final updatedKriteriaList = updatedData.docs;
      totalBobot = _calculateTotalBobot(updatedKriteriaList);

      setState(() {});
    } catch (e) {
      print('Error saat memperbarui bobot: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                  vertical: 30,
                  horizontal: 10,
                ),
                child: Column(
                  children: [
                    //judul
                    const MyNavBar(judul: "Edit Bobot"),
                    const SizedBox(
                      height: 30,
                    ),

                    // StreamBuilder untuk memantau data Firestore
                    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection('kriteria')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        }

                        final kriteriaList = snapshot.data!.docs;

                        // Hitung total bobot
                        double totalBobot = _calculateTotalBobot(kriteriaList);

                        // Warna teks berdasarkan total bobot
                        Color textColor;
                        if (totalBobot > 10) {
                          textColor = Colors.red;
                        } else if (totalBobot < 10) {
                          textColor = AppColors.red;
                        } else {
                          textColor = AppColors.green;
                        }

                        return Column(
                          children: [
                            ListView.separated(
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                              shrinkWrap: true,
                              itemCount: kriteriaList.length,
                              itemBuilder: (context, index) {
                                final kriteria = kriteriaList[index].data();
                                final kriteriaDocRef =
                                    kriteriaList[index].reference;

                                // Buat TextEditingController untuk setiap TextField bobot
                                TextEditingController bobotController =
                                    TextEditingController(
                                        text: kriteria['bobot'].toString());

                                // Tambahkan listener untuk memantau perubahan nilai bobot
                                bobotController.addListener(() {
                                  final updatedBobot =
                                      double.tryParse(bobotController.text) ??
                                          0.0;
                                  if (updatedBobot != kriteria['bobot']) {
                                    // Saat pengguna mengubah nilai dalam TextField
                                    _updateBobot(
                                        kriteriaDocRef.id, updatedBobot);

                                    // Hitung total bobot setiap kali nilai berubah
                                    totalBobot =
                                        _calculateTotalBobot(kriteriaList);
                                    setState(() {});
                                  }
                                });

                                return Row(
                                  children: [
                                    Flexible(
                                      child: MyTextField3(
                                        kriteria: kriteria['nama'],
                                        bobot:
                                            bobotController, // Hubungkan TextEditingController ke TextField
                                        textColor:
                                            textColor, // Gunakan warna teks yang sesuai
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    // edit button
                                    GestureDetector(
                                      onTap: () async {
                                        showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          builder: (BuildContext context) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context)
                                                      .viewInsets
                                                      .bottom),
                                              child: MyPopup(
                                                isTextField: true,
                                                height: 307,
                                                imageAssets:
                                                    "assets/animation/sad-animation.json",
                                                controller:
                                                    TextEditingController(
                                                        text: kriteria['bobot']
                                                            .toString()),
                                                buttonColor: AppColors.blue,
                                                onChange: (newVal) {
                                                  // Di sini, Anda dapat memperbarui nilai bobot dalam TextEditingController jika diperlukan
                                                },
                                                onPressed: () async {
                                                  // Ambil nilai bobot dari TextEditingController
                                                  final newBobot =
                                                      double.tryParse(
                                                              bobotController
                                                                  .text) ??
                                                          0.0;
                                                  _updateBobot(
                                                      kriteriaDocRef.id,
                                                      newBobot);
                                                  // Setelah mengupdate bobot, kita perlu mengambil data terbaru
                                                  final updatedData =
                                                      await _getData();
                                                  final updatedKriteriaList =
                                                      updatedData.docs;
                                                  // Hitung total bobot dengan data yang telah diperbarui
                                                  totalBobot =
                                                      _calculateTotalBobot(
                                                          updatedKriteriaList);
                                                  setState(() {});
                                                  Navigator.pop(context);
                                                  showModalBottomSheet(
                                                    context: context,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                    ),
                                                    builder: (context) {
                                                      return const PopUp3(
                                                        text:
                                                            "Sukses Tertambah",
                                                        lottieAssets:
                                                            "assets/animation/checklist.json",
                                                      );
                                                    },
                                                  );
                                                },
                                                judul: "Masukkan Bobot Baru",
                                                hintText: "Masukan Bobot",
                                                buttonText: "Simpan",
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
                                        child: const Padding(
                                          padding: EdgeInsets.all(20.0),
                                          child: Icon(
                                            IconlyBold.edit,
                                            size: 26,
                                            color: AppColors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Total Bobot: ${totalBobot.toStringAsFixed(1)}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                          ],
                        );
                      },
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
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.popUntil(
                            context,
                            (route) {
                              return route.isFirst;
                            },
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.blue,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                IconlyBold.home,
                                color: AppColors.white,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Menu Utama",
                                style: GoogleFonts.lato(
                                  fontSize: 24,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
