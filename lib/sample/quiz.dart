// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScalaOpini extends StatefulWidget {
  const ScalaOpini({super.key});

  @override
  _ScalaOpiniState createState() => _ScalaOpiniState();
}

class _ScalaOpiniState extends State<ScalaOpini> {
  final controller = PageController();

  int currentDataIndex = 0;
  List<Map<String, dynamic>> kriteriaData = [];
  List<Map<String, dynamic>> alternatifData = [];
  Map<String, dynamic> selectedValues = {};

  Future<void> _fetchData() async {
    final QuerySnapshot kriteriaSnapshot =
        await FirebaseFirestore.instance.collection('kriteria').get();

    kriteriaData = kriteriaSnapshot.docs.map((doc) {
      Map<String, dynamic> kriteria = doc.data() as Map<String, dynamic>;
      Map<String, int> subKriteriaMap =
          Map<String, int>.from(kriteria['subKriteria']);
      Map<String, dynamic> formattedKriteria = {
        'bobot': kriteria['bobot'],
        'jenis': kriteria['jenis'],
        'nama': kriteria['nama'],
        'subKriteria': subKriteriaMap,
      };

      return formattedKriteria;
    }).toList();

    setState(() {
      currentDataIndex = 0;
    });
  }

  void _nextData() {
    if (currentDataIndex < kriteriaData.length - 1) {
      setState(() {
        currentDataIndex++;
        controller.nextPage(
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    } else {
      _fetchAlternatifData();
    }
  }

  void _previousData() {
    if (currentDataIndex > 0) {
      setState(() {
        currentDataIndex--;
        controller.previousPage(
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    }
  }

  Future<void> _fetchAlternatifData() async {
    final QuerySnapshot alternatifSnapshot =
        await FirebaseFirestore.instance.collection('alternatif').get();

    alternatifData = alternatifSnapshot.docs.map((doc) {
      Map<String, dynamic> alternatif = doc.data() as Map<String, dynamic>;

      // Loop melalui setiap kriteria dan ambil nilai preferensi yang dipilih oleh pengguna
      for (var kriteria in kriteriaData) {
        String kriteriaNama = kriteria['nama'];
        if (selectedValues[kriteriaNama] != null) {
          alternatif[kriteriaNama] = selectedValues[kriteriaNama];
        }
      }

      return alternatif;
    }).toList();

    setState(() {
      currentDataIndex = 0;
    });

    print("Data alternatif yang sedang diproses: $alternatifData");

    _calculateWASPAS(); // Hitung nilai WASPAS setelah data alternatif diambil
  }

  String _calculateWASPAS() {
    // Langkah 1: Normalisasi Data
    List<List<double>> normalizedMatrix = [];
    for (var i = 0; i < alternatifData.length; i++) {
      List<double> normalizedValues = [];
      for (var kriteria in kriteriaData) {
        String kriteriaNama = kriteria['nama'];
        double nilai = alternatifData[i][kriteriaNama] /
            kriteria['subKriteria'].length.toDouble();
        normalizedValues.add(nilai);
      }
      normalizedMatrix.add(normalizedValues);
      print("Data alternatif yang sedang diproses: $normalizedValues");
    }

    // Langkah 2: Perhitungan Nilai Preferensi (Weighted Sum)
    List<double> weightedSumValues = [];
    for (var i = 0; i < alternatifData.length; i++) {
      double weightedSum = 0;
      for (var j = 0; j < kriteriaData.length; j++) {
        double bobot = kriteriaData[j]['bobot'];
        weightedSum += normalizedMatrix[i][j] * bobot;
      }
      weightedSumValues.add(weightedSum);
    }
    for (var kriteria in kriteriaData) {
      print("${kriteria['bobot']}");
    }

    // Langkah 3: Menentukan Alternatif Terbaik
    if (alternatifData.length == 1) {
      String alternatifTunggal = alternatifData[0]['nama'];
      print("Hanya ada satu alternatif: $alternatifTunggal");
      return alternatifTunggal;
    }
    if (weightedSumValues.isEmpty) {
      print("Tidak ada data untuk dihitung.");
      return "Tidak ada data untuk dihitung.";
    }
    String alternatifTerbaik = "";
    double maxWeightedSum = double.negativeInfinity;

    for (var i = 0; i < alternatifData.length; i++) {
      double weightedSum = weightedSumValues[i];
      if (weightedSum > maxWeightedSum) {
        maxWeightedSum = weightedSum;
        alternatifTerbaik = alternatifData[i]['nama'];
      }
    }
    print("Alternatif terbaik: $alternatifTerbaik");

    return alternatifTerbaik;
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                children: [
                  Flexible(
                    child: PageView.builder(
                      controller: controller,
                      itemCount: kriteriaData.length,
                      onPageChanged: (index) {
                        setState(
                          () {
                            currentDataIndex = index;
                          },
                        );
                      },
                      itemBuilder: (context, index) {
                        final kriteria = kriteriaData[index];

                        return Container(
                          child: Column(
                            children: [
                              Text(
                                kriteria['nama'],
                                style: GoogleFonts.lato(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  height: 2,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Column(
                                children: [
                                  if (kriteria['subKriteria'] != null)
                                    for (var subKriteriaEntry
                                        in kriteria['subKriteria'].entries)
                                      customRadio(
                                        subKriteriaEntry.key,
                                        "assets/emoji/${subKriteriaEntry.value}.png",
                                        subKriteriaEntry.value.toDouble(),
                                        kriteria['subKriteria']
                                            .keys
                                            .toList()
                                            .indexOf(subKriteriaEntry.key),
                                        subKriteriaEntry,
                                      ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            currentDataIndex == kriteriaData.length - 1
                ? Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 20, top: 20),
                    decoration: const BoxDecoration(
                      color: Color(0xff1F2637),
                      border: Border(
                        top: BorderSide(
                          color: Color(0xff2A3244),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: _previousData,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.orange,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "Kembali",
                                  style: GoogleFonts.lato(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title:
                                        const Text('Hasil Perhitungan WASPAS'),
                                    content: Text(
                                        'Alternatif terbaik: ${_calculateWASPAS()}'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Tutup'),
                                      ),
                                    ],
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
                                color: const Color(0xff333B4F),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Hitung WASPAS",
                                    style: GoogleFonts.lato(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.calculate,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget customRadio(text, String image, double value, int index,
      MapEntry<String, int> subKriteriaEntry) {
    return TextButton(
      onPressed: () {
        setState(() {
          selectedValues[kriteriaData[currentDataIndex]['nama']] =
              subKriteriaEntry.value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        decoration: BoxDecoration(
          color:
              (selectedValues[kriteriaData[currentDataIndex]['nama']] == value)
                  ? Colors.blue
                  : null,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: const Color(0xff505668)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            Image.asset(image),
          ],
        ),
      ),
    );
  }
}
