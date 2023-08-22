import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spk_app/sample/tambahSubKriteria.dart';

enum JenisKriteria { benefit, cost }

class TambahDataKriteriaPage extends StatefulWidget {
  const TambahDataKriteriaPage({super.key});

  @override
  _TambahDataKriteriaPageState createState() => _TambahDataKriteriaPageState();
}

class _TambahDataKriteriaPageState extends State<TambahDataKriteriaPage> {
  final TextEditingController _namaController = TextEditingController();
  JenisKriteria _selectedJenis = JenisKriteria.benefit;

  String getJenisText(JenisKriteria jenis) {
    return jenis == JenisKriteria.benefit ? 'Benefit' : 'Cost';
  }

  Future<bool> tambahKriteria() async {
    final String namaKriteria = _namaController.text;
    final String jenisKriteria =
        _selectedJenis == JenisKriteria.benefit ? 'Benefit' : 'Cost';

    try {
      await FirebaseFirestore.instance
          .collection('kriteria')
          .doc(namaKriteria)
          .set(
        {
          'nama': namaKriteria,
          'jenis': jenisKriteria,
          'bobot': 0.0,
        },
      );
      return true;
    } catch (error) {
      print('error $error');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Data Kriteria'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _namaController,
            decoration: const InputDecoration(labelText: 'Nama Kriteria'),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedJenis = JenisKriteria.benefit;
              });
            },
            child: _buildJenisRadioButton(JenisKriteria.benefit),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedJenis = JenisKriteria.cost;
              });
            },
            child: _buildJenisRadioButton(JenisKriteria.cost),
          ),
          ElevatedButton(
            onPressed: () async {
              bool success =
                  await tambahKriteria(); // Menggunakan await karena _tambahData mungkin mengembalikan nilai Future<bool>

              if (success) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TambahSubKriteria(namaKriteria: _namaController.text),
                  ),
                );
              } else {
                // Tampilkan pesan error atau tangani kasus gagal tambah data jika diperlukan
              }
            },
            child: const Text('Tambah'),
          ),
        ],
      ),
    );
  }

  Widget _buildJenisRadioButton(JenisKriteria jenis) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: _selectedJenis == jenis ? Colors.blue : Colors.grey,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        getJenisText(jenis), // Menggunakan fungsi getJenisText
        style: TextStyle(
          color: _selectedJenis == jenis ? Colors.blue : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    super.dispose();
  }
}
