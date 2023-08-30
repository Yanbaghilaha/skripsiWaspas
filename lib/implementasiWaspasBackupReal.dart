// ignore_for_file: avoid_print

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DecisionMakingPageBackUpReal extends StatefulWidget {
  const DecisionMakingPageBackUpReal({super.key});

  @override
  _DecisionMakingPageBackUpRealState createState() =>
      _DecisionMakingPageBackUpRealState();
}

class _DecisionMakingPageBackUpRealState
    extends State<DecisionMakingPageBackUpReal> {
  List<List<int>> dataAlternatif = [];
  List<List<int>> selectedValues = [];
  List<String> alternatif = [];
  List<String> jenisKriteria = []; // Menggunakan List<String>

  Map<String, Map<String, int>> subKriteriaData = {};
  List<double> bobot = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
  }

  Future<void> fetchKriteriaData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('kriteria').get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
        String jenis = doc.data()['jenis'];
        jenisKriteria.add(jenis);
        double bobotKriteria = doc.data()['bobot'] as double;
        bobot.add(bobotKriteria);
      }
    } catch (error) {
      print('Error fetching kriteria data: $error');
    }
  }

  //mencari nilai max
  List<int> getMaxValuesInColumns(List<List<int>> matrix) {
    List<int> maxValues = List.filled(matrix[0].length, 0);

    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[i].length; j++) {
        if (matrix[i][j] > maxValues[j]) {
          maxValues[j] = matrix[i][j];
        }
      }
    }
    return maxValues;
  }

  //mencari nilai min
  List<int> getMinValuesInColumns(List<List<int>> matrix) {
    List<int> minValues = List.filled(matrix[0].length,
        5); // Diinisialisasi dengan nilai maksimum yang mungkin

    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[i].length; j++) {
        if (matrix[i][j] < minValues[j]) {
          minValues[j] = matrix[i][j];
        }
      }
    }

    return minValues;
  }

  //perhitungan normalisasi
  List<List<double>> calculateNormalizedData(List<List<int>> matrix,
      List<String> jenisKriteria, List<int> maxValues, List<int> minValues) {
    List<List<double>> normalizedData = [];

    for (int i = 0; i < matrix.length; i++) {
      List<double> normalizedRow = [];
      for (int j = 0; j < matrix[i].length; j++) {
        double normalizedValue;
        if (jenisKriteria[j] == 'Benefit') {
          normalizedValue = matrix[i][j] / maxValues[j];
        } else if (jenisKriteria[j] == 'Cost') {
          normalizedValue = minValues[j] / matrix[i][j];
        } else {
          normalizedValue = 0.0;
        }
        normalizedRow.add(normalizedValue);
      }
      normalizedData.add(normalizedRow);
    }

    return normalizedData;
  }

  //menghitung nilai Qi (1)
  List<List<double>> calculateQi(
      List<List<double>> normalizedData, List<double> bobot) {
    List<List<double>> weightedResults = [];

    for (int i = 0; i < normalizedData.length; i++) {
      List<double> weightedRow = [];
      for (int j = 0; j < normalizedData[i].length; j++) {
        double weightedValue = normalizedData[i][j] * bobot[j];
        weightedRow.add(weightedValue);
      }
      weightedResults.add(weightedRow);
    }

    return weightedResults;
  }

  List<double> calculateTotalWeightedSumPerRow(
      List<List<double>> weightedResults) {
    List<double> totalWeightedSumPerRow = [];

    for (int i = 0; i < weightedResults.length; i++) {
      double rowSum = weightedResults[i].reduce((sum, value) => sum + value);
      totalWeightedSumPerRow.add(rowSum);
    }

    return totalWeightedSumPerRow;
  }

  List<double> calculateQiFinal(List<double> totalWeightedSumPerRow) {
    List<double> qiFinal = [];

    for (int i = 0; i < totalWeightedSumPerRow.length; i++) {
      double qi = totalWeightedSumPerRow[i] * 0.5;
      qiFinal.add(qi);
    }

    return qiFinal;
  }

  //langkah 2
  List<double> calculateQ2(
      List<List<double>> normalizedData, List<double> bobot) {
    List<double> q2Values = [];

    for (int i = 0; i < normalizedData.length; i++) {
      double rowProduct = 1.0;
      for (int j = 0; j < normalizedData[i].length; j++) {
        rowProduct *= pow(normalizedData[i][j], bobot[j]);
      }
      double q2 = rowProduct * 0.5;
      q2Values.add(q2);
    }

    return q2Values;
  }

  //final function
  List<double> totalPerColumn(List<double> data1, List<double> data2) {
    assert(data1.length == data2.length);

    List<double> result = List.filled(data1.length, 0.0);

    for (int i = 0; i < data1.length; i++) {
      result[i] = data1[i] + data2[i];
    }

    return result;
  }

  Future<void> fetchDataFromFirestore() async {
    try {
      // Ambil data alternatif
      QuerySnapshot<Map<String, dynamic>> alternatifSnapshot =
          await FirebaseFirestore.instance.collection('alternatif').get();
      alternatif = alternatifSnapshot.docs.map((doc) => doc.id).toList();

      // Ambil data kriteria, bobot, dan jenis
      QuerySnapshot<Map<String, dynamic>> kriteriaSnapshot =
          await FirebaseFirestore.instance.collection('kriteria').get();
      for (QueryDocumentSnapshot<Map<String, dynamic>> doc
          in kriteriaSnapshot.docs) {
        String namaKriteria = doc.data()['nama'];
        double bobotKriteria = doc.data()['bobot'] as double;
        String jenisKriteriaValue = doc.data()['jenis'];

        bobot.add(bobotKriteria);
        jenisKriteria.add(jenisKriteriaValue);

        Map<String, dynamic> subKriteria = doc.data()['subKriteria'];
        subKriteriaData[namaKriteria] = Map<String, int>.from(subKriteria);
      }

      // Inisialisasi data alternatif dan selectedValues
      dataAlternatif = List.generate(
        alternatif.length,
        (index) => List<int>.filled(jenisKriteria.length, 0),
      );
      selectedValues = List.generate(
        alternatif.length,
        (index) => List<int>.filled(jenisKriteria.length, 0),
      );

      setState(() {});
    } catch (error) {
      print('Error fetching data from Firestore: $error');
    }
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
                            groupValue: selectedValues[i][j],
                            onChanged: (selectedValue) {
                              setState(
                                () {
                                  selectedValues[i][j] = selectedValue!;
                                },
                              );
                            },
                          ),
                      ],
                    ),
                ],
              ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                List<int> maxValues = getMaxValuesInColumns(selectedValues);
                List<int> minValues = getMinValuesInColumns(selectedValues);
                List<List<double>> normalizedData = calculateNormalizedData(
                    selectedValues, jenisKriteria, maxValues, minValues);
                List<List<double>> weightedResults =
                    calculateQi(normalizedData, bobot);

                List<double> totalWeightedSumPerRow =
                    calculateTotalWeightedSumPerRow(weightedResults);
                List<double> q1Values =
                    calculateQiFinal(totalWeightedSumPerRow);
                List<double> q2Values = calculateQ2(normalizedData, bobot);

                print("Normalized data: $normalizedData");
                print("Weighted results: $weightedResults");
                print("Total weighted sum per row: $totalWeightedSumPerRow");
                print("Q2 values: $q2Values");
                List<double> totalWeightedSumColumn = totalPerColumn(
                  q1Values,
                  q2Values,
                );

                print("Total weighted sum per column: $totalWeightedSumColumn");
                print(subKriteriaData);

                // Mengurutkan hasil dari yang terbesar ke yang terkecil
                totalWeightedSumColumn.sort((a, b) => b.compareTo(a));

                print("Total weighted sum per column: $totalWeightedSumColumn");
              },
              child: const Text('Hitung'),
            ),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}
