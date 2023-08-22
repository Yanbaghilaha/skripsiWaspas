// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iconly/iconly.dart';
import 'package:spk_app/extract_widget/pop_up_success.dart';
import 'package:spk_app/extract_widget/top_navbar.dart';
import 'package:spk_app/material/colors.dart';

import '../../extract_widget/text_field3.dart';
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

  //baca data kriteria -> bobot
  Future<QuerySnapshot<Map<String, dynamic>>> _getData() async {
    return FirebaseFirestore.instance.collection('kriteria').get();
  }

  //kalkulasi penjulahan bobot
  double totalBobot = 0.0;
  void calculateTotalBobot(List<Map<String, dynamic>> kriteriaList) {
    double total = 0.0;
    for (var kriteria in kriteriaList) {
      total += kriteria['bobot'];
    }
    setState(() {
      totalBobot = total;
    });
  }

  void _updateBobot(String docId, double newBobot) async {
    try {
      await FirebaseFirestore.instance
          .collection('kriteria')
          .doc(docId)
          .update({'bobot': newBobot});
      print('Bobot berhasil diperbarui di Firestore.$newBobot');
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
            Padding(
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

                  //textbutton
                  Flexible(
                    child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      future: _getData(),
                      builder: (context, snapshot) {
                        final kriteriaList = snapshot.data?.docs ?? [];
                        return ListView.separated(
                          itemBuilder: (context, index) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            }

                            final kriteria = kriteriaList[index].data();
                            final kriteriaDocRef =
                                kriteriaList[index].reference;
                            double newBobot =
                                double.parse(kriteria['bobot'].toString());

                            return Row(
                              children: [
                                Flexible(
                                  child: MyTextField3(
                                    kriteria: kriteria['nama'],
                                    bobot: kriteria['bobot'].toString(),
                                  ),
                                ),

                                const SizedBox(
                                  width: 10,
                                ),

                                //edit button
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      builder: (BuildContext context) {
                                        return MyPopup(
                                          isTextField: true,
                                          height: 307,
                                          imageAssets:
                                              "assets/animation/sad-animation.json",
                                          controller: TextEditingController(
                                            text: controller.text,
                                          ),
                                          buttonColor: AppColors.blue,
                                          onChange: (newVal) {
                                            newBobot = double.parse(newVal);
                                          },
                                          onPressed: () {
                                            _updateBobot(
                                              kriteriaDocRef.id,
                                              newBobot,
                                            );
                                            setState(() {});

                                            Navigator.pop(context);
                                            showModalBottomSheet(
                                              context: context,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              builder: (context) {
                                                return const PopUp3(
                                                  text: "Sukses Tertambah",
                                                  lottieAssets:
                                                      "assets/animation/checklist.json",
                                                );
                                              },
                                            );
                                          },
                                          judul: "Masukkan Bobot Baru",
                                          hintText: "Masukan Bobot",
                                          buttonText: "Simpan",
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.blue,
                                      borderRadius: BorderRadius.circular(10),
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
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                          itemCount: kriteriaList.length,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Padding(
            //     padding: const EdgeInsets.all(20),
            //     child: Text(
            //       'Total Bobot: ${totalBobot.toStringAsFixed(2)}',
            //       style: TextStyle(
            //         fontSize: 16,
            //         fontWeight: FontWeight.bold,
            //         color: _getTextColor(totalBobot),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
