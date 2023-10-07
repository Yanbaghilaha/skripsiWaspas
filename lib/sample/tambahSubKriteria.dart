import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// class TambahSubKriteria extends StatefulWidget {
//   final String namaKriteria;

//   const TambahSubKriteria({super.key, required this.namaKriteria});

//   @override
//   _TambahSubKriteriaState createState() => _TambahSubKriteriaState();
// }

// class _TambahSubKriteriaState extends State<TambahSubKriteria> {
//   final TextEditingController _subkriteriaController = TextEditingController();
//   final TextEditingController _nilaiController = TextEditingController();
//   Map<String, dynamic> subkriteriaMap = {};

//   void _tambahSubkriteria() {
//     String subkriteria = _subkriteriaController.text;
//     double nilai = double.tryParse(_nilaiController.text) ?? 0.0;

//     if (subkriteria.isNotEmpty && nilai > 0) {
//       setState(() {
//         subkriteriaMap[subkriteria] = {'nama': subkriteria, 'nilai': nilai};
//         _subkriteriaController.clear();
//         _nilaiController.clear();
//       });
//     }
//   }

//   Future<bool> _simpanData() async {
//     try {
//       CollectionReference kriteriaCollection =
//           FirebaseFirestore.instance.collection('kriteria');
//       DocumentReference kriteriaDocRef =
//           kriteriaCollection.doc(widget.namaKriteria);

//       await kriteriaDocRef.update({
//         'subkriteria': subkriteriaMap,
//       });

//       return true;
//     } catch (error) {
//       print('Error: $error');
//       return false;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Tambah SubKriteria'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ListView.builder(
//               shrinkWrap: true,
//               itemCount: subkriteriaMap.length,
//               itemBuilder: (context, index) {
//                 final subkriteriaKey = subkriteriaMap.keys.toList()[index];
//                 final subkriteriaValue = subkriteriaMap[subkriteriaKey];
//                 return ListTile(
//                   title: Text(subkriteriaKey),
//                   subtitle: Text(subkriteriaValue['nilai'].toString()),
//                 );
//               },
//             ),
//             TextField(
//               controller: _subkriteriaController,
//               decoration: const InputDecoration(labelText: 'Subkriteria'),
//             ),
//             TextField(
//               controller: _nilaiController,
//               decoration: const InputDecoration(labelText: 'Nilai'),
//               keyboardType: TextInputType.number,
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 _tambahSubkriteria();
//               },
//               child: const Text('Tambah Subkriteria'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 bool success = await _simpanData();

//                 if (success) {
//                   Navigator.pop(context); // Kembali ke halaman sebelumnya
//                 } else {
//                   // Tangani jika penyimpanan gagal
//                 }
//               },
//               child: const Text('Simpan Data'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class TambahSubKriteria extends StatefulWidget {
  final String namaKriteria;

  const TambahSubKriteria({super.key, required this.namaKriteria});

  @override
  _TambahSubKriteriaState createState() => _TambahSubKriteriaState();
}

class _TambahSubKriteriaState extends State<TambahSubKriteria> {
  final TextEditingController _subkriteriaController = TextEditingController();
  final TextEditingController _nilaiController = TextEditingController();
  Map<String, dynamic> subkriteriaMap = {};

  void _tambahSubkriteria() {
    String subkriteria = _subkriteriaController.text;
    double nilai = double.tryParse(_nilaiController.text) ?? 0.0;

    if (subkriteria.isNotEmpty && nilai > 0) {
      setState(() {
        subkriteriaMap[subkriteria] = {'nama': subkriteria, 'nilai': nilai};
        _subkriteriaController.clear();
        _nilaiController.clear();
      });
    }
  }

  Future<bool> _simpanDataKriteriaFirestore() async {
    try {
      CollectionReference kriteriaCollection =
          FirebaseFirestore.instance.collection('kriteria');
      DocumentReference kriteriaDocRef =
          kriteriaCollection.doc(widget.namaKriteria);

      Map<String, dynamic> kriteriaData = {
        'subkriteria': subkriteriaMap,
      };

      await kriteriaDocRef.update(kriteriaData);

      return true;
    } catch (error) {
      print('Error: $error');
      return false;
    }
  }

  Future<bool> _simpanDataSubkriteriaFirestore() async {
    try {
      CollectionReference subkriteriaCollection =
          FirebaseFirestore.instance.collection('subkriteria');

      String kriteriaDocId = widget.namaKriteria;

      await subkriteriaCollection.doc(kriteriaDocId).set(subkriteriaMap);

      return true;
    } catch (error) {
      print('Error: $error');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah SubKriteria'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: subkriteriaMap.length,
              itemBuilder: (context, index) {
                final subkriteriaKey = subkriteriaMap.keys.toList()[index];
                final subkriteriaValue = subkriteriaMap[subkriteriaKey];
                return ListTile(
                  title: Text(subkriteriaKey),
                  subtitle: Text(subkriteriaValue['nilai'].toString()),
                );
              },
            ),
            TextField(
              controller: _subkriteriaController,
              decoration: const InputDecoration(labelText: 'Subkriteria'),
            ),
            TextField(
              controller: _nilaiController,
              decoration: const InputDecoration(labelText: 'Nilai'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () {
                _tambahSubkriteria();
              },
              child: const Text('Tambah Subkriteria'),
            ),
            ElevatedButton(
              onPressed: () async {
                bool successKriteria = await _simpanDataKriteriaFirestore();
                bool successSubKriteria =
                    await _simpanDataSubkriteriaFirestore();

                if (successKriteria && successSubKriteria) {
                  Navigator.pop(context); // Kembali ke halaman sebelumnya
                } else {
                  // Tangani jika penyimpanan gagal
                }
              },
              child: const Text('Simpan Data'),
            ),
          ],
        ),
      ),
    );
  }
}
