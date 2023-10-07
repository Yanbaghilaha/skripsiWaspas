import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:spk_app/admin/tambah_data_kriteria.dart';
import 'package:spk_app/extract_widget/top_navbar.dart';

import '../extract_widget/pop_up_success.dart';
import '../material/colors.dart';
import 'alternatifOrTemaSkripsi/daftar_tema_skripsi.dart';
import 'bobot/edit_bobot.dart';
import 'details_kriteria.dart';

class DaftarKriteria extends StatefulWidget {
  const DaftarKriteria({
    super.key,
  });

  @override
  State<DaftarKriteria> createState() => _DaftarKriteriaState();
}

class _DaftarKriteriaState extends State<DaftarKriteria> {
  @override
  Widget build(BuildContext context) {
    final CollectionReference kriteriaCollection =
        FirebaseFirestore.instance.collection('kriteria');

    Future<void> hapusKriteria(String kriteriaName) async {
      try {
        QuerySnapshot querySnapshot = await kriteriaCollection
            .where('nama', isEqualTo: kriteriaName)
            .get();
        for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
          await docSnapshot.reference.delete();
        }
        print('Data kriteria $kriteriaName berhasil dihapus.');
      } catch (e) {
        print('Error: $e');
      }
    }

    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Column(
              children: [
                //Judul
                const MyNavBar(judul: "Daftar Data Kriteria"),

                const SizedBox(
                  height: 30,
                ),

                //edit bobot button
                SizedBox(
                  height: 70,
                  child: Row(
                    children: [
                      //edit bobot
                      Flexible(
                        flex: 5,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditBobot(),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Edit Bobot",
                                  style: GoogleFonts.lato(
                                    fontSize: 20,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //edit button
                      const SizedBox(
                        width: 10,
                      ),
                      //bobot
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditBobot(),
                              ),
                            );
                          },
                          child: Container(
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.orange,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              IconlyBold.edit,
                              color: AppColors.blue,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                //
                Container(
                  width: double.infinity,
                  height: 5,
                  color: AppColors.whiteLight,
                ),
                //daftar data kriteria
                const SizedBox(
                  height: 16,
                ),

                //list kriteria
                SizedBox(
                  height: 510,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('kriteria')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final docs = snapshot.data!.docs;
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          final doc = docs[index];
                          final data = doc.data() as Map<String, dynamic>;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //tampil data
                              Flexible(
                                flex: 10,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailsDataKriteria(
                                          documentId: doc.id,
                                          nama: data['nama'],
                                          jenis: data['jenis'],
                                          bobot: data['bobot'],
                                          subKriteria: data['subKriteria'],
                                        ),
                                      ),
                                    );
                                  },
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
                                        data['nama'].toString(),
                                        style: GoogleFonts.lato(
                                          fontSize: 18,
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w800,
                                        ),
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailsDataKriteria(
                                            documentId: doc.id,
                                            nama: data['nama'],
                                            jenis: data['jenis'],
                                            bobot: data['bobot'],
                                            subKriteria: data['subKriteria'],
                                          ),
                                        ),
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

                              //hapus (*)
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
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        builder: (BuildContext context) {
                                          return MyPopup(
                                            isTextField: false,
                                            height: 507,
                                            imageAssets:
                                                "assets/animation/sad-animation.json",
                                            controller: TextEditingController(),
                                            buttonColor: AppColors.red,
                                            onPressed: () async {
                                              hapusKriteria(data['nama']);

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
                        itemCount: docs.length,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          //tombol tambah kriteria
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const TambahDataKriteria();
                          }),
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
                              "Tambah Kriteria",
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
