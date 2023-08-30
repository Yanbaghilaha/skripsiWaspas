import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:spk_app/admin/judulmahasiswa/lihat_judul_mahasiswa.dart';
import 'package:spk_app/extract_widget/top_navbar.dart';
import 'package:spk_app/material/colors.dart';

class DaftarJudulMahasiswa extends StatefulWidget {
  const DaftarJudulMahasiswa({super.key});

  @override
  State<DaftarJudulMahasiswa> createState() => _DaftarJudulMahasiswaState();
}

class _DaftarJudulMahasiswaState extends State<DaftarJudulMahasiswa> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (!snapshot.hasData) {
            return const Text('No data available');
          }

          final users = snapshot.data!.docs;

          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: Column(
                  children: [
                    const MyNavBar(judul: "Daftar Judul Mahasiswa"),
                    const SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final userData =
                              users[index].data() as Map<String, dynamic>;
                          final nama = userData['nama'] ?? 'Unknown';
                          final tentangJudulData =
                              userData['tentangJudul'] ?? {};
                          // final judul = tentangJudulData['judul'] ?? '';
                          final tema = tentangJudulData['tema'] ?? '';
                          // final deskripsi = tentangJudulData['deskripsi'] ?? '';
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LihatJudulMahasiswa(
                                    nama: nama,
                                    judul:
                                        userData['tentangJudul']['judul'] ?? '',
                                    tema: tema,
                                    tentangJudul: userData['tentangJudul']
                                            ['deskripsi'] ??
                                        '',
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              height: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: AppColors.border,
                                ),
                                color: Colors.white10,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          nama,
                                          style: GoogleFonts.lato(
                                            color: AppColors.white,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 24,
                                          ),
                                        ),
                                        Text(
                                          tema,
                                          style: GoogleFonts.lato(
                                            color: Colors.white54,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Icon(
                                      IconlyLight.arrow_right,
                                      size: 24,
                                      color: AppColors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 20,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
