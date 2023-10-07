import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spk_app/material/colors.dart';

import 's.daftardataSubkriteria.dart';
import 's.editkriteria.dart';

class DetailsDataKriteriaPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetailsDataKriteriaPage(this.data, {super.key});

  Future<void> _deleteData() async {
    final String namaKriteria = data['nama'];

    // Hapus dokumen subkriteria terkait pada koleksi 'subkriteria'
    final subkriteriaRef = FirebaseFirestore.instance.collection('subkriteria');
    await subkriteriaRef.doc(namaKriteria).delete();

    // Hapus dokumen kriteria pada koleksi 'kriteria'
    await FirebaseFirestore.instance
        .collection('kriteria')
        .doc(namaKriteria)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Details Data Kriteria'),
      ),
      body: Column(
        children: [
          TextField(
            controller: TextEditingController(text: data['nama']),
            decoration: const InputDecoration(labelText: 'Nama'),
            readOnly: true,
          ),
          TextField(
            controller: TextEditingController(text: data['bobot'].toString()),
            decoration: const InputDecoration(labelText: 'Bobot'),
            readOnly: true,
          ),
          TextField(
            controller: TextEditingController(text: data['jenis']),
            decoration: const InputDecoration(labelText: 'Jenis'),
            readOnly: true,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsSubKriteriaPage(data['nama']),
                ),
              );
            },
            child: const Text('Lihat Subkriteria'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditDataKriteriaPage(data),
                ),
              ).then((value) {
                // Refresh halaman setelah penyuntingan
                if (value == true) {
                  // Misalnya, refresh halaman atau perbarui data dari Firestore
                }
              });
            },
            child: const Text('Edit'),
          ),
        ],
      ),
    );
  }
}
