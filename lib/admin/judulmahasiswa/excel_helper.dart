import 'package:open_file/open_file.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ExcelHelper {
  Future<void> saveDataToExcel(List<Map<String, dynamic>> data) async {
    final excel = Excel.createExcel();
    final sheet = excel['Sheet1']; // Nama sheet Excel

    // Header untuk kolom-kolom
    sheet.appendRow([
      'Nama',
      'NRP',
      'Kelas',
      'Tema',
      'Judul',
      'Deskripsi',
    ]);

    // Menambahkan data ke dalam sheet
    for (final item in data) {
      sheet.appendRow([
        item['nama'],
        item['nrp'],
        item['kelas'],
        item['tema'],
        item['judul'],
        item['deskripsi'],
      ]);
    }

    // Dapatkan direktori penyimpanan yang sesuai
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/nama_file.xlsx';

    // Menyimpan file Excel ke direktori penyimpanan yang sesuai
    final fileBytes = excel.encode();
    final file = File(filePath);
    await file.writeAsBytes(fileBytes!);

    print('File Excel berhasil disimpan di: $filePath');

    // Setelah file berhasil disimpan, buka file tersebut dengan aplikasi default
    try {
      await OpenFile.open(filePath);
    } catch (e) {
      print('Error: $e');
    }
  }
}
