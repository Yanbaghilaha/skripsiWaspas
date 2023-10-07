import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spk_app/sample/s.detailsdatakriteria.dart';
import 'package:spk_app/sample/tambahKriteria.dart';

class DaftarDataKriteriaPage extends StatelessWidget {
  const DaftarDataKriteriaPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Data Kriteria'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('kriteria').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final docs = snapshot.data!.docs;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doc = docs[index];
                    final data = doc.data() as Map<String, dynamic>;

                    return ListTile(
                      title: Text(data['nama']),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsDataKriteriaPage(data),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TambahDataKriteriaPage(),
                    ),
                  ).then(
                    (value) {
                      // Refresh halaman setelah penyuntingan
                      if (value == true) {
                        // Misalnya, refresh halaman atau perbarui data dari Firestore
                      }
                    },
                  );
                },
                child: const Text('Tambah'),
              ),
            ],
          );
        },
      ),
    );
  }
}
