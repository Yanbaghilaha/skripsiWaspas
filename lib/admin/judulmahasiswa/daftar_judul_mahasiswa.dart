import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:spk_app/admin/judulmahasiswa/excel_helper.dart';
import 'package:spk_app/extract_widget/top_navbar.dart';
import 'package:spk_app/material/colors.dart';
import 'lihat_judul_mahasiswa.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';

class DaftarJudulMahasiswa extends StatelessWidget {
  const DaftarJudulMahasiswa({
    super.key,
  });

  Map<String, dynamic>? getLastTentangJudul(Map<String, dynamic>? userData) {
    if (userData == null || userData.isEmpty) {
      return null;
    }

    int? maxKeyNumber;
    String? lastTentangJudulKey;

    userData.forEach((key, value) {
      if (key.startsWith('tentangJudul-')) {
        final keyNumber = int.tryParse(key.split('-').last);
        if (keyNumber != null &&
            (maxKeyNumber == null || keyNumber > maxKeyNumber!)) {
          maxKeyNumber = keyNumber;
          lastTentangJudulKey = key;
        }
      }
    });

    if (lastTentangJudulKey != null) {
      return {lastTentangJudulKey!: userData[lastTentangJudulKey!]};
    }

    return null;
  }

  //create pdf
  Future<void> createAndSavePDF(List<Map<String, dynamic>> data) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            children: [
              pw.Header(
                  level: 0,
                  text: 'Data Judul Skripsi Mahasiswa Teknik Informatika'),
              pw.Table.fromTextArray(
                headers: ['User', 'NRP', 'Kelas', 'Tema', 'Judul', 'Deskripsi'],
                data: data.map((item) {
                  return [
                    item['user'],
                    item['nrp'],
                    item['kelas'],
                    item['tema'],
                    item['judul'],
                    item['deskripsi'],
                  ];
                }).toList(),
              ),
            ],
          );
        },
      ),
    );

    Uint8List bytes = await pdf.save();

    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/example.pdf';

    final file = File(filePath);

    file.writeAsBytes(bytes);

    // Buka file PDF yang telah dibuat menggunakan aplikasi yang sesuai.
    await OpenFile.open(filePath, type: 'application/pdf');
  }

  @override
  Widget build(BuildContext context) {
    final excelHelper = ExcelHelper();
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return const Text('Terjadi kesalahan');
              }
              final users = snapshot.data?.docs ?? [];
              final usersData = users.map((user) => user.data()).toList();
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.symmetric(
                      vertical: 30,
                      horizontal: 10,
                    ),
                    child: Column(
                      children: [
                        const MyNavBar(judul: "Daftar Judul Mahasiswa"),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 590,
                          child: ListView.builder(
                            itemCount: users.length,
                            itemBuilder: (context, index) {
                              final user = users[index].data();
                              final tentangJudul = getLastTentangJudul(user);

                              if (tentangJudul != null) {
                                final nama = user['nama'] as String;
                                final nrp = user['nrp'] as String;
                                final kelas = user['kelas'] as String;
                                final tema = tentangJudul.values.first['tema']
                                        as String? ??
                                    '';
                                final judul =
                                    tentangJudul.values.first['judul'];
                                final deskripsiJudul =
                                    tentangJudul.values.first['deskripsi'];
                                final ulasan =
                                    tentangJudul.values.first['ulasan'];
                                final deskripsiUlasan = tentangJudul
                                        .values.first['deskripsiUlasan'] ??
                                    'Deskripsi Belum Diulas';
                                final docId = users[index].id;

                                final Timestamp waktu =
                                    tentangJudul.values.first['waktu'];

                                DateTime dateTime = waktu.toDate();

                                String date =
                                    DateFormat.yMMMd('en_us').format(dateTime);

                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                LihatJudulMahasiswa(
                                              tentangJudulData: user,
                                              deskripsiUlasan: deskripsiUlasan,
                                              ulasan: ulasan,
                                              judul: judul,
                                              tema: tema,
                                              deskripsi: deskripsiJudul,
                                              docId: docId,
                                              user: user,
                                              nama: nama,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        padding:
                                            const EdgeInsetsDirectional.all(20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: AppColors.whiteLight,
                                          border: Border.all(
                                            width: 2,
                                            color: AppColors.border,
                                          ),
                                        ),
                                        //content
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 1,
                                                      horizontal: 10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: AppColors.orange,
                                              ),
                                              child: Text(
                                                date,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.lato(
                                                  color: AppColors.primary,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 20),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          nama,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 20,
                                                            color:
                                                                AppColors.white,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 2),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: AppColors
                                                                    .blue,
                                                              ),
                                                              child: Text(
                                                                kelas,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    GoogleFonts
                                                                        .lato(
                                                                  fontSize: 18,
                                                                  color:
                                                                      AppColors
                                                                          .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 2),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: AppColors
                                                                    .blue,
                                                              ),
                                                              child: Text(
                                                                nrp,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    GoogleFonts
                                                                        .lato(
                                                                  fontSize: 18,
                                                                  color:
                                                                      AppColors
                                                                          .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: ulasan ==
                                                              "Diterima"
                                                          ? AppColors.green
                                                          : ulasan ==
                                                                  "Belum Diulas"
                                                              ? AppColors.border
                                                              : AppColors.red),
                                                  child: Text(
                                                    ulasan,
                                                    style: GoogleFonts.lato(
                                                      color: AppColors.white,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                const Icon(
                                                  IconlyLight.arrow_right_2,
                                                  color: AppColors.white,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 20,
                                    )
                                  ],
                                );
                              } else {
                                // Jika 'tentangJudul' tidak ada, tidak menampilkan item
                                return Container(); // Item kosong
                              }
                            },
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
                          const SizedBox(height: 30),
                          Flexible(
                            fit: FlexFit.tight,
                            child: TextButton(
                              onPressed: () async {
                                await showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  builder: (context) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        //Title
                                        Text(
                                          "Silahkan Pilih Format",
                                          style: GoogleFonts.lato(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 35,
                                          ),
                                        ),
                                        //lottie animation
                                        LottieBuilder.asset(
                                            'assets/animation/export.json'),
                                        const SizedBox(
                                          height: 40,
                                        ),

                                        //button
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            //pdf
                                            GestureDetector(
                                              onTap: () async {
                                                // Ambil data yang diterima dan buat PDF
                                                final dataDiterima = usersData
                                                    .where(
                                                      (user) {
                                                        final tentangJudul =
                                                            getLastTentangJudul(
                                                                user);
                                                        return tentangJudul !=
                                                                null &&
                                                            tentangJudul.values
                                                                        .first[
                                                                    'ulasan'] ==
                                                                'Diterima';
                                                      },
                                                    )
                                                    .toList()
                                                    .map((user) {
                                                      final userData = user;
                                                      final nama =
                                                          userData['nama']
                                                              as String;
                                                      final kelas =
                                                          userData['kelas'];
                                                      final nrp =
                                                          userData['nrp'];
                                                      final tentangJudul =
                                                          getLastTentangJudul(
                                                              userData);
                                                      final tema = tentangJudul
                                                                  ?.values
                                                                  .first['tema']
                                                              as String? ??
                                                          '';
                                                      final judul = tentangJudul
                                                          ?.values
                                                          .first['judul'];
                                                      final deskripsi =
                                                          tentangJudul?.values
                                                                  .first[
                                                              'deskripsi'];

                                                      return {
                                                        'user': nama,
                                                        'nrp': nrp,
                                                        'kelas': kelas,
                                                        'tema': tema,
                                                        'judul': judul,
                                                        'deskripsi': deskripsi,
                                                      };
                                                    })
                                                    .toList();

                                                if (dataDiterima.isNotEmpty) {
                                                  // Cetak PDF jika ada data yang diterima
                                                  await createAndSavePDF(
                                                      dataDiterima);
                                                } else {
                                                  // Tampilkan pesan jika tidak ada data yang diterima
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                        'Tidak ada data yang diterima untuk dicetak.',
                                                      ),
                                                    ),
                                                  );
                                                }
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: AppColors.red,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Cetak PDF",
                                                      style: GoogleFonts.lato(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color:
                                                              AppColors.white),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    const Icon(
                                                      PhosphorIcons
                                                          .file_pdf_fill,
                                                      color: AppColors.white,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),

                                            const SizedBox(
                                              width: 30,
                                            ),
                                            //excel
                                            GestureDetector(
                                              onTap: () async {
                                                final dataDiterima = usersData
                                                    .where(
                                                      (user) {
                                                        final tentangJudul =
                                                            getLastTentangJudul(
                                                                user);
                                                        return tentangJudul !=
                                                                null &&
                                                            tentangJudul.values
                                                                        .first[
                                                                    'ulasan'] ==
                                                                'Diterima';
                                                      },
                                                    )
                                                    .toList()
                                                    .map((user) {
                                                      final userData = user;
                                                      final nama =
                                                          userData['nama']
                                                              as String;
                                                      final nrp =
                                                          userData['nrp'];
                                                      final kelas =
                                                          userData['kelas'];
                                                      final tentangJudul =
                                                          getLastTentangJudul(
                                                              userData);
                                                      final tema = tentangJudul
                                                                  ?.values
                                                                  .first['tema']
                                                              as String? ??
                                                          '';
                                                      final judul = tentangJudul
                                                          ?.values
                                                          .first['judul'];
                                                      final deskripsi =
                                                          tentangJudul?.values
                                                                  .first[
                                                              'deskripsi'];

                                                      return {
                                                        'nama': nama,
                                                        'nrp': nrp,
                                                        'kelas': kelas,
                                                        'tema': tema,
                                                        'judul': judul,
                                                        'deskripsi': deskripsi,
                                                      };
                                                    })
                                                    .toList();
                                                excelHelper.saveDataToExcel(
                                                    dataDiterima);
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: AppColors.green,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Cetak Excel",
                                                      style: GoogleFonts.lato(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color:
                                                              AppColors.white),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    const Icon(
                                                      PhosphorIcons
                                                          .microsoft_excel_logo_fill,
                                                      color: AppColors.white,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                    // return MyPopup(
                                    //   height: 567,
                                    //   controller: TextEditingController(),
                                    //   onPressed: () async {
                                    //     // Ambil data yang diterima dan buat PDF
                                    //     final dataDiterima = usersData
                                    //         .where((user) {
                                    //           final tentangJudul =
                                    //               getLastTentangJudul(user);
                                    //           return tentangJudul != null &&
                                    //               tentangJudul.values
                                    //                       .first['ulasan'] ==
                                    //                   'Diterima';
                                    //         })
                                    //         .toList()
                                    //         .map((user) {
                                    //           final userData = user;
                                    //           final nama =
                                    //               userData['nama'] as String;
                                    //           final nrp = userData['nrp'];
                                    //           final tentangJudul =
                                    //               getLastTentangJudul(userData);
                                    //           final tema = tentangJudul
                                    //                       ?.values.first['tema']
                                    //                   as String? ??
                                    //               '';
                                    //           final judul = tentangJudul
                                    //               ?.values.first['judul'];
                                    //           final deskripsi = tentangJudul
                                    //               ?.values.first['deskripsi'];

                                    //           return {
                                    //             'user': nama,
                                    //             'nrp': nrp,
                                    //             'tema': tema,
                                    //             'judul': judul,
                                    //             'deskripsi': deskripsi,
                                    //           };
                                    //         })
                                    //         .toList();

                                    //     if (dataDiterima.isNotEmpty) {
                                    //       // Cetak PDF jika ada data yang diterima
                                    //       await createAndSavePDF(dataDiterima);
                                    //       print(dataDiterima);
                                    //     } else {
                                    //       // Tampilkan pesan jika tidak ada data yang diterima
                                    //       ScaffoldMessenger.of(context)
                                    //           .showSnackBar(
                                    //         const SnackBar(
                                    //           content: Text(
                                    //             'Tidak ada data yang diterima untuk dicetak.',
                                    //           ),
                                    //         ),
                                    //       );
                                    //     }
                                    //     Navigator.pop(context);
                                    //   },
                                    //   judul:
                                    //       "Anda Akan Mencetak Data Mahasiswa Yang Sudah Diterima",
                                    //   hintText: "",
                                    //   isTextField: false,
                                    //   imageAssets:
                                    //       "assets/animation/review.json",
                                    //   buttonText: "Cetak",
                                    // );
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
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    "Cetak Data",
                                    style: GoogleFonts.lato(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
