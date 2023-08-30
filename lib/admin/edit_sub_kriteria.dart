import 'package:flutter/material.dart';

// class EditSubKriteria extends StatefulWidget {
//   const EditSubKriteria({super.key});

//   @override
//   State<EditSubKriteria> createState() => _EditSubKriteriaState();
// }

// class _EditSubKriteriaState extends State<EditSubKriteria> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
//           child: Column(
//             children: const [MyNavBar(judul: "Edit data Sub Kriteria")],
//           ),
//         ),
//       ),
//     );
//   }
// }

class SubKriteriaPage extends StatefulWidget {
  final TextEditingController subKriteriaController;

  const SubKriteriaPage({
    super.key,
    required this.subKriteriaController,
  });

  @override
  _SubKriteriaPageState createState() => _SubKriteriaPageState();
}

class _SubKriteriaPageState extends State<SubKriteriaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Sub-Kriteria"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: widget.subKriteriaController,
              decoration: const InputDecoration(labelText: "Sub-Kriteria"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Lakukan simpan perubahan sub-kriteria ke database
                Navigator.pop(context); // Kembali ke halaman sebelumnya
              },
              child: const Text("Simpan"),
            ),
            ElevatedButton(
              onPressed: () {
                // Lakukan penghapusan sub-kriteria dari database
                Navigator.pop(context); // Kembali ke halaman sebelumnya
              },
              child: const Text("Hapus"),
            ),
          ],
        ),
      ),
    );
  }
}
