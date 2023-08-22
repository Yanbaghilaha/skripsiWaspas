// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:spk_app/waspas3.dart';

class DecisionMakingPageBackUp extends StatefulWidget {
  const DecisionMakingPageBackUp({super.key});

  @override
  _DecisionMakingPageBackUpState createState() =>
      _DecisionMakingPageBackUpState();
}

class _DecisionMakingPageBackUpState extends State<DecisionMakingPageBackUp> {
  List<List<int>> dataAlternatif = List.generate(
    5,
    (index) => [0, 0, 0, 0, 0], // Menggunakan nilai awal 0
  );

  Future<Map<String, dynamic>> fetchKriteriaData() async {
    Map<String, dynamic> kriteriaData = {};

    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('kriteria').get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
        String namaKriteria = doc.data()['nama'];
        Map<String, dynamic> subKriteria = doc.data()['subKriteria'];
        kriteriaData[namaKriteria] = subKriteria;
      }
    } catch (error) {
      print('Error fetching kriteria data: $error');
    }

    return kriteriaData;
  }

  List<String> alternatif = [
    "Kripto",
    "Data Mining",
    "Sistem Pakar",
    "Mikrokontroler",
    "SPK",
    "Jaringan"
  ];
  List<String> jenisKriteria = [
    "Benefit",
    "Benefit",
    "Benefit",
    "Benefit",
    "Benefit"
  ];

  List<double> bobot = [3, 2.2, 1.5, 2.5, 0.8];
  List<List<double>> normalizedData = [];
  List<List<double>> weightedResults = [];
  List<double> totalWeightedSum = [];
  List<List<double>> poweredResults = [];
  List<double> finalResults = [];
  List<double> summedResults = [];

  Map<String, dynamic> kriteriaData = {};

  @override
  void initState() {
    super.initState();
    fetchKriteriaData().then((data) {
      setState(() {
        kriteriaData = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Decision Making App'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Masukkan data alternatif:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            for (int i = 0; i < dataAlternatif.length; i++)
              Column(
                children: [
                  Text(
                    'Alternatif ${i + 1}: ${alternatif[i]}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  for (int j = 0; j < dataAlternatif[i].length; j++)
                    Row(
                      children: [
                        for (int value = 1; value <= 5; value++)
                          Radio<int>(
                            value: value,
                            groupValue: dataAlternatif[i][j],
                            onChanged: (selectedValue) {
                              setState(() {
                                dataAlternatif[i][j] = selectedValue!;
                              });
                              print(selectedValue);
                            },
                          ),
                      ],
                    ),
                ],
              ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  normalizedData =
                      calculateNormalizedData(dataAlternatif, jenisKriteria);
                  weightedResults =
                      calculateWeightedResults(normalizedData, bobot);
                  totalWeightedSum = calculateTotalWeightedSum(weightedResults);
                  poweredResults =
                      calculatePoweredResults(normalizedData, bobot);
                  finalResults = calculateFinalResults(poweredResults);
                  summedResults = sumResults(totalWeightedSum, finalResults);
                });
                print(dataAlternatif);
                print(bobot);
                print(normalizedData);
              },
              child: const Text('Hitung'),
            ),
            const SizedBox(height: 32.0),
            if (summedResults.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hasil penjumlahan setiap data dalam result1 dan result2:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  for (int i = 0; i < summedResults.length; i++)
                    Text('Alternatif ${i + 1}: ${summedResults[i]}'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
