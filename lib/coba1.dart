import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spk_app/material/colors.dart';

class JsonDisplayWidget extends StatefulWidget {
  const JsonDisplayWidget({super.key});

  @override
  _JsonDisplayWidgetState createState() => _JsonDisplayWidgetState();
}

class _JsonDisplayWidgetState extends State<JsonDisplayWidget> {
  // Buat variabel untuk menyimpan data dari Firestore
  Map<String, dynamic> alternatifData = {};
  Map<String, dynamic> kriteriaData = {};

  // Fungsi untuk mengambil data dari Firestore
  Future<void> fetchData() async {
    final firestore = FirebaseFirestore.instance;

    // Mengambil data dari koleksi "alternatif"
    QuerySnapshot alternatifSnapshot =
        await firestore.collection('alternatif').get();
    alternatifData = Map.fromEntries(alternatifSnapshot.docs.map(
      (doc) => MapEntry(doc.id, doc.data()),
    ));

    // Mengambil data dari koleksi "kriteria"
    QuerySnapshot kriteriaSnapshot =
        await firestore.collection('kriteria').get();
    kriteriaData = Map.fromEntries(kriteriaSnapshot.docs.map(
      (doc) => MapEntry(doc.id, doc.data()),
    ));

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('JSON Data Display'),
      ),
      body: Center(
        child: Column(
          children: [
            // Tampilkan data 'alternatif'
            const Text('Alternatif Data:'),
            Text(alternatifData.toString()),

            // Tampilkan data 'kriteria'
            const Text('Kriteria Data:'),
            Text(kriteriaData.toString()),
          ],
        ),
      ),
    );
  }
}
