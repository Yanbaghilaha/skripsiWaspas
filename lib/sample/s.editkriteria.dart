// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spk_app/material/colors.dart';

class EditDataKriteriaPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const EditDataKriteriaPage(this.data, {Key? key}) : super(key: key);

  @override
  _EditDataKriteriaPageState createState() => _EditDataKriteriaPageState();
}

class _EditDataKriteriaPageState extends State<EditDataKriteriaPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _bobotController = TextEditingController();
  final TextEditingController _jenisController = TextEditingController();

  @override
  void initState() {
    _namaController.text = widget.data['nama'];
    _bobotController.text = widget.data['bobot'].toString();
    _jenisController.text = widget.data['jenis'];
    super.initState();
  }

  Future<void> _updateData() async {
    final String oldNama = widget.data['nama'];
    final String newNama = _namaController.text;

    // Update data di Firestore untuk dokumen 'kriteria'
    await FirebaseFirestore.instance
        .collection('kriteria')
        .doc(oldNama)
        .update({
      'nama': newNama,
      'bobot': double.parse(_bobotController.text),
      'jenis': _jenisController.text,
    });

    // Update docID di koleksi 'kriteria'
    await FirebaseFirestore.instance.collection('kriteria').doc(newNama).set({
      'nama': newNama,
      'bobot': double.parse(_bobotController.text),
      'jenis': _jenisController.text,
    });

    // Update docID di koleksi 'subkriteria' jika ada
    final subkriteriaRef = FirebaseFirestore.instance.collection('subkriteria');
    final subkriteriaQuery =
        await subkriteriaRef.where('kriteria', isEqualTo: oldNama).get();

    for (final doc in subkriteriaQuery.docs) {
      final String subkriteriaDocId = doc.id;
      final Map<String, dynamic> subkriteriaData = doc.data();

      await subkriteriaRef.doc(subkriteriaDocId).delete();
      await subkriteriaRef.doc(newNama).set(subkriteriaData);
    }

    Navigator.pop(
        context, true); // Memberikan sinyal refresh pada halaman sebelumnya
  }

  Future<void> _deleteData() async {
    final String namaKriteria = widget.data['nama'];

    // Hapus dokumen subkriteria terkait pada koleksi 'subkriteria'
    final subkriteriaRef = FirebaseFirestore.instance.collection('subkriteria');
    await subkriteriaRef.doc(namaKriteria).delete();

    // Hapus dokumen kriteria pada koleksi 'kriteria'
    await FirebaseFirestore.instance
        .collection('kriteria')
        .doc(namaKriteria)
        .delete();

    Navigator.pop(
        context, true); // Memberikan sinyal refresh pada halaman sebelumnya
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Edit Data Kriteria'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _namaController,
            decoration: const InputDecoration(labelText: 'Nama'),
          ),
          TextField(
            controller: _bobotController,
            decoration: const InputDecoration(labelText: 'Bobot'),
          ),
          TextField(
            controller: _jenisController,
            decoration: const InputDecoration(labelText: 'Jenis'),
          ),
          ElevatedButton(
            onPressed: _updateData,
            child: const Text('Simpan'),
          ),
          ElevatedButton(
            onPressed: _deleteData,
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _bobotController.dispose();
    _jenisController.dispose();
  }
}
