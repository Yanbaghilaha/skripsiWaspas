// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spk_app/admin/daftar_kriteria.dart';
import 'package:spk_app/controller/auth_page.dart';
import 'package:spk_app/home_screen.dart';
import 'package:spk_app/material/colors.dart';
import 'package:spk_app/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.blue,
        statusBarBrightness: Brightness.dark, // as you need dark or light
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {
        '/homeScreen': (context) => const HomeScreen(),
        '/daftarKriteria': (context) => const DaftarKriteria(),
        '/authPage': (context) => const AuthPage(),
      },
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
          ),
        ),
        scaffoldBackgroundColor: AppColors.primary,
      ),
      home: const SplashScreen(),
      //SplashScreen Ori
    );
  }
}
