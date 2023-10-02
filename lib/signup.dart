// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spk_app/controller/auth_page.dart';

import 'admin/alternatifOrTemaSkripsi/daftar_tema_skripsi.dart';
import 'material/colors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nrpController = TextEditingController();

  void signUp(String kelas) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    Navigator.pop(context);
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.email)
          .set(
        {
          'nama': _namaController.text,
          'nrp': _nrpController.text,
          'kelas': kelas,
        },
      );
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        builder: (context) {
          return MyPopup(
            controller: TextEditingController(),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AuthPage(),
                ),
              );
            },
            judul: "Selamat!! Email Anda Terdaftar",
            hintText: "",
            buttonText: "Masuk",
            buttonColor: AppColors.green,
            imageAssets: "assets/animation/checklist.json",
            isTextField: false,
            onlyHaveOneButton: false,
            height: 576,
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'email-already-in-use') {
        emailAlreadyUse();
      } else if (e.code == 'weak-password') {
        weakPassword();
      }
    }
  }

  void weakPassword() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      builder: (context) {
        return MyPopup(
          height: 545,
          onlyHaveOneButton: false,
          hintText: "",
          imageAssets: "assets/animation/lock.json",
          isTextField: false,
          controller: TextEditingController(),
          onPressed: () {
            Navigator.pop(context);
          },
          judulColor: AppColors.red,
          judul: "Password Terlalu Lemah...",
          buttonText: "Kembali",
        );
      },
    );
  }

  void emailAlreadyUse() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      builder: (context) {
        return MyPopup(
          height: 545,
          onlyHaveOneButton: false,
          hintText: "",
          imageAssets: "assets/animation/logout.json",
          isTextField: false,
          controller: TextEditingController(),
          onPressed: () {
            Navigator.pop(context);
          },
          judulColor: AppColors.red,
          judul: "Email Sudah Digunakan Nih...",
          buttonText: "Kembali",
        );
      },
    );
  }

  String selectedClass = "";

  final bool isSelected = false;
  List kelas = [
    ["TI-1", false],
    ["TI-2", false],
    ["TI-3", false],
    ["TI-Malam", false],
  ];

  void classTypeSelected(int index) {
    setState(() {
      for (int i = 0; i < kelas.length; i++) {
        kelas[i][1] = false;
      }
      kelas[index][1] = true;
    });
    selectedClass = kelas[index][0];
  }

  void tambahKelas() {
    signUp(selectedClass);
  }

  final controller = PageController();
  bool isPageLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/login/SignUp.png'),
              const SizedBox(
                height: 30,
              ),
              //text
              Text(
                'Silahkan Daftar!',
                style: GoogleFonts.lato(
                  fontSize: 30,
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              Flexible(
                child: SizedBox(
                  height: 300,
                  child: PageView(
                    controller: controller,
                    onPageChanged: (index) {
                      setState(() {
                        isPageLast = (index == 1);
                      });
                    },
                    children: [
                      Column(
                        children: [
                          //NRP
                          SizedBox(
                            child: TextField(
                              controller: _nrpController,
                              autofocus: true,
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                  color: AppColors.white,
                                ),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              showCursor: true,
                              cursorWidth: 4,
                              cursorColor: AppColors.blue,
                              decoration: InputDecoration(
                                hintText: "NRP Anda",
                                hintStyle: GoogleFonts.lato(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white12,
                                ),
                                contentPadding: const EdgeInsets.all(20),
                                labelStyle: GoogleFonts.lato(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white30,
                                ),
                                border: InputBorder.none,
                                fillColor: const Color(0xff282B34),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Color(0xff505668),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.white60,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          //nama
                          SizedBox(
                            // width: double.infinity,
                            child: TextField(
                              controller: _namaController,
                              autofocus: true,
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                  color: AppColors.white,
                                ),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              showCursor: true,
                              cursorWidth: 4,
                              cursorColor: AppColors.blue,
                              decoration: InputDecoration(
                                hintText: "Masukan Nama Anda",
                                hintStyle: GoogleFonts.lato(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white12,
                                ),
                                contentPadding: const EdgeInsets.all(20),
                                labelStyle: GoogleFonts.lato(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white30,
                                ),
                                border: InputBorder.none,
                                fillColor: const Color(0xff282B34),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Color(0xff505668),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.white60,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          //Kelas
                          SizedBox(
                            height: 50,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: kelas.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  child: InformaticsClass(
                                    isSelected: kelas[index][1],
                                    onTap: () {
                                      classTypeSelected(index);
                                    },
                                    text: kelas[index][0],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  width: 16,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            // width: double.infinity,
                            child: TextField(
                              controller: _emailController,
                              autofocus: true,
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                  color: AppColors.white,
                                ),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              showCursor: true,
                              cursorWidth: 4,
                              cursorColor: AppColors.blue,
                              decoration: InputDecoration(
                                hintText: "Email Anda",
                                hintStyle: GoogleFonts.lato(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white12,
                                ),
                                contentPadding: const EdgeInsets.all(20),
                                labelStyle: GoogleFonts.lato(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white30,
                                ),
                                border: InputBorder.none,
                                fillColor: const Color(0xff282B34),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Color(0xff505668),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.white60,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          //password
                          SizedBox(
                            // width: double.infinity,
                            child: TextField(
                              controller: _passwordController,
                              autofocus: true,
                              obscureText: true,
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                  color: AppColors.white,
                                ),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              showCursor: true,
                              cursorWidth: 4,
                              cursorColor: AppColors.blue,
                              decoration: InputDecoration(
                                hintText: "Password Anda",
                                hintStyle: GoogleFonts.lato(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white12,
                                ),
                                contentPadding: const EdgeInsets.all(20),
                                labelStyle: GoogleFonts.lato(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white30,
                                ),
                                border: InputBorder.none,
                                fillColor: const Color(0xff282B34),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Color(0xff505668),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.white60,
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Sudah Bikin Akun?",
                    style: GoogleFonts.lato(
                      color: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(
                        context,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                          color: AppColors.blue),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        child: Text(
                          "Login",
                          style: GoogleFonts.lato(
                            color: AppColors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              isPageLast
                  ? TextButton(
                      onPressed: tambahKelas,
                      child: Container(
                        width: double.infinity,
                        height: 55,
                        decoration: BoxDecoration(
                          color: const Color(0xff5F5DCC),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Daftar",
                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : TextButton(
                      onPressed: () {
                        controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 55,
                        decoration: BoxDecoration(
                          color: const Color(0xff5F5DCC),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Selanjutnya",
                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class InformaticsClass extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final String text;
  const InformaticsClass(
      {super.key,
      required this.isSelected,
      required this.onTap,
      required this.text});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSelected ? AppColors.blue : null,
            border: Border.all(
              width: 1,
              color: AppColors.border,
            )),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.lato(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
