import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:spk_app/skala_opini/introduction1.dart';
import 'admin/daftar_kriteria.dart';
import 'admin/alternatifOrTemaSkripsi/daftar_tema_skripsi.dart';
import 'admin/judulmahasiswa/daftar_judul_mahasiswa.dart';
import 'daftar_judul_skripsi.dart';
import 'extract_widget/admin_menu.dart';
import 'extract_widget/menu_list.dart';
import 'extract_widget/menu_list2.dart';
import 'extract_widget/percentage_matkul.dart';
import 'extract_widget/pop_up.dart';
import 'material/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final currentUser = FirebaseAuth.instance.currentUser;
  late final TextEditingController controller;

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  late User? currentUser1;
  String? userRole; // "admin" atau "user"

  @override
  void initState() {
    super.initState();
    currentUser1 = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      _getUserRole(currentUser!.email!);
    }
  }

  // Mengambil data pengguna dari Firestore dan memeriksa peran
  Future<void> _getUserRole(String email) async {
    try {
      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection("users").doc(email).get();

      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        userRole = userData['nama'] == "Admin" ? "admin" : "user";
        setState(() {});
      } else {
        print("User data not found");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void signOutAndNavigateToLogin(BuildContext context) {
    FirebaseAuth.instance.signOut();
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(currentUser?.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data?.data() as Map<String, dynamic>;

            final namaDepan = (userData['nama'] as String).split(' ')[0];

            String;

            return SafeArea(
              bottom: false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //welcome
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Selamat Datang",
                                style: GoogleFonts.lato(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                namaDepan,
                                style: GoogleFonts.lato(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),

                        //button profile
                        GestureDetector(
                          onTap: () async {
                            await showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              context: context,
                              builder: (BuildContext build) {
                                return PopUp(
                                  controller: TextEditingController(),
                                  lottieAssetsVisible: true,
                                  isTextField: false,
                                  height: 436,
                                  namaTema: "Anda Yakin Ingin Logout?",
                                  hintTextTextField: "Tambah Tema Skripsi",
                                  showSuffixIconTextField: false,
                                  textButton: "Logout",
                                  buttonColor: AppColors.red,
                                  onDeletePressed: () {
                                    signOut();
                                    Navigator.pop(context);
                                  },
                                  lottieAssets: "assets/animation/logout.json",
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.red),
                            child: const Icon(
                              IconlyLight.logout,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    if (userRole == "admin")
                      //admin
                      const AdminWidget()
                    else if (userRole == "user")
                      //user
                      const UserWidget(),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error$snapshot"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<User?>('currentUser', currentUser));
  }
}

class UserWidget extends StatefulWidget {
  const UserWidget({
    super.key,
  });

  @override
  State<UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  Map<String, dynamic> hasilPerankingan = {};

  Stream<Map<String, dynamic>> getDataStream() {
    final user = FirebaseAuth.instance.currentUser;
    final currentUser = user?.email;

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

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView(
        children: [
          // Buat User
          Column(
            children: [
              StreamBuilder<Map<String, dynamic>>(
                  stream: getDataStream(),
                  builder: (context, snapshot) {
                    final hasilPerankingan = snapshot.data ?? {};

                    // Konversi hasilPerankingan menjadi daftar pasangan kunci-nilai
                    final sortedList = hasilPerankingan.entries.toList();

                    // Urutkan daftar berdasarkan nilai (dalam urutan menurun)
                    sortedList.sort((a, b) => b.value.compareTo(a.value));

                    return MenuList(
                      leftButton: "Riwayat",
                      tombolRiwayat: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
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
                                                  width: double.infinity,
                                                  child: Text(
                                                    "Selamat!!",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.lato(
                                                      color: AppColors.white,
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Text(
                                                    "Anda memiliki kemampuan yang mumpuni pada tema skripsi:",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.lato(
                                                      color: AppColors.white,
                                                      fontSize: 21,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: AppColors.orange,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 20,
                                                        horizontal: 20),
                                                    child: Text(
                                                      sortedList[0]
                                                          .key
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.lato(
                                                        color: AppColors.blue,
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.w900,
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
                                                  child: ListView.separated(
                                                    itemCount:
                                                        sortedList.length,
                                                    separatorBuilder:
                                                        (context, index) {
                                                      return Container(
                                                        color: Colors.white10,
                                                        width: double.infinity,
                                                        height: 1,
                                                      );
                                                    },
                                                    itemBuilder:
                                                        (context, index) {
                                                      final matkul =
                                                          sortedList[index].key;
                                                      final nilai =
                                                          sortedList[index]
                                                              .value
                                                              .toString();
                                                      final lengthPercent =
                                                          double.tryParse(
                                                              nilai);
                                                      return PercentageMatkul(
                                                        forHistory: true,
                                                        namaMatkul: matkul,
                                                        percentage: nilai,
                                                        lengthPercent:
                                                            lengthPercent
                                                                as double,
                                                      );
                                                    },
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 20,
                                                        horizontal: 30),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: AppColors.red,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Icon(
                                                          IconlyBold
                                                              .arrow_left_circle,
                                                          color:
                                                              AppColors.white,
                                                        ),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        Text(
                                                          "Kembali",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 20,
                                                            color:
                                                                AppColors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        const Icon(null)
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
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Anda Belum Mengisi Kuesioner",
                                                  style: GoogleFonts.lato(
                                                    color: AppColors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 25,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                LottieBuilder.asset(
                                                    'assets/animation/no-data.json'),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            vertical: 20,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color:
                                                                AppColors.red,
                                                          ),
                                                          child: const Icon(
                                                            IconlyBold
                                                                .arrow_left_circle,
                                                            color:
                                                                AppColors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const Introduction1(),
                                                            ),
                                                          );
                                                        },
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 20,
                                                                  horizontal:
                                                                      30),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color:
                                                                AppColors.blue,
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Ke Kuesioner",
                                                                style:
                                                                    GoogleFonts
                                                                        .lato(
                                                                  fontSize: 20,
                                                                  color:
                                                                      AppColors
                                                                          .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              const Icon(
                                                                IconlyBold
                                                                    .arrow_right_circle,
                                                                color: AppColors
                                                                    .white,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
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
                      judul: "Tentukan Tema Skripsi",
                      subJudul:
                          "Tentukan tema Skripsi yang anda inginkan dengan mengisi Kuesioner",
                      color: AppColors.blue,
                      picture: 'assets/illustration/tema-skripsi.png',
                      rightButton: "Ayo Mulai",
                      ketikaDiTekan: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Introduction1(),
                          ),
                        );
                      },
                      textColor: AppColors.white,
                    );
                  }),
              const SizedBox(
                height: 10,
              ),
              //Input Judul
              MenuList2(
                judul: "Input Judul",
                subJudul:
                    "Masukan judul kamu yuk, dan berikan ke Kaprodi tanpa harus mendatanginya langsung",
                color: AppColors.orange,
                picture: 'assets/illustration/input-judul.png',
                rightButton: "Masukan Judul",
                ketikaDiTekan: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const DaftarTemaSkripsiScreen();
                      },
                    ),
                  );
                },
                textColor: AppColors.blue,
              ),
            ],
          ),
          //end User

          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

//halaman Admin
class AdminWidget extends StatelessWidget {
  const AdminWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SingleChildScrollView(
        child: Column(
          children: [
            //tema skripsi (alternatif)
            AdminMenu(
              judul: "Daftar Tema Skripsi",
              subJudul:
                  "Konfigurasi tema yang berada pada STIKOM Poltek Cirebon (Data Alternatif)",
              imageAssets: "assets/illustration/alternatif.png",
              colorBackgroundIcon: AppColors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const DaftarTemaSkripsi();
                    },
                  ),
                );
              },
            ),
            //data kriteria
            AdminMenu(
              judul: "Daftar Data Kriteria",
              subJudul:
                  "Konfigurasi kriteria, sub-kriteria, dan bobot pada perhitungan WASPAS",
              imageAssets: "assets/illustration/kriteria.png",
              colorBackgroundIcon: const Color(0xff94E192),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const DaftarKriteria();
                    },
                  ),
                );
              },
            ),

            //judul Mahasiswa
            AdminMenu(
              judul: "Daftar Judul Mahasiswa",
              subJudul:
                  "Konfigurasi tema yang berada pada STIKOM Poltek Cirebon (Data Alternatif)",
              imageAssets: "assets/illustration/judul.png",
              colorBackgroundIcon: AppColors.orange,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const DaftarJudulMahasiswa();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
