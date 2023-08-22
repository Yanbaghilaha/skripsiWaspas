import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:spk_app/skala_opini/introduction/introduction1.dart';
import 'admin/daftar_kriteria.dart';
import 'admin/alternatifOrTemaSkripsi/daftar_tema_skripsi.dart';
import 'admin/judulmahasiswa/daftar_judul_mahasiswa.dart';
import 'daftar_judul_skripsi.dart';
import 'extract_widget/admin_menu.dart';
import 'extract_widget/menu_list.dart';
import 'extract_widget/menu_list2.dart';
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
  // final bool _isLoggedIn = false;
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

            return SafeArea(
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
                                userData['nama'] as String,
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
                            final value = await showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              context: context,
                              builder: (BuildContext build) {
                                return PopUp(
                                  controller: TextEditingController(),
                                  lottieAssetsVisible: true,
                                  isTextField: false,
                                  height: 436,
                                  namaTema: "Da lah, disini aja coba, Maksaa!!",
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

class UserWidget extends StatelessWidget {
  const UserWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView(
        children: [
          // Buat User
          Column(
            children: [
              MenuList(
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
              ),
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
                        return const DaftarJudulSkripsi();
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
              imageAssets: "assets/illustration/daftar-tema-skripsi.png",
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
              imageAssets: "assets/illustration/daftar-tema-skripsi.png",
              colorBackgroundIcon: AppColors.green,
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

            //judul amajhaiswa
            AdminMenu(
              judul: "Daftar Judul Mahasiswa",
              subJudul:
                  "Konfigurasi tema yang berada pada STIKOM Poltek Cirebon (Data Alternatif)",
              imageAssets: "assets/illustration/daftar-tema-skripsi.png",
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
