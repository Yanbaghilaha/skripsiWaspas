import 'package:flutter/material.dart';

class Question {
  final int id;
  final String namaMatkul;
  final Image icon;
  final String? subtitle;
  final List<String> jawaban1, jawaban2, jawaban3, jawaban4, pertanyaan;

  Question({
    required this.id,
    required this.pertanyaan,
    this.subtitle,
    required this.icon,
    required this.jawaban1,
    required this.jawaban2,
    required this.jawaban3,
    required this.jawaban4,
    required this.namaMatkul,
  });
}

List sampleData = [
  {
    "icon": const Image(
      image: AssetImage('assets/icons/kripto.png'),
    ),
    "namaMatkul": "Kriptografi", // alternatif
    "pertanyaan": "Minat Matkul?", // Minat matkul
    'jawaban': [
      //subkrteria (mapping)
      "Tidak Menguasai", //data subrktierai
      "Sedikit Menguasai", //data subrktierai
      "Lumayan Menguasai", //data subrktierai
      "Menguasai", //data subrktierai
      "Sangat Menguasai", //data subrktierai
    ],
  },
  {
    "icon": const Image(
      image: AssetImage('assets/icons/kripto.png'),
    ),
    "namaMatkul": "Kriptografi",
    "pertanyaan": "Nilai Akademis?",
    'jawaban': [
      "Tidak Minat",
      "Sedikit Minat",
      "Lumayan Minat",
      "Minat",
      "Sangat Minat",
    ],
  },
  {
    "icon": const Image(
      image: AssetImage('assets/icons/kripto.png'),
    ),
    "namaMatkul": "Kriptografi",
    "pertanyaan": "Paham Matkul?",
    'jawaban': [
      "Tidak Menguasai",
      "Sedikit Menguasai",
      "Lumayan Menguasai",
      "Menguasai",
      "Sangat Menguasai",
    ],
  },
  {
    "icon": const Image(
      image: AssetImage('assets/icons/kripto.png'),
    ),
    "namaMatkul": "Kriptografi",
    "pertanyaan": "Penguasaan Matkul?",
    'jawaban': [
      "Tidak Menguasai",
      "Sedikit Menguasai",
      "Lumayan Menguasai",
      "Menguasai",
      "Sangat Menguasai",
    ],
  },

  // end kripto
  {
    "icon": const Image(
      image: AssetImage('assets/icons/kripto.png'),
    ),
    "namaMatkul": "Data Mining",
    "pertanyaan": "Minat Matkul?",
    'jawaban': [
      "Tidak Menguasai",
      "Sedikit Menguasai",
      "Lumayan Menguasai",
      "Menguasai",
      "Sangat Menguasai",
    ],
  },
  {
    "icon": const Image(
      image: AssetImage('assets/icons/kripto.png'),
    ),
    "namaMatkul": "Data Mining",
    "pertanyaan": "Nilai Akademis?",
    'jawaban': [
      "Tidak Minat",
      "Sedikit Minat",
      "Lumayan Minat",
      "Minat",
      "Sangat Minat",
    ],
  },
  {
    "icon": const Image(
      image: AssetImage('assets/icons/kripto.png'),
    ),
    "namaMatkul": "Data Mining",
    "pertanyaan": "Paham Matkul?",
    'jawaban': [
      "Tidak Menguasai",
      "Sedikit Menguasai",
      "Lumayan Menguasai",
      "Menguasai",
      "Sangat Menguasai",
    ],
  },
  {
    "icon": const Image(
      image: AssetImage('assets/icons/kripto.png'),
    ),
    "namaMatkul": "Data Mining",
    "pertanyaan": "Penguasaan Matkul?",
    'jawaban': [
      "Tidak Menguasai",
      "Sedikit Menguasai",
      "Lumayan Menguasai",
      "Menguasai",
      "Sangat Menguasai",
    ],
  },
  //end data mining
  {
    "icon": const Image(
      image: AssetImage('assets/icons/kripto.png'),
    ),
    "namaMatkul": "Jaringan",
    "pertanyaan": "Minat Matkul?",
    'jawaban': [
      "Tidak Menguasai",
      "Sedikit Menguasai",
      "Lumayan Menguasai",
      "Menguasai",
      "Sangat Menguasai",
    ],
  },
  {
    "icon": const Image(
      image: AssetImage('assets/icons/kripto.png'),
    ),
    "namaMatkul": "Jaringan",
    "pertanyaan": "Nilai Akademis?",
    'jawaban': [
      "Tidak Minat",
      "Sedikit Minat",
      "Lumayan Minat",
      "Minat",
      "Sangat Minat",
    ],
  },
  {
    "icon": const Image(
      image: AssetImage('assets/icons/kripto.png'),
    ),
    "namaMatkul": "Jaringan",
    "pertanyaan": "Paham Matkul?",
    'jawaban': [
      "Tidak Menguasai",
      "Sedikit Menguasai",
      "Lumayan Menguasai",
      "Menguasai",
      "Sangat Menguasai",
    ],
  },
  {
    "icon": const Image(
      image: AssetImage('assets/icons/kripto.png'),
    ),
    "namaMatkul": "Jaringan",
    "pertanyaan": "Penguasaan Matkul?",
    'jawaban': [
      "Tidak Menguasai",
      "Sedikit Menguasai",
      "Lumayan Menguasai",
      "Menguasai",
      "Sangat Menguasai",
    ],
  },
];
