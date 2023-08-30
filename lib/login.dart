// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spk_app/material/colors.dart';
import 'package:spk_app/signup.dart';

import 'admin/alternatifOrTemaSkripsi/daftar_tema_skripsi.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        wrongUsername();
      } else if (e.code == 'wrong-password') {
        wrongPassword();
      }
    }
  }

  void wrongPassword() {
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
          judul: "Password Salah",
          buttonText: "Kembali",
        );
      },
    );
  }

  void wrongUsername() {
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
          onPressed: () {},
          judulColor: AppColors.red,
          judul: "Email Anda Masukan Salah",
          buttonText: "Kembali",
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding:
              const EdgeInsets.only(right: 10, left: 10, top: 30, bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Image.asset('assets/login/login.png'),
                  const SizedBox(
                    height: 30,
                  ),

                  //text
                  Text(
                    'Silahkan masuk!',
                    style: GoogleFonts.lato(
                      fontSize: 30,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  //subtitle
                  Text(
                    'Masukan Email Anda dan Password Anda',
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      color: AppColors.white2,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  //---textfield---//

                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            autofocus: true,
                            controller: _emailController,
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
                          width: double.infinity,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            autofocus: true,
                            controller: _passwordController,
                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                color: AppColors.white,
                              ),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            showCursor: true,
                            obscureText: true,
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
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Belum Bikin Akun?",
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
                            ),
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
                              "Daftar",
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
              TextButton(
                onPressed: () {
                  signUp();
                  if (formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(content: Text('Processing Data')),
                    // );
                  }
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
                          "Masuk",
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
