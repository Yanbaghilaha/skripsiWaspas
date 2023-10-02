// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:spk_app/extract_widget/percentage_matkul.dart';

import '../../extract_widget/pop_up_success.dart';
import '../../extract_widget/top_navbar.dart';
import '../../material/colors.dart';
import '../alternatifOrTemaSkripsi/daftar_tema_skripsi.dart';

class LihatJudulMahasiswa extends StatefulWidget {
  final Map<String, dynamic> user;
  final Map<String, dynamic> tentangJudulData;

  final String docId, nama, tema, judul, ulasan, deskripsi, deskripsiUlasan;
  const LihatJudulMahasiswa({
    super.key,
    required this.nama,
    required this.judul,
    required this.tema,
    required this.docId,
    required this.user,
    required this.ulasan,
    required this.deskripsi,
    required this.tentangJudulData,
    required this.deskripsiUlasan,
  });

  @override
  State<LihatJudulMahasiswa> createState() => _LihatJudulMahasiswaState();
}

Map<String, dynamic> hasilPerankingan = {};

class _LihatJudulMahasiswaState extends State<LihatJudulMahasiswa> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(widget.docId)
          .snapshots(),
      builder: (context, snapshot) {
        List<MapEntry<String, dynamic>> tentangJudulEntries = widget
            .tentangJudulData.entries
            .where((entry) => entry.key.startsWith('tentangJudul-'))
            .toList();

        Stream<Map<String, dynamic>> getDataStream() {
          final currentUser = widget.docId;

          if (currentUser != null) {
            final firestore = FirebaseFirestore.instance;
            final userDocRef = firestore.collection('users').doc(currentUser);

            // Menggunakan snapshots() untuk mendengarkan perubahan di dokumen
            return userDocRef.snapshots().map((docSnapshot) {
              if (docSnapshot.exists) {
                return docSnapshot.data()?['hasilPerankingan']
                    as Map<String, dynamic>;
              } else {
                return {}; // Kembalikan objek kosong jika dokumen tidak ditemukan
              }
            });
          } else {
            // Kembalikan Stream kosong jika pengguna belum masuk
            return const Stream.empty();
          }
        }

        String namaDepan = (widget.nama).split(' ')[0];

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
                      MyNavBar(judul: namaDepan.toString()),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                          height: 625,
                          child: ListView.builder(
                            itemCount: tentangJudulEntries
                                .length, // Menggunakan jumlah entri yang sudah diurutkan
                            itemBuilder: (context, index) {
                              final entry = tentangJudulEntries[
                                  index]; // Mengambil entri yang sesuai dengan indeks

                              final tentangJudul =
                                  entry.value as Map<String, dynamic>;

                              final tema = tentangJudul['tema'] ?? '';
                              final deskripsi = tentangJudul['deskripsi'] ?? '';
                              final judul = tentangJudul['judul'] ?? '';
                              final ulasan = tentangJudul['ulasan'] ?? '';
                              final deskripsiUlasan =
                                  tentangJudul['deskripsiUlasan'] ??
                                      'Belum Diulas';
                              final Timestamp waktu = tentangJudul['waktu'];

                              return Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppColors.whiteLight,
                                      border: Border.all(
                                        width: 2,
                                        color: AppColors.border,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: ExpansionTile(
                                        tilePadding: EdgeInsets.zero,
                                        title: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: AppColors.blue,
                                              ),
                                              padding: const EdgeInsets.all(8),
                                              child: Center(
                                                child: Text(
                                                  "${index + 1}", // Menambahkan 1 untuk indeks yang sesuai
                                                  style: GoogleFonts.lato(
                                                    color: AppColors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    judul,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.lato(
                                                      color: AppColors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  // Keterangan tema & ulasan
                                                  Row(
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AppColors.blue,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            vertical: 10,
                                                            horizontal: 10,
                                                          ),
                                                          child: Text(
                                                            tema,
                                                            style: GoogleFonts
                                                                .lato(
                                                              color: AppColors
                                                                  .white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                        width: 2,
                                                        height: 20,
                                                        color: AppColors.border,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: ulasan ==
                                                                  "Belum Diulas"
                                                              ? AppColors.border
                                                              : ulasan ==
                                                                      "Diterima"
                                                                  ? AppColors
                                                                      .green
                                                                  : AppColors
                                                                      .red,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            vertical: 10,
                                                            horizontal: 10,
                                                          ),
                                                          child: Text(
                                                            ulasan,
                                                            style: GoogleFonts
                                                                .lato(
                                                              color: AppColors
                                                                  .white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        expandedAlignment: Alignment.centerLeft,
                                        children: [
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                width: 2,
                                                color: AppColors.border,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Judul",
                                                    style: GoogleFonts.lato(
                                                      color: AppColors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    height: 1,
                                                    color: AppColors.border,
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  Text(
                                                    judul,
                                                    style: GoogleFonts.lato(
                                                      color: AppColors.white,
                                                      fontSize: 18,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                width: 2,
                                                color: AppColors.border,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Deskripsi Judul",
                                                    style: GoogleFonts.lato(
                                                      color: AppColors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    height: 1,
                                                    color: AppColors.border,
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  Text(
                                                    deskripsi,
                                                    style: GoogleFonts.lato(
                                                      color: AppColors.white,
                                                      fontSize: 18,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                width: 2,
                                                color: AppColors.border,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Deskripsi Ulasan",
                                                    style: GoogleFonts.lato(
                                                      color: AppColors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    height: 1,
                                                    color: AppColors.border,
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  Text(
                                                    deskripsiUlasan,
                                                    style: GoogleFonts.lato(
                                                      color: deskripsiUlasan ==
                                                              'Belum Diulas'
                                                          ? AppColors.red
                                                          : AppColors.green,
                                                      fontSize: 18,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              final judulKey = entry.key;
                                              await showModalBottomSheet(
                                                isScrollControlled: true,
                                                context: context,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                builder: (context) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      top: 80,
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        const MyNavBar(
                                                          judul: "Beri Ulasan",
                                                          textColor:
                                                              AppColors.primary,
                                                        ),
                                                        UlasanModalSheet(
                                                          waktu: waktu,
                                                          judul: judul,
                                                          tema: tema,
                                                          deskripsi: deskripsi,
                                                          judulKey: judulKey,
                                                          docId: widget.docId,
                                                          onUlasanSaved:
                                                              (ulasan,
                                                                  deskripsi) {
                                                            setState(() {});
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: AppColors.blue,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 20,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Ulaskan",
                                                    style: GoogleFonts.lato(
                                                      color: AppColors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 20,
                                  )
                                ],
                              );
                            },
                          )),
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
                          child: StreamBuilder<Map<String, dynamic>>(
                              stream: getDataStream(),
                              builder: (context, snapshot) {
                                final hasilPerankingan = snapshot.data ?? {};

                                // Konversi hasilPerankingan menjadi daftar pasangan kunci-nilai
                                final sortedList =
                                    hasilPerankingan.entries.toList();

                                // Urutkan daftar berdasarkan nilai (dalam urutan menurun)
                                sortedList
                                    .sort((a, b) => b.value.compareTo(a.value));
                                return TextButton(
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: AppColors.primary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          content: SizedBox(
                                            width: 500,
                                            child: Column(
                                              children: [
                                                hasilPerankingan.isNotEmpty
                                                    ? Expanded(
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              child: Text(
                                                                "${widget.nama} Memiliki Kemampuan Yang Mumpuni Pada Tema:",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    GoogleFonts
                                                                        .lato(
                                                                  color: AppColors
                                                                      .orange,
                                                                  fontSize: 21,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 30,
                                                            ),
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: AppColors
                                                                    .orange,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        20,
                                                                    horizontal:
                                                                        20),
                                                                child: Text(
                                                                  sortedList[0]
                                                                      .key
                                                                      .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      GoogleFonts
                                                                          .lato(
                                                                    color:
                                                                        AppColors
                                                                            .blue,
                                                                    fontSize:
                                                                        24,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            //end
                                                            const SizedBox(
                                                              height: 30,
                                                            ),

                                                            //percentage
                                                            Flexible(
                                                              child: ListView
                                                                  .separated(
                                                                itemCount:
                                                                    sortedList
                                                                        .length,
                                                                separatorBuilder:
                                                                    (context,
                                                                        index) {
                                                                  return Container(
                                                                    color: Colors
                                                                        .white10,
                                                                    width: double
                                                                        .infinity,
                                                                    height: 1,
                                                                  );
                                                                },
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  final matkul =
                                                                      sortedList[
                                                                              index]
                                                                          .key;
                                                                  final nilai =
                                                                      sortedList[
                                                                              index]
                                                                          .value
                                                                          .toString();
                                                                  final lengthPercent =
                                                                      double.tryParse(
                                                                          nilai);
                                                                  return PercentageMatkul(
                                                                    forHistory:
                                                                        true,
                                                                    namaMatkul:
                                                                        matkul,
                                                                    percentage:
                                                                        nilai,
                                                                    lengthPercent:
                                                                        lengthPercent
                                                                            as double,
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Container(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        20,
                                                                    horizontal:
                                                                        30),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color:
                                                                      AppColors
                                                                          .red,
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    const Icon(
                                                                      IconlyBold
                                                                          .arrow_left_circle,
                                                                      color: AppColors
                                                                          .white,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 20,
                                                                    ),
                                                                    Text(
                                                                      "Kembali",
                                                                      style: GoogleFonts
                                                                          .lato(
                                                                        fontSize:
                                                                            20,
                                                                        color: AppColors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                    const Icon(
                                                                        null)
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    : Expanded(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "Maaf Mahasiswa Belum Mengisi Kuesioner",
                                                              style: GoogleFonts
                                                                  .lato(
                                                                color: AppColors
                                                                    .orange,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 25,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                            LottieBuilder.asset(
                                                                'assets/animation/no-data.json'),
                                                          ],
                                                        ),
                                                      ),
                                                // close button
                                              ],
                                            ),
                                          ),
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
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        "Lihat Hasil Kuesioner",
                                        style: GoogleFonts.lato(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w800,
                                          color: AppColors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ); //button ulaskan
      },
    );
  }
}

class UlasanModalSheet extends StatefulWidget {
  final String docId, judulKey, judul, tema, deskripsi;
  final Timestamp waktu;
  final Function(String, String) onUlasanSaved;

  const UlasanModalSheet({
    Key? key,
    required this.onUlasanSaved,
    required this.waktu,
    required this.docId,
    required this.judulKey,
    required this.judul,
    required this.tema,
    required this.deskripsi,
  }) : super(key: key);

  @override
  _UlasanModalSheetState createState() => _UlasanModalSheetState();
}

class _UlasanModalSheetState extends State<UlasanModalSheet> {
  String selectedUlasan = "";
  String deskripsiUlasan = "";

  final List<List<dynamic>> ulaskanOptions = [
    ['Ditolak', false],
    ['Diterima', false],
  ];

  void selectUlasan(int index) {
    setState(() {
      selectedUlasan = ulaskanOptions[index][0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          height: 821,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (int i = 0; i < ulaskanOptions.length; i++)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.blue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: RadioListTile(
                      controlAffinity: ListTileControlAffinity.trailing,
                      title: Text(
                        ulaskanOptions[i][0],
                        style: GoogleFonts.lato(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      value: ulaskanOptions[i][0],
                      activeColor: AppColors.white,
                      groupValue: selectedUlasan,
                      onChanged: (value) => selectUlasan(i),
                    ),
                  ),
                ),
              const SizedBox(height: 30.0),
              Text(
                "Masukan Deskripsi Ulasan",
                style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                onChanged: (value) {
                  deskripsiUlasan = value;
                },
                autocorrect: false,
                autofocus: true,
                maxLines: 5,
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  hintText: "Masukan Deskripsi Ulasan",
                  hintStyle: GoogleFonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black26,
                  ),
                  contentPadding: const EdgeInsets.all(20),
                  border: InputBorder.none,
                  fillColor: AppColors.white2,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.white60,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding:
                const EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 20),
            decoration: const BoxDecoration(
              // color: AppColors.primary,
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
                              widget.onUlasanSaved(
                                selectedUlasan,
                                deskripsiUlasan,
                              );
                              if (selectedUlasan.isEmpty) {
                                return showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  builder: (context) {
                                    return const PopUp3(
                                      text: "Pastikan Pilih Ulasan",
                                      buttonText: "OK",
                                      isTwoTimes: false,
                                      textColor: AppColors.violet,
                                      lottieAssets:
                                          "assets/animation/sad-animation.json",
                                    );
                                  },
                                );
                              }

                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(widget.docId)
                                  .update({
                                widget.judulKey: {
                                  'ulasan': selectedUlasan,
                                  'deskripsiUlasan': deskripsiUlasan,
                                  'tema': widget.tema,
                                  'deskripsi': widget.deskripsi,
                                  'judul': widget.judul,
                                  'waktu': widget.waktu,
                                }
                              });

                              Navigator.pop(context);

                              showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                builder: (context) {
                                  return const PopUp3(
                                    text: "Sukses Ditambahkan",
                                    lottieAssets:
                                        "assets/animation/checklist.json",
                                  );
                                },
                              );
                            },
                            judul: "Apakah Anda Yakin Ingin Mengulaskan?",
                            hintText: "",
                            isTextField: false,
                            imageAssets: "assets/animation/review.json",
                            buttonText: "Ulaskan",
                          );
                        },
                      );
                      setState(() {});
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
                          "Ulaskan",
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
  }
}
