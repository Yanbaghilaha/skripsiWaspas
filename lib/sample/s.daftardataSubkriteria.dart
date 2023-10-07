import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spk_app/material/colors.dart';

class DetailsSubKriteriaPage extends StatelessWidget {
  final String namaKriteria;

  const DetailsSubKriteriaPage(this.namaKriteria, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Details Subkriteria'),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance
            .collection('kriteria')
            .doc(namaKriteria)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final kriteriaData = snapshot.data?.data();
          final subkriteriaMap = kriteriaData?['subkriteria'] ?? {};

          return ListView.builder(
            itemCount: subkriteriaMap.length,
            itemBuilder: (context, index) {
              final subkriteriaKey = subkriteriaMap.keys.toList()[index];
              final subkriteriaValue = subkriteriaMap[subkriteriaKey];
              return ListTile(
                title: Text(subkriteriaKey),
                subtitle: Text(
                  'Nilai: ${subkriteriaValue['nilai']}',
                ),
              );
            },
          );
        },
      ),
    );
  }
}
