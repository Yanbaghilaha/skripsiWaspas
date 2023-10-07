import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SkripsiWASPASPage extends StatefulWidget {
  const SkripsiWASPASPage({super.key});

  @override
  _SkripsiWASPASPageState createState() => _SkripsiWASPASPageState();
}

class _SkripsiWASPASPageState extends State<SkripsiWASPASPage> {
  List<Map<String, dynamic>> alternatifData = [];
  List<Map<String, dynamic>> kriteriaData = [];
  int currentDataIndex = 0;
  Map<String, double?> selectedValues = {};

  @override
  void initState() {
    super.initState();
    _fetchAlternatifData();
    _fetchKriteriaData();
  }

  Future<void> _fetchAlternatifData() async {
    final QuerySnapshot alternatifSnapshot =
        await FirebaseFirestore.instance.collection('alternatif').get();

    setState(() {
      alternatifData = alternatifSnapshot.docs.map((doc) {
        return {"nama": doc.id};
      }).toList();
    });
  }

  Future<void> _fetchKriteriaData() async {
    final QuerySnapshot kriteriaSnapshot =
        await FirebaseFirestore.instance.collection('kriteria').get();

    setState(() {
      kriteriaData = kriteriaSnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();
    });
  }

  void _updateSelectedValue(String kriteriaNama, double? value) {
    setState(() {
      selectedValues[kriteriaNama] = value;
    });
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

    // Langkah 3: Menentukan Alternatif Terbaik
    if (alternatifData.length == 1) {
      String alternatifTunggal = alternatifData[0]['nama'];
      return "Hanya ada satu alternatif: $alternatifTunggal";
    }

    double maxWeightedSum = weightedSumValues.isNotEmpty
        ? weightedSumValues
            .reduce((value, element) => value > element ? value : element)
        : 0.0; // Atau nilai default sesuai kebutuhan Anda

    int indexMax = weightedSumValues.indexOf(maxWeightedSum);

    if (alternatifData.isNotEmpty &&
        indexMax >= 0 &&
        indexMax < alternatifData.length) {
      String alternatifTerbaik = alternatifData[indexMax]['nama'];
      print("Alternatif terbaik: $alternatifTerbaik");
      return alternatifTerbaik;
    } else {
      print("Tidak ada alternatif terbaik yang dapat ditentukan.");
      return "Tidak ada alternatif terbaik yang dapat ditentukan.";
    }

    // return "Alternatif terbaik: $alternatifTerbaik";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skripsi WASPAS App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (currentDataIndex < kriteriaData.length)
              Column(
                children: [
                  const Text(
                    'Pilih nilai preferensi untuk kriteria:',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    kriteriaData[currentDataIndex]['nama'],
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  RadioOptions(
                    subKriteria: kriteriaData[currentDataIndex]['subKriteria'],
                    selectedValue:
                        selectedValues[kriteriaData[currentDataIndex]['nama']],
                    onChanged: (value) {
                      _updateSelectedValue(
                          kriteriaData[currentDataIndex]['nama'], value);
                      setState(() {
                        currentDataIndex++;
                      });
                    },
                  ),
                ],
              )
            else
              Column(
                children: [
                  const Text(
                    'Hasil Perhitungan:',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _calculateWASPAS(),
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class RadioOptions extends StatelessWidget {
  final Map<String, dynamic> subKriteria;
  final double? selectedValue;
  final ValueChanged<double?> onChanged;

  const RadioOptions({
    super.key,
    required this.subKriteria,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: subKriteria.entries
          .map(
            (entry) => ListTile(
              title: Text(entry.key),
              leading: Radio<double>(
                value: entry.value.toDouble(),
                groupValue: selectedValue,
                onChanged: onChanged,
              ),
            ),
          )
          .toList(),
    );
  }
}
