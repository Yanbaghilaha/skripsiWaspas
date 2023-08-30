// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  void signUp() async {
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
              Navigator.pop(context);
              Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: Column(
            children: [
              Column(
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
                    height: 10,
                  ),

                  //---textfield---//

                  const SizedBox(
                    height: 30,
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
              const SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: signUp,
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
              ),
              const SizedBox(
                height: 30,
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
            ],
          ),
        ),
      ),
    );
  }
}
