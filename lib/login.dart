// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spk_app/material/colors.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void signUp() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text, password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:
            const EdgeInsets.only(right: 10, left: 10, top: 100, bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 145,
                  decoration: BoxDecoration(
                    color: AppColors.violet,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
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
                  'Inputkan NRP dengan nrp_anda@gmail.com & Kata sandi anda sesuai dengan data SIKA',
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),

                //---textfield---//

                const SizedBox(
                  height: 30,
                ),
                //email
                SizedBox(
                  // width: double.infinity,
                  child: TextField(
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
                  // width: double.infinity,
                  child: TextField(
                    autofocus: true,
                    obscureText: true,
                    controller: _passwordController,
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
                        "Masuk",
                        style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
