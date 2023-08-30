// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spk_app/extract_widget/text_field.dart';
import 'package:spk_app/extract_widget/top_navbar.dart';
import 'package:spk_app/loading_screen/loading_screen_upload.dart';

import '../extract_widget/tema_skripsi.dart';
import '../material/colors.dart';

// class MasukanJudul extends StatefulWidget {
//   const MasukanJudul({super.key});

//   @override
//   State<MasukanJudul> createState() => _MasukanJudulState();
// }

// class _MasukanJudulState extends State<MasukanJudul> {
//   String activeUserEmail = ""; // Simpan email user yang aktif
//   final TextEditingController judul = TextEditingController();
//   final TextEditingController deskripsiJudul = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _getActiveUserEmail(); // Panggil metode untuk mendapatkan email user yang aktif
//     getTemaSkripsiData(); // Panggil metode untuk mengambil data tema skripsi dari Firestore
//   }

//   void _getActiveUserEmail() {
//     // Mendapatkan informasi user yang sedang aktif dari Firebase Authentication
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       setState(() {
//         activeUserEmail = user.email ?? ""; // Simpan email user yang aktif
//       });
//     }
//   }

//   void simpanData() async {
//     try {
//       // Data yang akan disimpan ke Firestore
//       final newData = {
//         'nama': activeUserEmail,
//         'tentangJudul': {
//           'deskripsi': deskripsiJudul.text,
//           'judul': judul.text,
//           'tema': temaSkripsi.firstWhere((item) => item['isSelected'],
//               orElse: () => {'nama': ''})['nama'],
//         },
//       };

//       // Simpan data ke Firestore pada koleksi user yang aktif
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(activeUserEmail)
//           .set(newData);

//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const LoadingScreen2()),
//       );
//     } catch (error) {
//       print('Error saving data: $error');
//     }
//   }

//   List<Map<String, dynamic>> temaSkripsi = [];

//   void getTemaSkripsiData() async {
//     try {
//       final QuerySnapshot querySnapshot =
//           await FirebaseFirestore.instance.collection('alternatif').get();

//       final List<Map<String, dynamic>> fetchedTemaSkripsi =
//           querySnapshot.docs.map((doc) => {doc.id: doc.data()}).toList();

//       setState(() {
//         temaSkripsi = fetchedTemaSkripsi;
//       });
//     } catch (error) {
//       print('Error fetching tema skripsi data: $error');
//     }
//     print(temaSkripsi);
//   }

//   void temaTypeSelected(int index) {
//     setState(() {
//       for (int i = 0; i < temaSkripsi.length; i++) {
//         temaSkripsi[i]['isSelected'] = false;
//       }
//       temaSkripsi[index]['isSelected'] = true;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
//               child: Column(
//                 children: [
//                   //Judul screen
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                         child: const Icon(
//                           IconlyLight.arrow_left_2,
//                           color: AppColors.white,
//                           size: 24,
//                         ),
//                       ),
//                       SizedBox(
//                         child: Center(
//                           child: Text(
//                             "Masukan Judul Kamu",
//                             style: GoogleFonts.lato(
//                                 fontSize: 26,
//                                 fontWeight: FontWeight.w900,
//                                 color: AppColors.orange),
//                           ),
//                         ),
//                       ),
//                       const Icon(null),
//                     ],
//                   ),

//                   //end judul halaman
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   //masukan Tema skripsi
//                   SizedBox(
//                     height: 100,
//                     width: double.infinity,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Masukan Tema",
//                           style: GoogleFonts.lato(
//                             color: AppColors.white,
//                             fontSize: 22,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 16,
//                         ),

//                         //button
//                         Expanded(
//                           child: ListView.separated(
//                             scrollDirection: Axis.horizontal,
//                             itemBuilder: (context, index) {
//                               final temaText = temaSkripsi.keys
//                                   .elementAt(index); // Ambil teks tema skripsi
//                               final isSelected = temaSkripsi[temaText] ??
//                                   false; // Ambil status seleksi

//                               return TemaSkripsi(
//                                 text: temaText,
//                                 isSelected: isSelected,
//                                 onTap: () {
//                                   temaTypeSelected(index);
//                                 },
//                               );
//                             },
//                             separatorBuilder: (context, index) {
//                               return const SizedBox(
//                                 width: 10,
//                               );
//                             },
//                             itemCount: temaSkripsi.length,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   //end tema skripsi
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   //Texfield
//                   SizedBox(
//                     width: double.infinity,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Input Deskripsi Judul",
//                           style: GoogleFonts.lato(
//                             color: AppColors.white,
//                             fontSize: 22,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 16,
//                         ),
//                         MyTextField(
//                           onChanged: (value) {},
//                           controller: judul,
//                           hintText: "Masukan Judul Anda Disini...",
//                           labelText: "Judul Anda...",
//                           maxLines: 1,
//                         ),
//                         const SizedBox(
//                           height: 16,
//                         ),
//                         MyTextField(
//                           onChanged: (value) {},
//                           controller: deskripsiJudul,
//                           hintText: "Deskripsi Judul Anda...",
//                           labelText: "Dekripsi Judul Anda...",
//                           maxLines: 5,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 padding: const EdgeInsets.only(
//                     left: 10, right: 10, bottom: 20, top: 20),
//                 decoration: const BoxDecoration(
//                   color: AppColors.primary,
//                   border: Border(
//                     top: BorderSide(
//                       color: Color(0xff2A3244),
//                     ),
//                   ),
//                 ),
//                 child: Row(
//                   children: [
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     Flexible(
//                       fit: FlexFit.tight,
//                       child: TextButton(
//                         onPressed: () {
//                           simpanData();
//                           // Navigator.push(
//                           //   context,
//                           //   MaterialPageRoute(
//                           //     builder: (context) => const LoadingScreen2(),
//                           //   ),
//                           // );
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 10,
//                             vertical: 20,
//                           ),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: AppColors.violet,
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "Berikan Ke Kaprodi",
//                                 style: GoogleFonts.lato(
//                                     fontSize: 24,
//                                     fontWeight: FontWeight.w800,
//                                     color: AppColors.white),
//                                 textAlign: TextAlign.center,
//                               ),
//                               const SizedBox(
//                                 width: 10,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class MasukanJudul extends StatefulWidget {
  const MasukanJudul({Key? key}) : super(key: key);

  @override
  _MasukanJudulState createState() => _MasukanJudulState();
}

class _MasukanJudulState extends State<MasukanJudul> {
  String activeUserEmail = ""; // Simpan email user yang aktif
  final TextEditingController judul = TextEditingController();
  final TextEditingController deskripsiJudul = TextEditingController();
  Map<String, bool> temaSkripsi =
      {}; // Gunakan Map<String, bool> untuk tema skripsi
  String selectedTema = "";

  @override
  void initState() {
    super.initState();
    getUserInfo();
    getTemaSkripsiData();
  }

  void getUserInfo() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        activeUserEmail = user.email ?? "";
      });
    }
  }

  void getTemaSkripsiData() async {
    try {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('alternatif').get();

      final fetchedTemaSkripsi = querySnapshot.docs
          .map((doc) => doc.id)
          .toList()
          .cast<String>(); // Ambil daftar tema skripsi dari dokumen

      setState(() {
        temaSkripsi = {for (var item in fetchedTemaSkripsi) item: false};
      });
    } catch (error) {
      print('Error fetching tema skripsi data: $error');
    }
  }

  void temaTypeSelected(String tema) {
    setState(() {
      temaSkripsi.updateAll(
          (key, value) => false); // Setel semua tema menjadi tidak terpilih
      temaSkripsi[tema] = true; // Setel tema yang dipilih menjadi terpilih
      selectedTema = tema; // Simpan tema yang dipilih
    });
  }

  bool isJudulEmpty = false; // State untuk menandai apakah judul kosong
  bool isDeskripsiEmpty = false;

  void simpanData() async {
    // Validasi input judul dan deskripsi
    if (judul.text.isEmpty) {
      setState(() {
        isJudulEmpty = true;
      });
      return;
    } else {
      setState(() {
        isJudulEmpty = false;
      });
    }

    if (deskripsiJudul.text.isEmpty) {
      setState(() {
        isDeskripsiEmpty = true;
      });
      return;
    } else {
      setState(() {
        isDeskripsiEmpty = false;
      });
    }

    try {
      final newData = {
        'tentangJudul': {
          'deskripsi': deskripsiJudul.text,
          'judul': judul.text,
          'tema': selectedTema,
        },
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc(activeUserEmail)
          .update(
              newData); // Menggunakan update untuk memperbarui dokumen yang sudah ada

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoadingScreen2()),
      );
    } catch (error) {
      print('Error saving data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: Column(
                children: [
                  const MyNavBar(judul: "Input Judul Kamu"),

                  const SizedBox(
                    height: 20,
                  ),
                  // masukan Tema skripsi
                  SizedBox(
                    height: 350,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Masukan Tema",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Expanded(
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final tema = temaSkripsi.keys.elementAt(index);
                              return TemaSkripsi(
                                text: tema,
                                isSelected: temaSkripsi[tema] ?? false,
                                onTap: () {
                                  temaTypeSelected(tema);
                                },
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                width: 10,
                              );
                            },
                            itemCount: temaSkripsi.length,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Input Judul",
                                style: GoogleFonts.lato(
                                  color: AppColors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              MyTextField(
                                onChanged: (value) {},
                                controller: judul,
                                hintText: "Masukan Judul Anda Disini...",
                                labelText: "Judul Anda...",
                                maxLines: 1,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                "Input Deskripsi Judul",
                                style: GoogleFonts.lato(
                                  color: AppColors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              MyTextField(
                                onChanged: (value) {},
                                controller: deskripsiJudul,
                                hintText: "Deskripsi Judul Anda...",
                                labelText: "Dekripsi Judul Anda...",
                                maxLines: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ... (kode lainnya)
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
                          simpanData();
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
                                "Berikan Ke Kaprodi",
                                style: GoogleFonts.lato(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.white),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                width: 10,
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
